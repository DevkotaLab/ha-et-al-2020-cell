source("_setup.R")
library(acidgsea)  # 0.2.1

loadData(wilcoxon_markers_list, dir = file.path("rds", "2020-05-18"))

## Loop across the SeuratMarkersPerCluster list and generate RankedList.
## Consider defining RankedList method in pointillism package based on this.

object <- wilcoxon_markers_list[[1]]
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
