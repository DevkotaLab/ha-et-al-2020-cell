source("_setup.R")



loadData(seurat_files, dir = file.path("rds", "2020-02-20"))

## FIXME This is a test to see if our function works.
object <- readRDS(seurat_files[[1]])

## FIXME Switch to runSeurat here.
