source("_setup.R")

loadDataAsName(
    object = cellranger_all_samples_seurat,
    dir = file.path("rds", "2020-05-18")
)

## Set the resolution.
resolution <- import("resolution.txt", format = "lines")
Idents(object) <- resolution

title <- "cellranger"
labels <- list(title = title)
p <- plotUMAP(object, labels = labels)
ggsave(
    filename = file.path(results_dir, paste0(title, "_umap.pdf")),
    plot = p
)
p <- plotTSNE(object, labels = labels)
ggsave(
    filename = file.path(results_dir, paste0(title, "_tsne.pdf")),
    plot = p
)
