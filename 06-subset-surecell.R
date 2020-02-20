source("_setup.R")

## Extract per-sample and per-condition data subsets.
## CD: Crohn's Disease
## UC: Ulcerative Colitis

## Use our all samples filtered dataset
loadData(surecell_filtered, dir = file.path("rds", "2020-02-19"))

unname(sampleNames(surecell_filtered))
##  [1] "CD11H" "CD11I" "CD3H"  "CD3I"  "CD5H"  "CD5I"  "UC4H"  "UC4I"
##  [9] "UC6H"  "UC6I"

## Per sample ==================================================================
surecell_per_sample <- subsetPerSample(
    object = surecell_filtered,
    assignAndSave = TRUE,
    dir = file.path("rds", Sys.Date(), "surecell")
)
saveData(surecell_per_sample)

## Per condition ===============================================================
surecell_cd <- selectSamples(
    object = surecell_filtered,
    condition = "crohns_disease"
)
dim(surecell_cd)
## [1] 18132  4662
unname(sampleNames(surecell_cd))
## [1] "CD11H" "CD11I" "CD3H"  "CD3I"  "CD5H"  "CD5I"

surecell_uc <- selectSamples(
    object = surecell_filtered,
    condition = "ulcerative_colitis"
)
dim(surecell_uc)
## [1] 18132  2892
unname(sampleNames(surecell_uc))
## [1] "UC4H" "UC4I" "UC6H" "UC6I"

surecell_per_condition <- saveData(surecell_cd, surecell_uc)
saveData(surecell_per_condition)
