source("_setup.R")

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))

basenameSansExt(seurat_clustering_files)
##  [1] "cellranger_a04_seurat"        "cellranger_a16_seurat"
##  [3] "cellranger_d1_seurat"         "cellranger_h1_seurat"
##  [5] "surecell_cd11h_seurat"        "surecell_cd11i_seurat"
##  [7] "surecell_cd3h_seurat"         "surecell_cd3i_seurat"
##  [9] "surecell_cd5h_seurat"         "surecell_cd5i_seurat"
## [11] "surecell_uc4h_seurat"         "surecell_uc4i_seurat"
## [13] "surecell_uc6h_seurat"         "surecell_uc6i_seurat"
## [15] "surecell_condition_cd_seurat" "surecell_condition_uc_seurat"

res <- 0.4
res_ident <- paste0("RNA_snn_res.", res)

## Loop across each Seurat object and generate UMAP/TSNE plots.
invisible(mapply(
    name = basenameSansExt(seurat_clustering_files),
    file = seurat_clustering_files,
    function(name, file) {
        message(name)
        object <- readRDS(file)
        validObject(object)
        height <- 10L
        width <- 10L
        print(res_ident)
        Idents(object) <- res_ident
        ## Alternative approach:
        ## > object <- SetIdent(object, value = res_ident)
        ggsave(
            filename = file.path(
                results_dir,
                paste0(name, "_", res, "_umap.pdf")
            ),
            plot = plotUMAP(object),
            height = height,
            width = width
        )
        ggsave(
            filename = file.path(
                results_dir,
                paste0(name, "_", res, "_tsne.pdf")
            ),
            plot = plotTSNE(object),
            height = height,
            width = width
        )
    },
    SIMPLIFY = FALSE
))
