
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kunstomverse

<!-- badges: start -->

[![R-CMD-check](https://github.com/jbkunst/kunstomverse/workflows/R-CMD-check/badge.svg)](https://github.com/jbkunst/kunstomverse/actions)
<!-- badges: end -->

The goal of kunstomverse is to be a custom tidyverse package among other
things:

-   Load some missing packages that tidyverse don’t load: scales,
    lubridate, broom.
-   Install via suggests some packages
-   Have some custom functions like `theme_knst`

## Details

The packages to load:

``` r
pkgs
#>  [1] "purrr"     "ggplot2"   "dplyr"     "tibble"    "tidyr"     "stringr"  
#>  [7] "readr"     "forcats"   "magrittr"  "lubridate" "scales"    "broom"
```

You can install extra packages using::

``` r
# install.packages(kunstomverse:::EXTRAPACKAGES)
kunstomverse:::EXTRAPACKAGES
#>  [1] "odbc"           "readxl"         "writexl"        "dbplyr"        
#>  [5] "rvest"          "devtools"       "testthat"       "roxygen2"      
#>  [9] "assertthat"     "forecast"       "randomForest"   "partykit"      
#> [13] "ranger"         "shiny"          "shinydashboard" "shinythemes"   
#> [17] "flexdashboard"  "knitr"          "rmarkdown"      "xaringan"      
#> [21] "revealjs"       "distill"        "highcharter"    "DT"            
#> [25] "leaflet"        "ggrepel"        "patchwork"      "ggforce"       
#> [29] "extrafont"      "fs"             "desc"           "reprex"        
#> [33] "furrr"          "santoku"
```

## Installation

``` r
# install.packages("remotes")
remotes::install_github("jbkunst/kunstomverse")
install.packages(kunstomverse:::EXTRAPACKAGES)
```
