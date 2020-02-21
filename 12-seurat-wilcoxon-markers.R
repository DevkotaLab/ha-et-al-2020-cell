source("_setup.R")
library(Seurat)

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))
results_dir <- initDir(file.path("results", Sys.Date(), "seurat-wilcoxon-markers"))

## Enable parallelization, but not inside RStudio.
if (isTRUE(future::supportsMulticore())) {
    workers <- max(getOption("mc.cores"), 1L)
    message(paste("Enabling multiprocess with", workers, "workers."))
    future::plan("multiprocess", workers = workers)
}

# Loop across the seurat objects to run our marker analysis
seurat_wilcoxon_marker_files <-
    invisible(vapply(
        X = seurat_clustering_files,
        FUN = function(file) {
            object <- readRDS(file)
            ## Now using 0.6 resolution.
            ## Previously, we used 0.4 in the 2018 analysis.
            Idents(object) <- "RNA_snn_res.0.6"
            markers <- FindAllMarkers(object, test.use = "wilcox")
            outfile <- file.path(results_dir, basename(file))
            saveRDS(markers, file = outfile)
            outfile
        },
        FUN.VALUE = character(1L)
    ))
saveData(seurat_wilcoxon_marker_files)
