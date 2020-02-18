## Load samples for SureCell bcbio-nextgen combined analysis.
## Updated 2020-02-02.

source("_setup.R")

## Skipping CD3H_dupe and Fresh samples here.
surecell <- bcbioSingleCell(
    uploadDir = file.path("data", "surecell-bcbio-2018-08"),
    sampleMetadataFile = file.path("metadata", "surecell-bcbio-2018-08.csv"),
    interestingGroups = c("condition", "tissueStatus"),
    organism = "Homo sapiens",
    genomeBuild = "GRCh38",
    ensemblRelease = 90
)
saveData(surecell, dir = file.path("rds", Sys.Date()))
