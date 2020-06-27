## Generate UMAP and tSNE plots.
## Updated 2020-04-30.

source("_setup.R")

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
))
