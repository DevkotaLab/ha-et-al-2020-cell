source("_setup.R")
library(MAST)  # 1.14.0

loadDataAsName(
    object = cellranger_all_samples_seurat,
    dir = file.path("rds", "2020-05-18")
)

## Enable parallelization, but not inside RStudio.
if (isTRUE(future::supportsMulticore())) {
    workers <- max(getOption("mc.cores"), 1L)
    message(paste("Enabling multiprocess with", workers, "workers."))
    future::plan("multiprocess", workers = workers)
}

resolution <- import("resolution.txt", format = "lines")
Idents(object) <- resolution

cellranger_all_mast_markers <-
    FindAllMarkers(object, test.use = "MAST")
saveData(cellranger_all_mast_markers)
export(cellranger_all_mast_markers, dir = results_dir)

cellranger_all_wilcoxon_markers <-
    FindAllMarkers(object, test.use = "wilcox")
saveData(cellranger_all_wilcoxon_markers)
export(cellranger_all_wilcoxon_markers, dir = results_dir)
