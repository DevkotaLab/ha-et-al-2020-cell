## Improve color consistency in figure 5.
## Updated 2020-07-17.
## Need to match figure 5D color to relative cell count stacked bar plot.

source("_setup.R")

cellranger_all <- readRDS(file.path(
    "rds",
    "2020-05-18",
    "cellranger_all_samples_seurat.rds"
))
surecell_cd <- readRDS(file.path(
    "rds",
    "2020-02-20",
    "seurat-clustering",
    "surecell_condition_cd_seurat.rds"
))

## Set the resolution.
resolution <- import("resolution.txt", format = "lines")
Idents(cellranger_all) <- resolution
Idents(surecell_cd) <- resolution

width <- 8L
height <- 8L
point_size <- 0.5  # 0.75
label_size <- 5L  # 6L

plot_umap_surecell_cd <-
    plotUMAP(
        object = surecell_cd,
        interestingGroups = "ident",
        color = NULL,
        pointSize = point_size,
        labelSize = label_size
    )
plot_umap_cellranger_all <-
    plotUMAP(
        object = cellranger_all,
        interestingGroups = "ident",
        color = NULL,
        pointSize = point_size,
        labelSize = label_size
    )

ggsave(
    filename = file.path(
        results_dir,
        "plot_umap_surecell_cd.pdf"
    ),
    width = width,
    height = height,
    plot = plot_umap_surecell_cd
)
ggsave(
    filename = file.path(
        results_dir,
        "plot_umap_cellranger_all.pdf"
    ),
    width = width,
    height = height,
    plot = plot_umap_cellranger_all
)
