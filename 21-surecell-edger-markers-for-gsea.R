source("_setup.R")

surecell <- readRDS(file.path(
    "rds",
    "2020-02-20",
    "seurat-clustering",
    "surecell_condition_cd_seurat.rds"
))

## Set the resolution.
resolution <- import("resolution.txt", format = "lines")
Idents(surecell) <- resolution

surecell_edger_markers <- findMarkers(
    object = surecell,
    caller = "edgeR"
)
saveData(surecell_edger_markers)
