source("_setup.R")

cellranger <- readRDS(file.path(
    "rds",
    "2020-05-18",
    "cellranger_all_samples_seurat.rds"
))

## Set the resolution.
resolution <- import("resolution.txt", format = "lines")
Idents(cellranger) <- resolution

clusters <- levels(clusters(cellranger))
lapply(
    X = clusters,
    FUN = function(cluster) {
        message(paste("Cluster", cluster))
        out <- findMarkers(
            object = cellranger,
            clusters = cluster,
            caller = "edgeR"
        )
        assignAndSaveData(
            name = paste0("cellranger_edger_cluster_", cluster, "_markers"),
            object = out
        )
    }
)
