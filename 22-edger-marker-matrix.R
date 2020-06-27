## edgeR marker matrices.
## Updated 2020-05-22.

source("_setup.R")

## SureCell ====================================================================
surecell_edger <-
    readRDS(file.path("rds", "2020-05-21", "surecell_edger_markers.rds"))
## Loop across the DGELRT objects.
surecell_edger_lfc_vec_list <- lapply(
    X = surecell_edger,
    FUN = function(dgelrt) {
        df <- dgelrt[["table"]]
        lfc <- df[["logFC"]]
        names(lfc) <- rownames(df)
        lfc
    }
)
rm(surecell_edger)
## Genes are identical across the marker tables.
stopifnot(identical(
    names(surecell_edger_lfc_vec_list[[1L]]),
    names(surecell_edger_lfc_vec_list[[2L]])
))
## Coerce the LFC vector list to matrix.
surecell_edger_lfc_matrix <- matrix(
    data = unlist(surecell_edger_lfc_vec_list),
    ncol = length(surecell_edger_lfc_vec_list),
    byrow = FALSE,
    dimnames = list(
        ## Gene symbols.
        names(surecell_edger_lfc_vec_list[[1L]]),
        ## Cluster IDs.
        names(surecell_edger_lfc_vec_list)
    )
)
saveData(surecell_edger_lfc_matrix)
rm(
    surecell_edger_lfc_vec_list,
    surecell_edger_lfc_matrix
)

## Cell Ranger =================================================================
files <- sort(list.files(
    path = file.path("rds", "2020-05-21"),
    pattern = "^cellranger_edger_cluster_",
    full.names = TRUE
))
## Loop across the DGEList objects one at a time and extract LFC values. Here we
## are loading each object individually because it takes too much memory to load
## all objects up into a single list.
cellranger_edger_lfc_vec_list <- lapply(
    X = files,
    FUN = function(file) {
        object <- readRDS(file)
        ## Note that input object is list here, not DGELRT. Need to go down an
        ## extra level to get the DGELRT object. This differs from surecell
        ## object approach above.
        dgelrt <- object[[1L]]
        df <- dgelrt[["table"]]
        lfc <- df[["logFC"]]
        names(lfc) <- rownames(df)
        lfc
    }
)
names <- basenameSansExt(files)
names <- gsub(pattern = "_markers$", replacement = "", x = names)
names <- gsub(pattern = "^cellranger_edger_cluster_", replacement = "", x = names)
names(cellranger_edger_lfc_vec_list) <- names
rm(names)
## Coerce the LFC vector list to matrix.
cellranger_edger_lfc_matrix <- matrix(
    data = unlist(cellranger_edger_lfc_vec_list),
    ncol = length(cellranger_edger_lfc_vec_list),
    byrow = FALSE,
    dimnames = list(
        ## Gene symbols.
        names(cellranger_edger_lfc_vec_list[[1L]]),
        ## Cluster IDs.
        names(cellranger_edger_lfc_vec_list)
    )
)
saveData(cellranger_edger_lfc_matrix)
