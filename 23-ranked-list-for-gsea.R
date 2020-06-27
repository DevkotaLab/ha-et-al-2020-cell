## Generate ranked list of expression per gene symbol for GSEA.
## Updated 2020-05-22.

source("_setup.R")
library(acidgsea)  # 0.3.0

loadData(
    cellranger,
    surecell,
    dir = file.path("rds", "2020-02-02")
)
loadData(
    cellranger_edger_lfc_matrix,
    surecell_edger_lfc_matrix,
    dir = file.path("rds", "2020-05-22")
)

## Cell Ranger =================================================================
mat <- cellranger_edger_lfc_matrix
## Note that we're improving the sorting of the columns here.
colnames(mat) <- autopadZeros(paste0("cluster_", colnames(mat)))
mat <- mat[, sort(colnames(mat))]
gr <- rowRanges(cellranger)
## Generate Gene2Symbol objects to remap gene IDs and ensure we handle
## duplicate gene symbols correctly, averaging the LFC values.
g2s <- Gene2Symbol(gr, format = "makeUnique")
## ℹ 15 non-unique gene symbols detected.
stopifnot(all(rownames(mat) %in% g2s$geneName))
## Convert the gene symbols in row names back to Ensembl genes.
## We'll use the g2s table to remap.
idx <- match(x = rownames(mat), table = g2s$geneName)
stopifnot(!anyNA(idx))
rownames(mat) <- g2s$geneID[idx]
## Returning long (unmodified) which we'll use as input to RankedList function.
g2s_long <- Gene2Symbol(gr, format = "unmodified")
rl <- RankedList(
    object = mat,
    gene2symbol = g2s_long,
    value = "log2FoldChange"
)
## → Averaging 'log2FoldChange' value for 12 gene symbols: ABCF2, ATXN7, CCDC39,
## COG8, CYB561D2, EMG1, HSPA14, LINC01238, POLR2J3, RGS5, TBCE, TMSB15B.
assignAndSaveData(
    name = "cellranger_edger_ranked_list",
    object = rl
)

## SureCell ====================================================================
mat <- surecell_edger_lfc_matrix
## Note that we're improving the sorting of the columns here.
colnames(mat) <- autopadZeros(paste0("cluster_", colnames(mat)))
mat <- mat[, sort(colnames(mat))]
gr <- rowRanges(surecell)
## Generate Gene2Symbol objects to remap gene IDs and ensure we handle
## duplicate gene symbols correctly, averaging the LFC values.
g2s <- Gene2Symbol(gr, format = "makeUnique")
## ℹ 15 non-unique gene symbols detected.
stopifnot(all(rownames(mat) %in% g2s$geneName))
## Convert the gene symbols in row names back to Ensembl genes.
## We'll use the g2s table to remap.
idx <- match(x = rownames(mat), table = g2s$geneName)
stopifnot(!anyNA(idx))
rownames(mat) <- g2s$geneID[idx]
## Returning long (unmodified) which we'll use as input to RankedList function.
g2s_long <- Gene2Symbol(gr, format = "unmodified")
rl <- RankedList(
    object = mat,
    gene2symbol = g2s_long,
    value = "log2FoldChange"
)
## → Averaging 'log2FoldChange' value for 8 gene symbols: COG8, EMG1, MATR3,
## POLR2J2, RABGEF1, SCO2, SDHD, TMSB15B.
assignAndSaveData(
    name = "surecell_edger_ranked_list",
    object = rl
)
