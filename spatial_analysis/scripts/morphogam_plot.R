#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(argparse)
  library(arrow)
  library(mgcv)
  library(dplyr)
})

parser <- ArgumentParser()
parser$add_argument("--expr", required = TRUE,
                    help = "Feather: genes x cells (first column = gene)")
parser$add_argument("--axis", required = TRUE,
                    help = "Feather: axis file with columns: cell, t")
parser$add_argument("--genes", required = TRUE,
                    help = "Text file: one gene per line")
parser$add_argument("--out", required = TRUE,
                    help = "Output CSV with columns: gene, t, fitted")
parser$add_argument("--family", default = "nb",
                    help = "mgcv family: 'nb' or 'poisson' or 'gaussian'")
args <- parser$parse_args()

expr_file <- args$expr
axis_file <- args$axis
genes_file <- args$genes
out_file <- args$out
family_str <- args$family

expr_df <- arrow::read_feather(expr_file)
if (!"gene" %in% names(expr_df)) {
  stop("expr.feather must contain a 'gene' column")
}
genes <- expr_df$gene
expr_mat <- as.matrix(expr_df[, setdiff(names(expr_df), "gene"), drop = FALSE])
rownames(expr_mat) <- genes
cells <- colnames(expr_mat)

axis_df <- arrow::read_feather(axis_file)
if (!all(c("cell", "t") %in% names(axis_df))) {
  stop("axis.feather must have columns: cell, t")
}
axis_df <- axis_df[match(cells, axis_df$cell), ]
t_coord <- axis_df$t

predict_genes <- readLines(genes_file)
predict_genes <- predict_genes[predict_genes %in% rownames(expr_mat)]

if (length(predict_genes) == 0) {
  write.csv(data.frame(gene = character(), t = numeric(), fitted = numeric()),
            out_file, row.names = FALSE)
  quit(save = "no", status = 0)
}

fam <- switch(
  family_str,
  "gaussian" = gaussian(),
  "poisson"  = poisson(),
  "nb"       = nb(),
  nb()  # default
)

t_grid <- seq(min(t_coord), max(t_coord), length.out = 200)

all_preds <- lapply(predict_genes, function(g) {
  y <- as.numeric(expr_mat[g, ])

  # basic GAM along t (no covariates – consistent with your 1D axis use)
  df <- data.frame(y = y, t = t_coord)
  fit <- try(gam(y ~ s(t, bs = "cr"), data = df, family = fam), silent = TRUE)
  if (inherits(fit, "try-error")) return(NULL)

  pred <- predict(fit, newdata = data.frame(t = t_grid), type = "response")
  data.frame(gene = g, t = t_grid, fitted = pred)
})

pred_df <- bind_rows(all_preds)
write.csv(pred_df, out_file, row.names = FALSE)
cat(">>> Wrote fitted curves for ", length(predict_genes), " genes\n")
