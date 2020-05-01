source("_setup.R")

# Using MAST method to find the markers, rather than Wilcoxon.
library(MAST)  # 1.14.0

res <- "0.4"
res_ident <- paste0("RNA_snn_res.", res)

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))
results_dir <- initDir(file.path(
    "results",
    Sys.Date(),
    "seurat-mast-markers",
    res_ident
))

## Enable parallelization, but not inside RStudio.
if (isTRUE(future::supportsMulticore())) {
    workers <- max(getOption("mc.cores"), 1L)
    message(paste("Enabling multiprocess with", workers, "workers."))
    future::plan("multiprocess", workers = workers)
}

# Loop across the seurat objects to run our marker analysis
seurat_mast_marker_files <-
    invisible(vapply(
        X = seurat_clustering_files,
        FUN = function(file) {
            object <- readRDS(file)
            validObject(object)
            ## Previously, we used 0.4 in the 2018 analysis.
            Idents(object) <- res_ident
            markers <- FindAllMarkers(object, test.use = "MAST")
            outfile <- file.path(results_dir, basename(file))
            saveRDS(markers, file = outfile)
            outfile
        },
        FUN.VALUE = character(1L)
    ))
saveData(seurat_mast_marker_files)
