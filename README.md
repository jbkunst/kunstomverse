
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kunstomverse

<!-- badges: start -->

<!-- badges: end -->

The goal of kunstomverse is a custom tidyverse package:

  - Load some missing packages that tidyverse don’t load: scales,
    lubridate, broom.
  - Install via suggests some packages
  - Have some custom functions like `theme_knst`

## Details

The packages to load:

``` r
pkgs
#>  [1] "purrr"     "ggplot2"   "dplyr"     "tibble"    "tidyr"     "stringr"  
#>  [7] "readr"     "forcats"   "magrittr"  "lubridate" "scales"    "broom"
```

Intalled packages via suggests:

``` r
extras
#>  [1] "fs"             "RODBC"          "odbc"           "readxl"        
#>  [5] "writexl"        "dbplyr"         "rvest"          "devtools"      
#>  [9] "testthat"       "roxygen2"       "assertthat"     "forecast"      
#> [13] "randomForest"   "partykit"       "shiny"          "shinydashboard"
#> [17] "shinythemes"    "flexdashboard"  "knitr"          "rmarkdown"     
#> [21] "xaringan"       "revealjs"       "highcharter"    "DT"            
#> [25] "leaflet"        "ggrepel"        "patchwork"      "ggforce"       
#> [29] "extrafont"      "reprex"         "furrr"          "santoku"
```

## Installation

``` r
# install.packages("remotes")
remotes::install_github("jbkunst/kunstomverse")
```
