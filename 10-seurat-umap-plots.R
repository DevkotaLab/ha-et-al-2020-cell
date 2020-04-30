source("_setup.R")

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))

basename(seurat_clustering_files)
##  [1] "cellranger_a04_seurat.rds"        "cellranger_a16_seurat.rds"
##  [3] "cellranger_d1_seurat.rds"         "cellranger_h1_seurat.rds"
##  [5] "surecell_cd11h_seurat.rds"        "surecell_cd11i_seurat.rds"
##  [7] "surecell_cd3h_seurat.rds"         "surecell_cd3i_seurat.rds"
##  [9] "surecell_cd5h_seurat.rds"         "surecell_cd5i_seurat.rds"
## [11] "surecell_uc4h_seurat.rds"         "surecell_uc4i_seurat.rds"
## [13] "surecell_uc6h_seurat.rds"         "surecell_uc6i_seurat.rds"
## [15] "surecell_condition_cd_seurat.rds" "surecell_condition_uc_seurat.rds"

file <- seurat_clustering_files[[1]]
object <- readRDS(file)




## Be sure to match this in the marker script.
Idents(object) <- "RNA_snn_res.0.6"
plotUMAP(object)
plotTSNE(object)





## > help("Idents", "Seurat")
SetIdent

seurat <- SetAllIdent(seurat, id = "res.0.4")
plotTSNE(object)
plotUMAP(object)
