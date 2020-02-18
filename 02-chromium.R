## Load samples for 10X Chromium Cell Ranger.
## Updated 2020-02-02.

library(Chromium)  # 0.1.3
cellranger <- CellRanger(
    dir = file.path("data", "cellranger-2020-01"),
    filtered = TRUE,
    organism = "Homo sapiens",
    refdataDir = file.path("reference", "refdata-cellranger-GRCh38-3.0.0")
)
saveData(cellranger, dir = file.path("rds", Sys.Date()))
