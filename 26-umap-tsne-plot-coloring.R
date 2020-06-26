source("_setup.R")

cellranger <- readRDS(file.path(
    "rds",
    "2020-05-18",
    "cellranger_all_samples_seurat.rds"
))
surecell <- readRDS(file.path(
    "rds",
    "2020-02-20",
    "seurat-clustering",
    "surecell_condition_cd_seurat.rds"
))

## Set the resolution.
resolution <- import("resolution.txt", format = "lines")
Idents(cellranger) <- resolution
Idents(surecell) <- resolution

## Set the condition inside combined Cell Ranger dataset.
##
## - A04: Crohn's patient
## - A16: Crohn's patient
## - D1: Non-IBD control
## - H1: Non-IBD control
##
## Match the factor levels, so the plot colors are consistent with surecell.
cellranger@meta.data$condition <-
    ifelse(
        test = cellranger@meta.data$sampleID %in% c("A04", "A16"),
        yes = "Crohn's patient",
        no = "Non-IBD control"
    ) %>%
    as.factor() %>%
    relevel(ref = "Non-IBD control")

colnames(cellranger@meta.data)
##  [1] "orig.ident"            "nCount_RNA"            "nFeature_RNA"
##  [4] "sampleID"              "sampleName"            "nCount"
##  [7] "nFeature"              "nCoding"               "nMito"
## [10] "log10FeaturesPerCount" "mitoRatio"             "S.Score"
## [13] "G2M.Score"             "Phase"                 "CC.Difference"
## [16] "RNA_snn_res.0.2"       "RNA_snn_res.0.4"       "RNA_snn_res.0.6"
## [19] "RNA_snn_res.0.8"       "RNA_snn_res.1"         "RNA_snn_res.1.2"
## [22] "seurat_clusters"       "condition"

colnames(surecell@meta.data)
##  [1] "orig.ident"            "nCount_RNA"            "nFeature_RNA"
##  [4] "condition"             "description"           "log10FeaturesPerCount"
##  [7] "mitoRatio"             "nCoding"               "nCount"
## [10] "nFeature"              "nMito"                 "nRead"
## [13] "patientID"             "sampleID"              "sampleName"
## [16] "tissueStatus"          "S.Score"               "G2M.Score"
## [19] "Phase"                 "CC.Difference"         "RNA_snn_res.0.2"
## [22] "RNA_snn_res.0.4"       "RNA_snn_res.0.6"       "RNA_snn_res.0.8"
## [25] "RNA_snn_res.1"         "RNA_snn_res.1.2"       "seurat_clusters"

## > saveData(cellranger, surecell)

## Note that these plots are too large to save to disk.
## Just regenerate, if necessary.

width <- 8L
height <- 8L
point_size <- 0.5  # 0.75
label_size <- 5L  # 6L

## Cell Ranger t-SNE.
ggsave(
    filename = file.path(
        results_dir,
        "cellranger_tsne_ident.pdf"
    ),
    width = width,
    height = height,
    plot = plotTSNE(
        object = cellranger,
        interestingGroups = NULL,
        color = NULL,
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
ggsave(
    filename = file.path(
        results_dir,
        "cellranger_tsne_condition.pdf"
    ),
    width = width,
    height = height,
    plot = plotTSNE(
        object = cellranger,
        interestingGroups = "condition",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
ggsave(
    filename = file.path(
        results_dir,
        "cellranger_tsne_sample_name.pdf"
    ),
    width = width,
    height = height,
    plot = plotTSNE(
        object = cellranger,
        interestingGroups = "sampleName",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)

## Cell Ranger UMAP.
ggsave(
    filename = file.path(
        results_dir,
        "cellranger_umap_ident.pdf"
    ),
    width = width,
    height = height,
    plot = plotUMAP(
        object = cellranger,
        interestingGroups = NULL,
        color = NULL,
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
ggsave(
    filename = file.path(
        results_dir,
        "cellranger_umap_condition.pdf"
    ),
    width = width,
    height = height,
    plot = plotUMAP(
        object = cellranger,
        interestingGroups = "condition",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
ggsave(
    filename = file.path(
        results_dir,
        "cellranger_umap_sample_name.pdf"
    ),
    width = width,
    height = height,
    plot = plotUMAP(
        object = cellranger,
        interestingGroups = "sampleName",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)

## SureCell t-SNE.
ggsave(
    filename = file.path(
        results_dir,
        "surecell_tsne_ident.pdf"
    ),
    width = width,
    height = height,
    plot = plotTSNE(
        object = surecell,
        interestingGroups = NULL,
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
ggsave(
    filename = file.path(
        results_dir,
        "surecell_tsne_sample_name.pdf"
    ),
    width = width,
    height = height,
    plot = plotTSNE(
        object = surecell,
        interestingGroups = "sampleName",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
ggsave(
    filename = file.path(
        results_dir,
        "surecell_tsne_tissue_status.pdf"
    ),
    width = width,
    height = height,
    plot = plotTSNE(
        object = surecell,
        interestingGroups = "tissueStatus",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)

## SureCell UMAP.
ggsave(
    filename = file.path(
        results_dir,
        "surecell_umap_ident.pdf"
    ),
    width = width,
    height = height,
    plot = plotUMAP(
        object = surecell,
        interestingGroups = NULL,
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
ggsave(
    filename = file.path(
        results_dir,
        "surecell_umap_sample_name.pdf"
    ),
    width = width,
    height = height,
    plot = plotUMAP(
        object = surecell,
        interestingGroups = "sampleName",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
ggsave(
    filename = file.path(
        results_dir,
        "surecell_umap_tissue_status.pdf"
    ),
    width = width,
    height = height,
    plot = plotUMAP(
        object = surecell,
        interestingGroups = "tissueStatus",
        pointSize = point_size,
        labelSize = label_size
    ) + theme(aspect.ratio = 1L)
)
