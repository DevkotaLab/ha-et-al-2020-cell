source("_setup.R")



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





## output both to subdirectories dated today.
