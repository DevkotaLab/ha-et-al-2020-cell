## Calculate the proportions per cluster for cellranger and surecell datasets.

source("_setup.R")

seurat_files <- c(
    cellranger = file.path(
        "rds",
        "2020-05-18",
        "cellranger_all_samples_seurat.rds"
    ),
    surecell = file.path(
        "rds",
        "2020-02-20",
        "seurat-clustering",
        "surecell_condition_cd_seurat.rds"
    )
)
saveData(seurat_files)

## Set the resolution.
resolution <- import("resolution.txt", format = "lines")
saveData(resolution)

## Loop across the Seurat objects and get the cell count per cluster.
## Create a stacked bar plot for each sample showing these distributions.
seurat_metadata_list <- lapply(
    X = seurat_files,
    FUN = function(file) {
        object <- readRDS(file)
        Idents(object) <- resolution
        list(
            metrics = metrics(object),
            idents = Idents(object),
            metadata = object@meta.data
        )
    }
)
names(seurat_metadata_list) <- basenameSansExt(seurat_files)
saveData(seurat_metadata_list)



## Cell Ranger samples ====

## Run this for all samples, per sample, and per condition.
metrics <- seurat_metadata_list[["cellranger_all_samples_seurat"]][["metrics"]]

## All samples ----

## Reverse the ident table so we can stack high to low from y-axis origin.


data <- tibble(
    sampleID = "cellranger",
    clusterID = factor(
        x = names(table(metrics[["ident"]])),
        levels = names(table(metrics[["ident"]]))
    ),
    n = as.integer(table(metrics[["ident"]]))
)
gg <- ggplot(
    data = data,
    mapping = aes(
        x = sampleID,
        y = n,
        fill = clusterID
    )
)
## Percent stacked bar plot.
p_pct_stacked <- gg +
    geom_bar(
        color = "black",
        position = "fill",  # Use "stack" for absolute
        stat = "identity"
    ) +
    labs(
        x = NULL,
        y = "relative cell count"
    )
saveData(p_pct_stacked)
