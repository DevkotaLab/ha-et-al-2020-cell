source("_setup.R")

## Coerce SingleCellExperiment objects to Seurat, to run clustering.
## Updated 2020-02-20.

## Objects to load and cluster.
loadData(
    cellranger_per_sample,
    surecell_per_sample,
    surecell_per_condition,
    dir = file.path("rds", "2020-02-20")
)

## Adjust the names, so the file output is easy to read.
names(cellranger_per_sample) <-
    snakeCase(paste("cellranger", names(cellranger_per_sample)))
names(surecell_per_sample) <-
    snakeCase(paste("surecell", names(surecell_per_sample)))
names(surecell_per_condition) <-
    gsub("surecell_", "surecell_condition_", names(surecell_per_condition))

sce_files <- c(
    cellranger_per_sample,
    surecell_per_sample,
    surecell_per_condition
)
saveData(sce_files)
##  [1] "cellranger_a04"        "cellranger_a16"        "cellranger_d1"
##  [4] "cellranger_h1"         "surecell_cd11h"        "surecell_cd11i"
##  [7] "surecell_cd3h"         "surecell_cd3i"         "surecell_cd5h"
## [10] "surecell_cd5i"         "surecell_uc4h"         "surecell_uc4i"
## [13] "surecell_uc6h"         "surecell_uc6i"         "surecell_condition_cd"
## [16] "surecell_condition_uc"

seurat_names <- snakeCase(paste(names(sce_files), "seurat"))
##  [1] "cellranger_a04_seurat"        "cellranger_a16_seurat"
##  [3] "cellranger_d1_seurat"         "cellranger_h1_seurat"
##  [5] "surecell_cd11h_seurat"        "surecell_cd11i_seurat"
##  [7] "surecell_cd3h_seurat"         "surecell_cd3i_seurat"
##  [9] "surecell_cd5h_seurat"         "surecell_cd5i_seurat"
## [11] "surecell_uc4h_seurat"         "surecell_uc4i_seurat"
## [13] "surecell_uc6h_seurat"         "surecell_uc6i_seurat"
## [15] "surecell_condition_cd_seurat" "surecell_condition_uc_seurat"

## Loop across the SCE input and coerce to Seurat.
## Note that this coercion method is defined in the pointillism package.
seurat_dir <- initDir(file.path(rds_dir, "seurat"))
seurat_files <- invisible(mapply(
    seurat_name = seurat_names,
    sce_file = sce_files,
    MoreArgs = list(dir = seurat_dir),
    FUN = function(seurat_name, sce_file, dir) {
        sce <- readRDS(file = sce_file)
        sce <- convertGenesToSymbols(sce)
        object <- as(sce, "Seurat")
        file <- file.path(dir, paste0(seurat_name, ".rds"))
        message(seurat_name)
        message(file)
        print(object)
        saveRDS(object = object, file = file)
        file
    },
    SIMPLIFY = FALSE,
    USE.NAMES = TRUE
))
saveData(seurat_files)
