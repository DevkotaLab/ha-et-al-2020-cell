## Compare SureCell (bcbio-nextgen) and Chromium runs.
## Updated 2020-02-02.

library(basejump)

loadData(cellranger, surecell, dir = file.path("rds", "2020-02-02"))

dim(cellranger)
dim(surecell)

length(intersect(
    x = rownames(cellranger),
    y = rownames(surecell)
))
## 17189
