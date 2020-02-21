source("_setup.R")

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))

file <- seurat_clustering_files[[1]]
object <- readRDS(file)

resolution <- import("resolution.txt")

## Be sure to match this in the marker script.
Idents(object) <- resolution
plotUMAP(object)
plotTSNE(object)





## > help("Idents", "Seurat")
SetIdent

seurat <- SetAllIdent(seurat, id = "res.0.4")

plotTSNE(object)
plotUMAP(object)
