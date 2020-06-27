## Export GSEA tables to disk in CSV format.
## Updated 2020-05-22.

source("_setup.R")
library(acidgsea)  # 0.3.0

## Export the GSEA tables.
loadData(gsea, dir = file.path("rds", "2020-05-22"))
export(
    object = gsea,
    dir = file.path(results_dir, "gsea")
)

## Export the corresponding DEGLRT tables.
loadData(
    cellranger_edger_lfc_matrix,
    surecell_edger_lfc_matrix,
    dir = file.path("rds", "2020-05-22")
)

## Improve the column name sorting for export.
colnames(cellranger_edger_lfc_matrix) <-
    autopadZeros(paste0("cluster_", colnames(cellranger_edger_lfc_matrix)))
cellranger_edger_lfc_matrix <-
    cellranger_edger_lfc_matrix[, sort(colnames(cellranger_edger_lfc_matrix))]
export(
    object = cellranger_edger_lfc_matrix,
    dir = results_dir
)

colnames(surecell_edger_lfc_matrix) <-
    autopadZeros(paste0("cluster_", colnames(surecell_edger_lfc_matrix)))
surecell_edger_lfc_matrix <-
    surecell_edger_lfc_matrix[, sort(colnames(surecell_edger_lfc_matrix))]
export(
    object = surecell_edger_lfc_matrix,
    dir = results_dir
)
