#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(argparse)
  library(arrow)
  library(MorphoGAM)
  library(dplyr)
  library(mgcv)
})

parser <- ArgumentParser()
parser$add_argument("--expr", required=TRUE)
parser$add_argument("--axis", required=TRUE)
parser$add_argument("--out", required=TRUE)
args <- parser$parse_args()

expr_file <- args$expr
axis_file <- args$axis
out_file  <- args$out

MAX_CELLS <- 3000
DOWNSAMPLE_SEED <- 123

cat(">>> Loading inputs...\n")

# ---------------------------------------------------------------
# Expression matrix
# ---------------------------------------------------------------
expr_df <- arrow::read_feather(expr_file)

if (!"gene" %in% colnames(expr_df)) {
  stop("Expression feather must contain a 'gene' column.")
}

genes <- expr_df$gene
expr_mat <- as.matrix(expr_df[, setdiff(colnames(expr_df), "gene"), drop=FALSE])
rownames(expr_mat) <- genes
cells <- colnames(expr_mat)

# ---------------------------------------------------------------
# Axis data
# ---------------------------------------------------------------
axis_df <- arrow::read_feather(axis_file)

required_cols <- c("cell", "t", "volume")
missing_cols <- setdiff(required_cols, colnames(axis_df))
if (length(missing_cols) > 0) {
  stop("Axis feather missing columns: ", paste(missing_cols, collapse=", "))
}

axis_df <- axis_df[match(cells, axis_df$cell), ]

if (any(is.na(axis_df$cell))) {
  stop("Axis feather missing some cells present in expr.")
}

t_coord <- axis_df$t
volume  <- axis_df$volume

if (any(is.na(t_coord))) {
  stop("NA in axis column 't'.")
}
if (any(is.na(volume)) || any(volume <= 0)) {
  stop("Volume must be >0 and non-missing.")
}

# ---------------------------------------------------------------
# Downsampling
# ---------------------------------------------------------------
n_cells <- length(t_coord)

if (n_cells > MAX_CELLS) {
  set.seed(DOWNSAMPLE_SEED)
  keep_idx <- sort(sample(seq_len(n_cells), MAX_CELLS, replace=FALSE))

  expr_mat <- expr_mat[, keep_idx, drop=FALSE]
  t_coord  <- t_coord[keep_idx]
  volume   <- volume[keep_idx]
  cells    <- cells[keep_idx]

  cat(">>> Downsampled from ", n_cells, " to ", MAX_CELLS, " cells\n")
} else {
  cat(">>> No downsampling needed (", n_cells, " cells)\n", sep="")
}

# ---------------------------------------------------------------
# Variance stabilization + offset
# ---------------------------------------------------------------
Y_transformed <- log1p(expr_mat)
log_offset <- log(volume)

# ---------------------------------------------------------------
# curve.fit: jittered r to avoid IRLBA failures
# ---------------------------------------------------------------
set.seed(123)
curve_fit <- list(
  xyt = data.frame(
    t = t_coord,
    r = rnorm(length(t_coord), mean=0, sd=1e-6)
  )
)

# ---------------------------------------------------------------
# Design formula
# ---------------------------------------------------------------
design_formula <- y ~ s(t, bs="cr")

cat(">>> Running MorphoGAM with offset + shrinkage...\n")

mgam <- NULL

err <- try({
  mgam <- MorphoGAM(
    Y         = Y_transformed,
    curve.fit = curve_fit,
    design    = design_formula,
    offset    = log_offset,
    shrinkage = TRUE,
    min.count.per.gene = 5,
    return.fx = TRUE
  )
}, silent = TRUE)

# ---------------------------------------------------------------
# Error handling
# ---------------------------------------------------------------
if (inherits(err, "try-error") || is.null(mgam) || is.null(mgam$results)) {

  cat("MorphoGAM failed, returning empty output.\n")

  empty_out <- data.frame(
    gene=character(),
    pv.t=numeric(),
    fdr_t=numeric(),
    peak.t=numeric(),
    range.t=numeric(),
    intercept=numeric(),
    rho=numeric()
  )

  write.csv(empty_out, out_file, row.names=FALSE)
  quit(save="no", status=0)
}

# ---------------------------------------------------------------
# Processing results
# ---------------------------------------------------------------
res <- mgam$results

if (!"gene" %in% names(res)) {
  res$gene <- rownames(res)
}

# ---------------------------------------------------------------
# Per-replicate FDR
# ---------------------------------------------------------------
if ("pv.t" %in% names(res)) {
  res$fdr_t <- p.adjust(res$pv.t, method="BH")
} else {
  res$fdr_t <- NA_real_
}

# ---------------------------------------------------------------
# Directionality (rho)
# ---------------------------------------------------------------
cat(">>> Computing rho...\n")

fx <- mgam$fxs.t
rho_vals <- rep(NA_real_, nrow(Y_transformed))

if (!is.null(fx) && length(dim(fx)) == 2) {

  # ensure fx is genes × cells
  if (nrow(fx) == ncol(Y_transformed) && ncol(fx) == nrow(Y_transformed)) {
    fx <- t(fx)
  }

  if (all(dim(fx) == dim(Y_transformed))) {
    rho_vals <- apply(fx, 1, function(fg) {
      suppressWarnings(cor(as.numeric(fg), t_coord,
                           use="pairwise.complete.obs"))
    })
  }
}

res$rho <- rho_vals

# ---------------------------------------------------------------
# Save output
# ---------------------------------------------------------------
out <- res %>%
  dplyr::select(
    gene,
    any_of(c("pv.t", "fdr_t", "peak.t", "range.t", "intercept")),
    rho
  )

write.csv(out, out_file, row.names=FALSE)
cat(">>> Done. Output written to: ", out_file, "\n")
