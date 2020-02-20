source("_setup.R")

loadData(cellranger, dir = file.path("rds", "2020-02-02"))
cellranger_bak <- cellranger

dim(cellranger)
## [1] 25585 11153

## Using the settings from 2018 surecell analysis.
## Counts :: UMIs
min_counts <- 200
max_counts <- Inf
## Features :: genes
min_features <- 200
max_features <- Inf
## Note that the gating here is lower.
min_novelty <- 0.80
## Gated this down a little lower, to keep more cells.
max_mito_ratio <- 0.15
min_cells_per_feature <- 10



## Pre-filter ==================================================================
plotCellCounts(cellranger)

plotCountsPerCell(
    object = cellranger,
    geom = "histogram",
    min = min_counts,
    max = max_counts
)



## Test filtering ==============================================================
cellranger <- filterCells(
    object = cellranger,
    minCounts = min_counts,
    maxCounts = max_counts
)
dim(cellranger)
## [1] 25585 11153

plotFeaturesPerCell(
    object = cellranger,
    interestingGroups = "sampleName",
    geom = "histogram",
    min = min_features,
    max = max_features
)

cellranger <- filterCells(
    object = cellranger,
    minFeatures = min_features,
    maxFeatures = max_features
)
dim(cellranger)
## [1] 25575 10190

plotCellCounts(cellranger)

plotCountsVsFeatures(cellranger)

plotNovelty(
    object = cellranger,
    interestingGroups = "sampleName",
    geom = "ecdf",
    min = min_novelty
)
plotNovelty(
    object = cellranger,
    geom = "histogram",
    min = min_novelty
)

plotMitoRatio(
    object = cellranger,
    interestingGroups = "sampleName",
    geom = "ecdf",
    max = max_mito_ratio
)
plotMitoRatio(
    object = cellranger,
    geom = "histogram",
    max = max_mito_ratio
)




## Filter ======================================================================
cellranger <- cellranger_bak
dim(cellranger)
## [1] 25585 11153
cellranger_filtered <- filterCells(
    object = cellranger,
    minCounts = min_counts,
    maxCounts = max_counts,
    minFeatures = min_features,
    maxFeatures = max_features,
    minNovelty = min_novelty,
    maxMitoRatio = max_mito_ratio,
    minCellsPerFeature = min_cells_per_feature
)
dim(cellranger_filtered)
## [1] 19240  8183
saveData(cellranger_filtered)



## Post-filter =================================================================
## These are the same number of cells as the original 2018 analysis.
pdf(
    file = file.path(results_dir, "cellranger-filtered.pdf"),
    width = 10,
    height = 10
)

plotCellCounts(cellranger_filtered)

plotCountsPerCell(
    object = cellranger_filtered,
    interestingGroups = "sampleName",
    geom = "ecdf"
)
plotCountsPerCell(
    object = cellranger_filtered,
    interestingGroups = "sampleName",
    geom = "violin"
)
plotCountsPerCell(
    object = cellranger_filtered,
    geom = "histogram"
)

plotFeaturesPerCell(
    object = cellranger_filtered,
    interestingGroups = "sampleName",
    geom = "ecdf"
)
plotFeaturesPerCell(
    object = cellranger_filtered,
    interestingGroups = "sampleName",
    geom = "violin"
)
plotFeaturesPerCell(
    object = cellranger_filtered,
    geom = "histogram"
)

plotCountsVsFeatures(cellranger_filtered)

plotNovelty(
    object = cellranger_filtered,
    interestingGroups = "sampleName",
    geom = "ecdf"
)
plotNovelty(
    object = cellranger_filtered,
    geom = "histogram"
)

plotMitoRatio(
    object = cellranger_filtered,
    interestingGroups = "sampleName",
    geom = "ecdf"
)
dev.off()
