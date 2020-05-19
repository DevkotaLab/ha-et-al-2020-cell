source("_setup.R")

## Load up the Wilcoxon marker data frames.
files <- list.files(
    path = file.path("rds", "2020-04-30", "seurat-wilcoxon-markers"),
    full.names = TRUE
)
## Remove the combined "condition" Seurat objects from analysis.
keep <- !grepl(
    pattern = "_condition_",
    x = basename(files)
)
files <- files[keep]
basename(files)
##  [1] "cellranger_a04_seurat.rds" "cellranger_a16_seurat.rds"
##  [3] "cellranger_d1_seurat.rds"  "cellranger_h1_seurat.rds"
##  [5] "surecell_cd11h_seurat.rds" "surecell_cd11i_seurat.rds"
##  [7] "surecell_cd3h_seurat.rds"  "surecell_cd3i_seurat.rds"
##  [9] "surecell_cd5h_seurat.rds"  "surecell_cd5i_seurat.rds"
## [11] "surecell_uc4h_seurat.rds"  "surecell_uc4i_seurat.rds"
## [13] "surecell_uc6h_seurat.rds"  "surecell_uc6i_seurat.rds"

## Split these out into separate cellranger and surecell lists, as we have
## used slightly different reference genomes (see below).
cellranger_files <-
    files[
        grepl(
            pattern = "^cellranger_",
            x = basename(files)
        )
    ]
## [1] "cellranger_a04_seurat.rds" "cellranger_a16_seurat.rds"
## [3] "cellranger_d1_seurat.rds"  "cellranger_h1_seurat.rds"
surecell_files <-
    files[
        grepl(
            pattern = "^surecell_",
            x = basename(files)
        )
    ]
##  [1] "surecell_cd11h_seurat.rds" "surecell_cd11i_seurat.rds"
##  [3] "surecell_cd3h_seurat.rds"  "surecell_cd3i_seurat.rds"
##  [5] "surecell_cd5h_seurat.rds"  "surecell_cd5i_seurat.rds"
##  [7] "surecell_uc4h_seurat.rds"  "surecell_uc4i_seurat.rds"
##  [9] "surecell_uc6h_seurat.rds"  "surecell_uc6i_seurat.rds"
saveData(cellranger_files, surecell_files)

## Load the original Cell Ranger and SureCell analysis files, which contain
## the genomic ranges.
loadData(cellranger, surecell, dir = file.path("rds", "2020-02-02"))

## Split into Cell Ranger and SureCell analyses, since genomes are different.
## - Cell Ranger: refdata-cellranger-GRCh38-3.0.0
## - SureCell: Ensembl 90
cellranger_granges <- rowRanges(cellranger)
surecell_granges <- rowRanges(surecell)
saveData(cellranger_granges, surecell_granges)



## Cell Ranger markers =========================================================
files <- cellranger_files
## Loop across each cluster per sample and run GSEA.
ranges <- cellranger_granges
## Convert the names (identifiers) of the GRanges from Ensembl gene IDs to
## gene symbols, matching the names defined in the Seurat objects.
ranges <- convertGenesToSymbols(ranges)
## 15 non-unique gene symbols detected.
markers <-
    lapply(
        X = files,
        FUN = function(file, ranges) {
            object <- readRDS(file)
            ## Ensure that the gene symbols match up correctly.
            stopifnot(all(object[["gene"]] %in% names(ranges)))
            SeuratMarkersPerCluster(
                object = object,
                ranges = ranges,
            )
        },
        ranges = ranges
    )
names(markers) <- basenameSansExt(files)
assignAndSaveData(
    name = "cellranger_wilcoxon_seurat_markers_per_cluster_list",
    object = markers
)



## SureCell markers ============================================================
files <- surecell_files
## Loop across each cluster per sample and run GSEA.
ranges <- surecell_granges
## Convert the names (identifiers) of the GRanges from Ensembl gene IDs to
## gene symbols, matching the names defined in the Seurat objects.
ranges <- convertGenesToSymbols(ranges)
## 15 non-unique gene symbols detected.
markers <-
    lapply(
        X = files,
        FUN = function(file, ranges) {
            object <- readRDS(file)
            ## Ensure that the gene symbols match up correctly.
            stopifnot(all(object[["gene"]] %in% names(ranges)))
            SeuratMarkersPerCluster(
                object = object,
                ranges = ranges,
            )
        },
        ranges = ranges
    )
names(markers) <- basenameSansExt(files)
assignAndSaveData(
    name = "surecell_wilcoxon_seurat_markers_per_cluster_list",
    object = markers
)



## Combine marker lists ========================================================
## Now we can combine the SeuratMarkersPerCluster lists.
wilcoxon_markers_list <- c(
    cellranger_wilcoxon_seurat_markers_per_cluster_list,
    surecell_wilcoxon_seurat_markers_per_cluster_list
)
names(wilcoxon_markers_list)
##  [1] "cellranger_a04_seurat" "cellranger_a16_seurat" "cellranger_d1_seurat"
##  [4] "cellranger_h1_seurat"  "surecell_cd11h_seurat" "surecell_cd11i_seurat"
##  [7] "surecell_cd3h_seurat"  "surecell_cd3i_seurat"  "surecell_cd5h_seurat"
## [10] "surecell_cd5i_seurat"  "surecell_uc4h_seurat"  "surecell_uc4i_seurat"
## [13] "surecell_uc6h_seurat"  "surecell_uc6i_seurat"
saveData(wilcoxon_markers_list)
