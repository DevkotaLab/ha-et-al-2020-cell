## Use MAST method to find the markers (rather than Wilcoxon default).
## Updated 2020-04-30.

source("_setup.R")

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))
rds_dir <- initDir(file.path(rds_dir, "seurat-mast-markers"))

## Enable parallelization, but not inside RStudio.
if (isTRUE(future::supportsMulticore())) {
    workers <- max(getOption("mc.cores"), 1L)
    message(paste("Enabling multiprocess with", workers, "workers."))
    future::plan("multiprocess", workers = workers)
}

resolution <- import("resolution.txt", format = "lines")

# Loop across the seurat objects to run our marker analysis
seurat_mast_marker_files <-
    invisible(vapply(
        X = seurat_clustering_files,
        FUN = function(file) {
            object <- readRDS(file)
            validObject(object)
            ## Previously, we used 0.4 in the 2018 analysis.
            Idents(object) <- resolution
            markers <- FindAllMarkers(object, test.use = "MAST")
            outfile <- file.path(rds_dir, basename(file))
            saveRDS(markers, file = outfile)
            outfile
        },
        FUN.VALUE = character(1L)
    ))
saveData(seurat_mast_marker_files)
