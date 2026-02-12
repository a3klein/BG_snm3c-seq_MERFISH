#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(argparse)
  library(arrow)
  library(tradeSeq)
  library(SingleCellExperiment)
})

# ───────────────────────────────────────────────────────────────
# Parse arguments
# ───────────────────────────────────────────────────────────────
parser <- ArgumentParser()
parser$add_argument("--expr", required=TRUE,
                    help="Feather file: genes x cells (first column = gene)")
parser$add_argument("--axis", required=TRUE,
                    help="Feather file: axis values per cell")
parser$add_argument("--out", required=TRUE,
                    help="Output CSV")
parser$add_argument("--nknots", default=6, type="integer")
parser$add_argument("--num_cores", default=4, type="integer")
args <- parser$parse_args()

expr_file <- args$expr
axis_file <- args$axis
out_file  <- args$out
nknots    <- args$nknots
ncores    <- args$num_cores

cat(">>> Loading inputs...\n")

# ───────────────────────────────────────────────────────────────
# Load Feather files
# expr = genes x cells
# axis = per-cell pseudotime
# ───────────────────────────────────────────────────────────────
expr_df <- arrow::read_feather(expr_file)
axis_df <- arrow::read_feather(axis_file)

# expr_df must have column "gene" 
if (!"gene" %in% names(expr_df)) {
  stop("Expression feather must have a column named 'gene'")
}

# Convert to matrix
genes <- expr_df$gene
expr_mat <- as.matrix(expr_df[ , setdiff(names(expr_df), "gene"), drop=FALSE])
rownames(expr_mat) <- genes

# axis_df must have columns: "cell", "axis"
if (!all(c("cell", "axis") %in% names(axis_df))) {
  stop("Axis feather must have columns: cell, axis")
}

axis_vec <- axis_df$axis

# tradeSeq requires:
#   counts = genes x cells
#   pseudotime = matrix(n_cells x 1)
#   cellWeights = matrix(n_cells x 1)
pt <- matrix(axis_vec, ncol=1)
cw <- matrix(1, nrow=length(axis_vec), ncol=1)

# ───────────────────────────────────────────────────────────────
# Fit GAM
# ───────────────────────────────────────────────────────────────
cat(">>> Fitting tradeSeq GAM...\n")

sce <- NULL
try({
  sce <- fitGAM(
    counts = expr_mat,
    pseudotime = pt,
    cellWeights = cw,
    nknots = nknots,
    verbose = FALSE,
    BPPARAM = BiocParallel::MulticoreParam(ncores)
  )
}, silent = TRUE)

if (is.null(sce)) {
  cat(">>> tradeSeq model failed, returning empty output.\n")
  write.csv(data.frame(
    gene = character(),
    association_pvalue = numeric(),
    end_test_pvalue = numeric()
  ), file=out_file, row.names=FALSE)
  quit(save="no", status=0)
}

# ───────────────────────────────────────────────────────────────
# Extract p-values
# ───────────────────────────────────────────────────────────────
cat(">>> Running tests...\n")

assoc <- NULL
end <- NULL

try({
  assoc <- associationTest(sce)
  end   <- startVsEndTest(sce, pseudotimeValues = c(0.1, 0.9))
}, silent = TRUE)

if (is.null(assoc) || is.null(end)) {
  cat(">>> tradeSeq test extraction failed, returning empty.\n")
  write.csv(data.frame(
    gene = character(),
    association_pvalue = numeric(),
    end_test_pvalue = numeric()
  ), file=out_file, row.names=FALSE)
  quit(save="no", status=0)
}

# Ensure correct ordering
assoc <- assoc[rownames(expr_mat), , drop=FALSE]
end   <- end[rownames(expr_mat), , drop=FALSE]

# ───────────────────────────────────────────────────────────────
# Output CSV
# ───────────────────────────────────────────────────────────────
res <- data.frame(
  gene = rownames(expr_mat),
  association_pvalue = assoc$pvalue,
  end_test_pvalue = end$pvalue
)

write.csv(res, out_file, row.names=FALSE)
cat(">>> Done. Output written to: ", out_file, "\n")
