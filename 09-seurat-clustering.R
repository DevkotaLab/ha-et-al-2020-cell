## Run Seurat clustering.
## Updated 2020-06-27.

source("_setup.R")

loadData(seurat_files, dir = file.path("rds", "2020-02-20"))
## Strip out the absolute URL from the file list.
parent_dir_pattern <-
    seurat_files %>%
    .[[1L]] %>%
    str_extract(
        string = .,
        pattern = "^.+/rds/"
    ) %>%
    dirname() %>%
    paste0("^", ., "/")
seurat_files %<>%
    gsub(
        pattern = parent_dir_pattern,
        replacement = "",
        x = .
    ) %>%
    realpath()
saveData(seurat_files)

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
            object <- runSeurat(object, umapMethod = "umap-learn")
            saveRDS(object, file = outfile)
            outfile
        },
        FUN.VALUE = character(1L)
    ))
saveData(seurat_clustering_files)
