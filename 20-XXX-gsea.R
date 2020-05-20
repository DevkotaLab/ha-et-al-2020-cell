source("_setup.R")
library(acidgsea)  # 0.2.1

loadData(
    cellranger_all_wilcoxon_markers,
    surecell_all_wilcoxon_markers,
    dir = file.path("rds", "2020-05-20")
)
loadDataAsName(
    list = wilcoxon_markers_list,
    dir = file.path("rds", "2020-05-18")
)
list <- c(
    cellranger_all = cellranger_all_wilcoxon_markers,
    surecell_all = surecell_all_wilcoxon_markers,
    list
)
names(list) <- gsub(
    pattern = "_seurat$",
    replacement = "",
    x = names(list)
)
##  [1] "cellranger_all" "surecell_all"   "cellranger_a04" "cellranger_a16"
##  [5] "cellranger_d1"  "cellranger_h1"  "surecell_cd11h" "surecell_cd11i"
##  [9] "surecell_cd3h"  "surecell_cd3i"  "surecell_cd5h"  "surecell_cd5i"
## [13] "surecell_uc4h"  "surecell_uc4i"  "surecell_uc6h"  "surecell_uc6i"
rm(cellranger_all_wilcoxon_markers, surecell_all_wilcoxon_markers)

assignAndSaveData(
    name = "wilcoxon_markers_list",
    object = list
)




## Loop across the SeuratMarkersPerCluster list and generate RankedList.
## Consider defining RankedList method in pointillism package based on this.

object <- list[[1]]
class(object)
## [1] "SeuratMarkersPerCluster"
## attr(,"package")
## [1] "pointillism"

## Let's extract the first cluster, to generate an example RankedList.
## FIXME Can we use matrix method here?

names(object)
cluster0 <- object[["cluster0"]]
class(cluster0)
## [1] "DFrame"
## attr(,"package")
## [1] "S4Vectors"

## We're using the "avgLogFC" column and "ranges" column for the mappings.
## Alternatively, can use "name" column, but this contains modified symbols.
