## UMAP and tSNE plots of all SureCell samples combined.
## Updated 2020-07-17.

source("_setup.R")

loadData(surecell_all_samples_seurat, dir = "rds/2020-06-26")

## Set the resolution.
resolution <- import("resolution.txt", format = "lines")
Idents(surecell_all_samples_seurat) <- resolution

width <- 8L
height <- 8L
point_size <- 0.5  # 0.75
label_size <- 5L  # 6L

plot_surecell_all_samples_tsne_condition <-
    plotTSNE(
        object = surecell_all_samples_seurat,
        interestingGroups = "condition",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
plot_surecell_all_samples_tsne_sample_name <-
    plotTSNE(
        object = surecell_all_samples_seurat,
        interestingGroups = "sampleName",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
plot_surecell_all_samples_umap_condition <-
    plotUMAP(
        surecell_all_samples_seurat,
        interestingGroups = "condition",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
plot_surecell_all_samples_umap_sample_name <-
    plotUMAP(
        surecell_all_samples_seurat,
        interestingGroups = "sampleName",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)

ggsave(
    filename = file.path(
        results_dir,
        "plot_surecell_all_samples_tsne_condition.pdf"
    ),
    width = width,
    height = height,
    plot = plot_surecell_all_samples_tsne_condition
)
ggsave(
    filename = file.path(
        results_dir,
        "plot_surecell_all_samples_tsne_sample_name.pdf"
    ),
    width = width,
    height = height,
    plot = plot_surecell_all_samples_tsne_sample_name
)
ggsave(
    filename = file.path(
        results_dir,
        "plot_surecell_all_samples_umap_condition.pdf"
    ),
    width = width,
    height = height,
    plot = plot_surecell_all_samples_umap_condition
)
ggsave(
    filename = file.path(
        results_dir,
        "plot_surecell_all_samples_umap_sample_name.pdf"
    ),
    width = width,
    height = height,
    plot = plot_surecell_all_samples_umap_sample_name
)
