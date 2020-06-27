## Re-run Seurat clustering on all SureCell samples combined.
## Updated 2020-06-27.

source("_setup.R")

## Use our all samples filtered dataset.
loadData(surecell_filtered, dir = file.path("rds", "2020-02-19"))
stopifnot(validObject(surecell_filtered))

class(surecell_filtered)
## [1] "bcbioSingleCell"
## attr(,"package")
## [1] "bcbioSingleCell"

sce <- surecell_filtered
stopifnot(is(sce, "SingleCellExperiment"))
sce <- convertGenesToSymbols(sce)

## Coerce bcbioSingleCell SingleCellExperiment object to Seurat.
## Refer to bcbioSingleCell and pointillism packages for details.
seurat <- as(sce, "Seurat")
## Using wrapper function defined in pointillism.

## NOTE: The following features are not present in the object: CDC25C,
## not searching for symbol synonyms
seurat <- runSeurat(seurat, umapMethod = "uwot")
assignAndSaveData(
    name = "surecell_all_samples_seurat",
    object = seurat
)
