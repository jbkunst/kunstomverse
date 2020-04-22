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
  "hrbrthemes"
)

extras <- c(
  # general
  "fs",
  # io
  "RODBC", "odbc", "readxl", "writexl", "dbplyr", "rvest",
  # development
  "devtools", "testthat", "roxygen2", "assertthat",
  # modelling
  "forecast", "randomForest", "partykit", 
  # reporting
  "shiny", "shinydashboard", "shinythemes", "flexdashboard",
  "knitr", "rmarkdown", "xaringan", "revealjs",
  # widgets
  "highcharter", "DT", "leaflet",
  # plot
  "ggrepel", "patchwork", "ggforce", "extrafont",
  # others
  "reprex", "furrr", "santoku"
)