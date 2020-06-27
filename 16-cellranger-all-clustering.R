## Re-run Seurat clustering on all Cell Ranger samples combined.
## Updated 2020-06-27.

source("_setup.R")

## Use our all samples filtered dataset
loadData(cellranger_filtered, dir = file.path("rds", "2020-02-19"))
stopifnot(validObject(cellranger_filtered))

class(cellranger_filtered)
## [1] "CellRanger"
## attr(,"package")
## [1] "Chromium

sce <- cellranger_filtered
stopifnot(is(sce, "SingleCellExperiment"))
sce <- convertGenesToSymbols(sce)

## Coerce Cell Ranger SingleCellExperiment object to Seurat.
## Refer to Chromium and pointillism packages for details.
seurat <- as(sce, "Seurat")
## Using wrapper function defined in pointillism.
seurat <- runSeurat(seurat, umapMethod = "umap-learn")
assignAndSaveData(
    name = "cellranger_all_samples_seurat",
    object = seurat
)
