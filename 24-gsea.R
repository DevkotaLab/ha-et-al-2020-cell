## Run GSEA.
## Updated 2020-05-22.

source("_setup.R")

loadData(
    cellranger_edger_ranked_list,
    surecell_edger_ranked_list,
    dir = file.path("rds", "2020-05-22")
)

## Combine these ranked lists so we can run GSEA more quickly.
names(cellranger_edger_ranked_list) <-
    paste0("cellranger_", names(cellranger_edger_ranked_list))
names(surecell_edger_ranked_list) <-
    paste0("surecell_", names(surecell_edger_ranked_list))

ranked_list_combined <- c(
    cellranger_edger_ranked_list,
    surecell_edger_ranked_list
)
saveData(ranked_list_combined)
##  [1] "cellranger_cluster_00" "cellranger_cluster_01" "cellranger_cluster_02"
##  [4] "cellranger_cluster_03" "cellranger_cluster_04" "cellranger_cluster_05"
##  [7] "cellranger_cluster_06" "cellranger_cluster_07" "cellranger_cluster_08"
## [10] "cellranger_cluster_09" "cellranger_cluster_10" "cellranger_cluster_11"
## [13] "cellranger_cluster_12" "cellranger_cluster_13" "surecell_cluster_00"
## [16] "surecell_cluster_01"   "surecell_cluster_02"   "surecell_cluster_03"
## [19] "surecell_cluster_04"   "surecell_cluster_05"   "surecell_cluster_06"
## [22] "surecell_cluster_07"   "surecell_cluster_08"   "surecell_cluster_09"
## [25] "surecell_cluster_10"

## scsig
scsig_files <- sort(list.files(
    path = file.path(
        "~",
        "scsig",
        "1.0"
    ),
    pattern = "\\.all\\.v1\\.0\\.symbols\\.gmt\\.txt",
    full.names = TRUE
))

## msigdb
msigdb_files <- sort(list.files(
    path = file.path(
        "~",
        "msigdb",
        "7.1",
        "msigdb_v7.1_GMTs"
    ),
    pattern = "\\.all\\.v7\\.1\\.symbols\\.gmt$",
    full.names = TRUE
))

gmt_files <- c(
    scsig_files,
    msigdb_files
)
names <- basenameSansExt(gmt_files)
names <- gsub(pattern = "\\..+$", replacement = "", x = names)
names(gmt_files) <- names
saveData(gmt_files)

gsea <- FGSEAList(
    object = ranked_list_combined,
    gmtFiles = gmt_files
)
saveData(gsea)
