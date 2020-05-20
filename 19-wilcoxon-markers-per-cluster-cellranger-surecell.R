source("_setup.R")

cellranger_all_wilcoxon_markers <- readRDS(file.path(
    "rds",
    "2020-05-19",
    "cellranger_all_wilcoxon_markers.rds"
))
surecell_all_wilcoxon_markers <- readRDS(file.path(
    "rds",
    "2020-04-30",
    "seurat-wilcoxon-markers",
    "surecell_condition_cd_seurat.rds"
))

loadData(cellranger, surecell, dir = file.path("rds", "2020-02-02"))
cellranger_granges <- rowRanges(cellranger)
surecell_granges <- rowRanges(surecell)

cellranger_all_wilcoxon_markers <- SeuratMarkersPerCluster(
    object = cellranger_all_wilcoxon_markers,
    ranges = convertGenesToSymbols(cellranger_granges),
)
saveData(cellranger_all_wilcoxon_markers)

surecell_all_wilcoxon_markers <- SeuratMarkersPerCluster(
    object = surecell_all_wilcoxon_markers,
    ranges = convertGenesToSymbols(surecell_granges),
)
saveData(surecell_all_wilcoxon_markers)
