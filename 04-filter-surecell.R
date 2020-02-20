source("_setup.R")

loadData(surecell, dir = file.path("rds", "2020-02-02"))
surecell_bak <- surecell

dim(surecell)
## [1]  24600 105071

## Using the settings from 2018 analysis.
## Counts :: UMIs
min_counts <- 200
max_counts <- Inf
## Features :: genes
min_features <- 200
max_features <- Inf
min_novelty <- 0.85
max_mito_ratio <- 0.1
min_cells_per_feature <- 10



## Pre-filter ==================================================================
plotCellCounts(surecell)

## Note that this takes a long time to plot.
plotReadsPerCell(
    object = surecell,
    geom = "histogram",
    interestingGroups = "sampleName"
)

## Note that this takes a long time to plot.
plotReadsPerCell(
    object = surecell,
    geom = "histogram",
    interestingGroups = "sampleName"
) +
    facet_wrap(vars(patientID))

plotReadsPerCell(
    object = surecell,
    geom = "ecdf",
    interestingGroups = "sampleName"
)

plotCountsPerCell(
    object = surecell,
    geom = "violin",
    min = min_umis,
    max = max_umis
)



## Test filtering ==============================================================
surecell <- filterCells(
    object = surecell,
    minCounts = min_counts,
    maxCounts = max_counts
)
dim(surecell)
## [1] 24162 55074

plotCellCounts(surecell)

plotCountsPerCell(
    object = surecell,
    geom = "histogram",
    interestingGroups = "sampleName",
    min = min_counts,
    max = max_counts
)

plotFeaturesPerCell(
    object = surecell,
    geom = "violin",
    min = min_features,
    max = max_features
)

surecell <- filterCells(
    object = surecell,
    minFeatures = min_features,
    maxFeatures = max_features
)
dim(surecell)
## [1] 23650  8406

plotCellCounts(surecell)

plotCountsVsFeatures(surecell)

plotNovelty(
    object = surecell,
    geom = "histogram",
    min = min_novelty
)

plotMitoRatio(
    object = surecell,
    geom = "histogram",
    max = max_mito_ratio
)



## Filter ======================================================================
surecell <- surecell_bak
dim(surecell)
## [1]  24600 105071
surecell_filtered <- filterCells(
    object = surecell,
    minCounts = min_counts,
    maxCounts = max_counts,
    minFeatures = min_features,
    maxFeatures = max_features,
    minNovelty = min_novelty,
    maxMitoRatio = max_mito_ratio,
    minCellsPerFeature = min_cells_per_feature
)
dim(surecell_filtered)
## [1] 18132  7554
saveData(surecell_filtered)



## Post-filter =================================================================
## These are the same number of cells as the original 2018 analysis.
pdf(
    file = file.path(results_dir, "surecell-filtered.pdf"),
    width = 10,
    height = 10
)

plotCellCounts(surecell_filtered)

plotCountsPerCell(
    object = surecell_filtered,
    interestingGroups = "sampleName",
    geom = "ecdf"
)
plotCountsPerCell(
    object = surecell_filtered,
    interestingGroups = "sampleName",
    geom = "violin"
)
plotCountsPerCell(
    object = surecell_filtered,
    geom = "histogram"
)

plotFeaturesPerCell(
    object = surecell_filtered,
    interestingGroups = "sampleName",
    geom = "ecdf"
)
plotFeaturesPerCell(
    object = surecell_filtered,
    interestingGroups = "sampleName",
    geom = "violin"
)
plotFeaturesPerCell(
    object = surecell_filtered,
    geom = "histogram"
)

plotCountsVsFeatures(surecell_filtered)

plotNovelty(
    object = surecell_filtered,
    interestingGroups = "sampleName",
    geom = "ecdf"
)
plotNovelty(
    object = surecell_filtered,
    geom = "histogram"
)

plotMitoRatio(
    object = surecell_filtered,
    interestingGroups = "sampleName",
    geom = "ecdf"
)
dev.off()
