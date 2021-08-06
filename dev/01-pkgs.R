pkgs <- c(
  # original load pkgs in tidyverse
  "purrr",
  "ggplot2",
  "dplyr",
  "tibble",
  "tidyr", 
  "stringr",
  "readr", 
  "forcats",
  # extras
  "magrittr",
  "lubridate",
  "scales",
  "broom"
)

# package to not load but needed for other functions
pkgs2 <- c(
  "hrbrthemes",
  "progress",
  "rlang",
  "tictoc"
)

extras <- c(
  # io ----------------------------------------------------------------------
  "odbc",
  "readxl",
  "writexl",
  "dbplyr",
  "rvest",

  # dev ---------------------------------------------------------------------
  "devtools",
  "testthat",
  "roxygen2",
  "assertthat",
  
  # modelling ---------------------------------------------------------------
  "forecast",
  "randomForest",
  "partykit", 
  "ranger",
  
  # reporting ---------------------------------------------------------------
  "shiny",
  "shinydashboard", 
  "shinythemes",
  "flexdashboard",
  "knitr",
  "rmarkdown",
  "xaringan",
  "revealjs",
  "distill",
  
  # widgets -----------------------------------------------------------------
  "highcharter",
  "DT",
  "leaflet",
  
  # plot --------------------------------------------------------------------
  "ggrepel",
  "patchwork",
  "ggforce",
  "extrafont",
  
  # complements -------------------------------------------------------------
  "fs",
  "desc",
  "reprex",
  "furrr",
  "santoku"
)


writeLines(
  paste0(
    "# Automatic generated file\n",
    "EXTRAPACKAGES <- c(", 
    paste("\"", extras, "\"", sep = "", collapse = ",\n"),
    ")"
  ),
  "R/extra-packages.R"
)


