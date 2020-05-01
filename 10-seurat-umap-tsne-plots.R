source("_setup.R")

<<<<<<< HEAD
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
=======
umap_results_dir <- initDir(file.path(results_dir, "umap-plots"))
tsne_results_dir <- initDir(file.path(results_dir, "tsne-plots"))

resolution <- import("resolution.txt", format = "lines")

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))
## Strip out the absolute URL from the file list.
parent_dir_pattern <-
    seurat_clustering_files %>%
    .[[1L]] %>%
    str_extract(
        string = .,
        pattern = "^.+/rds/"
    ) %>%
    dirname() %>%
    paste0("^", ., "/")
seurat_clustering_files %<>%
    gsub(
        pattern = parent_dir_pattern,
        replacement = "",
        x = .
    ) %>%
    realpath()
saveData(seurat_clustering_files)

invisible(lapply(
    X = seurat_clustering_files,
    FUN = function(file) {
        object <- readRDS(file)
        Idents(object) <- resolution
        stopifnot(is.factor(Idents(object)))
        title <- basenameSansExt(file)
        message(paste0("Plotting ", title, "."))
        labels <- list(title = title)
        p <- plotUMAP(object, labels = labels)
        outfile <- paste0(title, ".pdf")
        ggsave(
            filename = file.path(umap_results_dir, outfile),
            plot = p
        )
        p <- plotTSNE(object, labels = labels)
        ggsave(
            filename = file.path(tsne_results_dir, outfile),
            plot = p
        )
        file
    }
>>>>>>> 4d8e303f6a42663e74095ddc765c02aa6bb94271
))
