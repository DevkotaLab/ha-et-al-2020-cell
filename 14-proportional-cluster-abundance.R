source("_setup.R")

loadData(seurat_clustering_files, dir = file.path("rds", "2020-02-20"))

resolution <- import("resolution.txt", format = "lines")
## [1] "RNA_snn_res.0.4"

## Loop across the Seurat objects and get the cell count per cluster.
## Create a stacked bar plot for each sample showing these distributions.
cell_counts_per_cluster <- lapply(
    X = seurat_clustering_files,
    FUN = function(file) {
        object <- readRDS(file)
        Idents(object) <- resolution
        table(Idents(object))
    }
)
names(cell_counts_per_cluster) <- basenameSansExt(seurat_clustering_files)
saveData(cell_counts_per_cluster)

## Merge these counts into a single data frame grouped by sample ID.
cell_counts_per_cluster_df <- mapply(
    sampleID = names(cell_counts_per_cluster),
    table = cell_counts_per_cluster,
    FUN = function(sampleID, table) {
        df <- as.data.frame(table)
        df[["sampleID"]] <- sampleID
        df
    },
    SIMPLIFY = FALSE,
    USE.NAMES = FALSE
) %>%
    data.table::rbindlist(.) %>%
    camelCase() %>%
    as_tibble() %>%
    dplyr::rename(
        clusterID = var1,
        n = freq
    ) %>%
    group_by(sampleID)
saveData(cell_counts_per_cluster_df)

## Create barplots using ggplot2.
## https://www.r-graph-gallery.com/48-grouped-barplot-with-ggplot2.html
gg <- ggplot(
    data = cell_counts_per_cluster_df,
    mapping = aes(
        x = sampleID,
        y = n,
        fill = clusterID
    )
)

## Stacked bar plot.
p_stacked <- gg +
    geom_bar(
        position = "stack",
        stat = "identity"
    ) +
    labs(
        x = NULL,
        y = "cell count"
    )
saveData(p_stacked)

## Percent stacked bar plot.
p_pct_stacked <- gg +
    geom_bar(
        color = "black",
        position = "fill",
        stat = "identity"
    ) +
    labs(
        x = NULL,
        y = "% cell count"
    )
saveData(p_pct_stacked)
