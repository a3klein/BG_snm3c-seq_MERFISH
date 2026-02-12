#!/usr/bin/env Rscript

# Wrote this with help form ChatGPT to make SPARK-X run work in my environment setup. 
# Either want to add this as its current usage to SPIDA or reimplement the SPARK-X algorithm in python (SPIDA) directly! 

suppressPackageStartupMessages({
  library(argparse)
  library(SPARK)
})

# Try to load Arrow (optional dependency)
suppressWarnings({
  has_arrow <- requireNamespace("arrow", quietly = TRUE)
  if (has_arrow) library(arrow)
})


# Parsing Arguments 
parser <- ArgumentParser(description = "Run SPARK-X safely on expression + spatial data (auto CSV/Feather detection)")
parser$add_argument("--expr", required = TRUE,
                    help = "Path to expression file (CSV or Feather: genes × cells)")
parser$add_argument("--coords", required = TRUE,
                    help = "Path to coordinate file (CSV or Feather: cells × 2)")
parser$add_argument("--out", required = TRUE,
                    help = "Path to output CSV file")
parser$add_argument("--min_cells", type = "integer", default = 50,
                    help = "Minimum number of cells to run SPARK-X")
parser$add_argument("--num_cores", type = "integer", default = 1,
                    help = "Number of CPU cores for SPARK-X")
args <- parser$parse_args()

# Helper function for detecting if the input file is CSV or Feather/Parquet and reading accordingly
read_auto <- function(path) {
  ext <- tolower(tools::file_ext(path))
  if (ext %in% c("feather", "arrow", "parquet")) {
    if (!has_arrow) stop("arrow package not installed, cannot read Feather/Parquet files.")
    message(sprintf("Reading Feather/Arrow file: %s", path))
    df <- arrow::read_feather(path)
  } else if (ext == "csv") {
    message(sprintf("Reading CSV file: %s", path))
    df <- read.csv(path, row.names = 1, check.names = FALSE)
  } else {
    stop(sprintf("Unsupported file format: %s", ext))
  }
  return(df)
}

# OLD FOR READING .RDS files (does not work for big data)
# expr_mat <- readRDS(args$expr)
# coords_df <- readRDS(args$coords)
# expr_mat <- as.matrix(expr_mat)

# ---------- Read input ----------
# expr_mat <- as.matrix(read.csv(args$expr, row.names = 1, check.names = FALSE))
# coords_df <- read.csv(args$coords, row.names = 1, check.names = FALSE)

expr_input <- read_auto(args$expr)
coords_input <- read_auto(args$coords)

# Handle expression matrix
if ("gene" %in% colnames(expr_input)) {
  # Feather format: genes × cells with 'gene' column
  gene_names <- expr_input$gene
  expr_input$gene <- NULL
  expr_mat <- as.matrix(expr_input)
  rownames(expr_mat) <- gene_names
} else {
  # CSV format: already has rownames
  expr_mat <- as.matrix(expr_input)
}

# Handle coordinates
if ("cell" %in% colnames(coords_input)) {
  coords_input$cell <- NULL
}
coords_df <- as.data.frame(coords_input)
colnames(coords_df)[1:2] <- c("x", "y")


message(sprintf("Loaded expression: %d genes × %d cells", nrow(expr_mat), ncol(expr_mat)))
message(sprintf("Loaded coords: %d rows × %d cols", nrow(coords_df), ncol(coords_df)))

# Sanity checks
if (ncol(expr_mat) < args$min_cells) {
  message(sprintf("Too few cells (%d < %d), skipping.", ncol(expr_mat), args$min_cells))
  quit(save = "no", status = 0)
}

# Ensure coordinates match cells
if (nrow(coords_df) != ncol(expr_mat)) {
  stop("Number of coordinates does not match number of cells.")
}

# Clean expression and coordinates before sparkx()

# Replace NA, NaN, Inf with zeros in expression
expr_mat[!is.finite(expr_mat)] <- 0

# Drop all-zero rows again after cleaning
expr_mat <- expr_mat[rowSums(expr_mat) > 0, , drop = FALSE]
# Drop genes with no variance
expr_mat <- expr_mat[apply(expr_mat, 1, var, na.rm = TRUE) > 0, , drop = FALSE]
# Optional: remove genes expressed in very few cells (<5)
expr_mat <- expr_mat[rowSums(expr_mat > 0) >= 5, , drop = FALSE]

# Clean coordinates: remove NAs/Infs and reindex
coords_df <- as.data.frame(coords_df)
if (ncol(coords_df) < 2) {
  stop("coords_df must have at least 2 columns (x, y).")
}
coords_df[!is.finite(coords_df$x), "x"] <- 0
coords_df[!is.finite(coords_df$y), "y"] <- 0

# If any NA rows remain, drop them
good_rows <- complete.cases(coords_df)
expr_mat <- expr_mat[, good_rows, drop = FALSE]
coords_df <- coords_df[good_rows, , drop = FALSE]

# Tiny jitter to prevent singular kernels
coords_df$x <- coords_df$x + rnorm(nrow(coords_df), 0, 1e-6)
coords_df$y <- coords_df$y + rnorm(nrow(coords_df), 0, 1e-6)

if (nrow(expr_mat) == 0) {
  message("No genes remaining after filtering — skipping.")
  quit(save = "no", status = 0)
}

# Run SPARK-X with safety wrapper
res_df <- tryCatch({
  message(sprintf("Running SPARK-X on %d genes × %d cells...", nrow(expr_mat), ncol(expr_mat)))
  sparkx_res <- sparkx(expr_mat, coords_df,
                       numCores = args$num_cores,
                       option = "mixture")

  df <- as.data.frame(sparkx_res$res_mtest)
  df$gene <- rownames(df)
  df <- df[, c("gene", "combinedPval", "adjustedPval")]
  colnames(df) <- c("gene", "combined_pvalue", "adjusted_pvalue")
  df

}, error = function(e) {
  message("SPARK-X failed: ", conditionMessage(e))
  message("Returning empty result table.")
  data.frame(gene = character(),
             combined_pvalue = numeric(),
             adjusted_pvalue = numeric())
})

# Write results
write.csv(res_df, file = args$out, row.names = FALSE, quote = FALSE)
message(sprintf("Output written to %s (%d genes)", args$out, nrow(res_df)))