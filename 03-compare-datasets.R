## Compare SureCell (bcbio-nextgen) and Chromium runs.
## Updated 2020-02-02.

source("_setup.R")

loadData(cellranger, surecell, dir = file.path("rds", "2020-02-02"))

dim(cellranger)
## [1] 25585 11153
dim(surecell)
## [1]  24600 105071

length(intersect(x = rownames(cellranger), y = rownames(surecell)))
## 17189

## This is a usable number of genes that intersect if we want to continue with
## integration analysis in the future.

rownames(sampleData(cellranger))
## [1] "A04" "A16" "D1"  "H1"

rownames(sampleData(surecell))
##  [1] "CD11H" "CD11I" "CD3H"  "CD3I"  "CD5H"  "CD5I"  "UC4H"
##  [8] "UC4I"  "UC6H"  "UC6I"
