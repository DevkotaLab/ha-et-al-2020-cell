source("_setup.R")
<<<<<<< HEAD

res <- "0.4"
res_ident <- paste0("RNA_snn_res.", res)

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))
results_dir <- initDir(file.path(
    "results",
    Sys.Date(),
    "seurat-wilcoxon-markers",
    res_ident
))
=======

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))
rds_dir <- initDir(file.path(rds_dir, "seurat-wilcoxon-markers"))
>>>>>>> 4d8e303f6a42663e74095ddc765c02aa6bb94271

## Enable parallelization, but not inside RStudio.
if (isTRUE(future::supportsMulticore())) {
    workers <- max(getOption("mc.cores"), 1L)
    message(paste("Enabling multiprocess with", workers, "workers."))
    future::plan("multiprocess", workers = workers)
}

resolution <- import("resolution.txt", format = "lines")

# Loop across the seurat objects to run our marker analysis
seurat_wilcoxon_marker_files <-
    invisible(vapply(
        X = seurat_clustering_files,
        FUN = function(file) {
            object <- readRDS(file)
            ## Previously, we used 0.4 in the 2018 analysis.
<<<<<<< HEAD
            Idents(object) <- res_ident
=======
            Idents(object) <- resolution
>>>>>>> 4d8e303f6a42663e74095ddc765c02aa6bb94271
            markers <- FindAllMarkers(object, test.use = "wilcox")
            outfile <- file.path(rds_dir, basename(file))
            saveRDS(markers, file = outfile)
            outfile
        },
        FUN.VALUE = character(1L)
    ))
saveData(seurat_wilcoxon_marker_files)
