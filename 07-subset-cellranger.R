source("_setup.R")

## Extract per-sample data subsets.

## Use our all samples filtered dataset
loadData(cellranger_filtered, dir = file.path("rds", "2020-02-19"))

unname(sampleNames(cellranger_filtered))
## [1] "A04" "A16" "D1"  "H1"

## Per sample ==================================================================
cellranger_per_sample <- subsetPerSample(
    object = cellranger_filtered,
    assignAndSave = TRUE,
    dir = file.path("rds", Sys.Date(), "cellranger")
)
saveData(cellranger_per_sample)
