source("_setup.R")

loadData(seurat_files, dir = file.path("rds", "2020-02-20"))

## Need to change the path to work on macOS.
seurat_files <- realpath(gsub(
    "/mnt/data01/n/home/michael.steinbaugh/devkota/",
    "",
    seurat_files
))

rds_dir <- initDir(file.path("rds", Sys.Date(), "seurat-clustering"))

seurat_clustering_files <-
    invisible(lapply(
        X = seurat_files,
        FUN = function(file) {
            outfile <- file.path(rds_dir, basename(file))
            if (file.exists(outfile)) {
                message(paste0("'", outfile, "' already exists. Skipping."))
                return(outfile)
            }
            name <- basenameSansExt(file)
            message(paste0("Running ", name, "."))
            object <- readRDS(file)
            object <- runSeurat(object)
            saveRDS(object, file = outfile)
            outfile
        },
        FUN.VALUE = character(1L)
    ))
saveData(seurat_clustering_files)