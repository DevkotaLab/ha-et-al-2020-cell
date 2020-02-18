source("_setup.R")

loadData(surecell, dir = file.path("rds", "2020-02-02"))

dim(surecell)
## [1]  24600 105071

## Using the settings from 2018 analysis.
n_cells <- Inf
## Counts :: UMIs
min_counts <- 200
max_counts <- Inf
## Features :: genes
min_features <- 200
max_features <- Inf
min_novelty <- 0.85
max_mito_ratio <- 0.1
min_cells_per_gene <- 10

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



## Filter ======================================================================
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
    geom = "violin",
    min = min_novelty
)



## Post-filter =================================================================
