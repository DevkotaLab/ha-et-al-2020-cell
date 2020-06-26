## Calculate the proportions per cluster for cellranger and surecell datasets.

source("_setup.R")

## Set the resolution.
resolution <- import("resolution.txt", format = "lines")



## Cell Ranger ====
object <- readRDS(file.path(
    "rds",
    "2020-05-18",
    "cellranger_all_samples_seurat.rds"
))
Idents(object) <- resolution

## Set the condition inside combined Cell Ranger dataset.
## - A04: Crohn's patient
## - A16: Crohn's patient
## - D1: Non-IBD control
## - H1: Non-IBD control
object@meta.data$condition <-
    as.factor(ifelse(
        test = object@meta.data$sampleID %in% c("A04", "A16"),
        yes = "Crohn's patient",
        no = "Non-IBD control"
    ))

## All samples ----
data <- metrics(object) %>%
    group_by(ident) %>%
    summarize(n = n())
## Percent stacked bar plot.
plot <- ggplot(
    data = data,
    mapping = aes(
        x = "cellranger",
        y = n,
        fill = ident
    )
) +
    geom_bar(
        color = "black",
        position = "fill",  # Use "stack" for absolute
        stat = "identity"
    ) +
    labs(
        title = "all samples",
        x = NULL,
        y = "relative cell count"
    )
name <- "cellranger_ident_plot_pct_stacked"
ggsave(
    filename = file.path(results_dir, paste0(name, ".pdf")),
    plot = plot,
    width = 2,
    height = 7
)
assignAndSaveData(name = name, object = plot)

## Per sample ----
data <- metrics(object) %>%
    group_by(sampleName, ident) %>%
    summarize(n = n())
plot <- ggplot(
    data = data,
    mapping = aes(
        x = sampleName,
        y = n,
        fill = ident
    )
) +
    geom_bar(
        color = "black",
        position = "fill",  # Use "stack" for absolute
        stat = "identity"
    ) +
    labs(
        title = "per sample",
        x = "sample",
        y = "relative cell count"
    )
name <- "cellranger_sample_name_plot_pct_stacked"
ggsave(
    filename = file.path(results_dir, paste0(name, ".pdf")),
    plot = plot,
    width = 5,
    height = 7
)
assignAndSaveData(name = name, object = plot)

## Per condition ----
data <- metrics(object) %>%
    group_by(condition, ident) %>%
    summarize(n = n())
plot <- ggplot(
    data = data,
    mapping = aes(
        x = condition,
        y = n,
        fill = ident
    )
) +
    geom_bar(
        color = "black",
        position = "fill",  # Use "stack" for absolute
        stat = "identity"
    ) +
    labs(
        title = "per condition",
        x = "condition",
        y = "relative cell count"
    )
name <- "cellranger_condition_plot_pct_stacked"
ggsave(
    filename = file.path(results_dir, paste0(name, ".pdf")),
    plot = plot,
    width = 5,
    height = 7
)
assignAndSaveData(name = name, object = plot)



## SureCell ====
object <- readRDS(file.path(
    "rds",
    "2020-02-20",
    "seurat-clustering",
    "surecell_condition_cd_seurat.rds"
))
Idents(object) <- resolution

## All samples ----
data <- metrics(object) %>%
    group_by(ident) %>%
    summarize(n = n())
## Percent stacked bar plot.
plot <- ggplot(
    data = data,
    mapping = aes(
        x = "surecell",
        y = n,
        fill = ident
    )
) +
    geom_bar(
        color = "black",
        position = "fill",  # Use "stack" for absolute
        stat = "identity"
    ) +
    labs(
        title = "all samples",
        x = NULL,
        y = "relative cell count"
    )
name <- "surecell_ident_plot_pct_stacked"
ggsave(
    filename = file.path(results_dir, paste0(name, ".pdf")),
    plot = plot,
    width = 2,
    height = 7
)
assignAndSaveData(name = name, object = plot)

## Per sample ----
data <- metrics(object) %>%
    group_by(sampleName, ident) %>%
    summarize(n = n())
plot <- ggplot(
    data = data,
    mapping = aes(
        x = sampleName,
        y = n,
        fill = ident
    )
) +
    geom_bar(
        color = "black",
        position = "fill",  # Use "stack" for absolute
        stat = "identity"
    ) +
    labs(
        title = "per sample",
        x = "sample",
        y = "relative cell count"
    )
name <- "surecell_sample_name_plot_pct_stacked"
ggsave(
    filename = file.path(results_dir, paste0(name, ".pdf")),
    plot = plot,
    width = 5,
    height = 7
)
assignAndSaveData(name = name, object = plot)

## Per tissue status ----
data <- metrics(object) %>%
    group_by(tissueStatus, ident) %>%
    summarize(n = n())
plot <- ggplot(
    data = data,
    mapping = aes(
        x = tissueStatus,
        y = n,
        fill = ident
    )
) +
    geom_bar(
        color = "black",
        position = "fill",  # Use "stack" for absolute
        stat = "identity"
    ) +
    labs(
        title = "per tissue status",
        x = "condition",
        y = "relative cell count"
    )
name <- "surecell_tissue_status_plot_pct_stacked"
ggsave(
    filename = file.path(results_dir, paste0(name, ".pdf")),
    plot = plot,
    width = 5,
    height = 7
)
assignAndSaveData(name = name, object = plot)
