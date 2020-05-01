source("_setup.R")

mast_results_dir <-
    initDir(file.path(results_dir, "seurat-mast-markers-csv"))
wilcoxon_results_dir <-
    initDir(file.path(results_dir, "seurat-wilcoxon-markers-csv"))



## MAST markers ================================================================
loadData(seurat_mast_marker_files, dir = file.path("rds", "2020-02-20"))
## Strip out the absolute URL from the file list.
parent_dir_pattern <-
    seurat_mast_marker_files %>%
    .[[1L]] %>%
    str_extract(
        string = .,
        pattern = "^.+/results/"
    ) %>%
    dirname() %>%
    paste0("^", ., "/")
seurat_mast_marker_files %<>%
    gsub(
        pattern = parent_dir_pattern,
        replacement = "",
        x = .
    ) %>%
    gsub(
        pattern = "results/",
        replacement = "rds/",
        x = .
    ) %>%
    realpath()
saveData(seurat_mast_marker_files)

seurat_mast_marker_csv_files <-
    vapply(
        X = seurat_mast_marker_files,
        FUN = function(file) {
            outfile <- file.path(
                mast_results_dir,
                paste0(basenameSansExt(file), ".csv")
            )
            object <- readRDS(file)
            export(object, file = outfile)
        },
        FUN.VALUE = character(1L)
    )
saveData(seurat_mast_marker_csv_files)



## Wilcoxon markers ============================================================
loadData(seurat_wilcoxon_marker_files, dir = file.path("rds", "2020-02-21"))
## Strip out the absolute URL from the file list.
parent_dir_pattern <-
    seurat_wilcoxon_marker_files %>%
    .[[1L]] %>%
    str_extract(
        string = .,
        pattern = "^.+/results/"
    ) %>%
    dirname() %>%
    paste0("^", ., "/")
seurat_wilcoxon_marker_files %<>%
    gsub(
        pattern = parent_dir_pattern,
        replacement = "",
        x = .
    ) %>%
    gsub(
        pattern = "results/",
        replacement = "rds/",
        x = .
    ) %>%
    realpath()
saveData(seurat_wilcoxon_marker_files)

seurat_wilcoxon_marker_csv_files <-
    vapply(
        X = seurat_wilcoxon_marker_files,
        FUN = function(file) {
            outfile <- file.path(
                wilcoxon_results_dir,
                paste0(basenameSansExt(file), ".csv")
            )
            object <- readRDS(file)
            export(object, file = outfile)
        },
        FUN.VALUE = character(1L)
    )
saveData(seurat_wilcoxon_marker_csv_files)