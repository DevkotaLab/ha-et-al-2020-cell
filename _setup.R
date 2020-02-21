library(knitr)            # 1.28
library(rmarkdown)        # 2.1
library(viridis)          # 0.5.1

library(tidyverse)        # 1.3.0
library(bcbioSingleCell)  # 0.4.7
library(Chromium)         # 0.1.3

library(Seurat)           # 3.1.3
library(pointillism)      # 0.4.8

# Set seed for reproducibility.
set.seed(1454944673L)

## Set knitr defaults for R Markdown rendering.
## https://yihui.name/knitr/options/
requireNamespace(package = "knitr")
knitr::opts_chunk[["set"]](
    autodep = TRUE,
    bootstrap.show.code = FALSE,
    ## Enable caching with caution.
    cache = FALSE,
    cache.lazy = FALSE,
    ## Increase verbosity of error messages.
    calling.handlers = list(error = rlang::entrace),
    comment = "",
    dev = c("png", "pdf"),
    fig.height = 10L,
    fig.retina = 2L,
    fig.width = 10L,
    highlight = TRUE,
    ## Note that messages can screw up `lapply()` plots with tabset.
    message = FALSE,
    prompt = TRUE,
    tidy = FALSE,
    warning = TRUE
)

## Set default ggplot2 theme.
requireNamespace(package = "ggplot2")
requireNamespace(package = "acidplots")
ggplot2::theme_set(
    acidplots::acid_theme_light(
        base_size = 14L,
        legend_position = "right"
    )
)

# Improve default interactive loading/saving to use dated subdirectories.
options(acid.save.dir = file.path("rds", Sys.Date()))
options(acid.load.dir = getOption("acid.save.dir"))

requireNamespace(package = "sessioninfo")
session_info <- sessioninfo::session_info()
saveData(session_info)

rds_dir <- initDir(file.path("rds", Sys.Date()))
results_dir <- initDir(file.path("results", Sys.Date()))
