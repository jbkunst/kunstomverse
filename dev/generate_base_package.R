# parameters --------------------------------------------------------------
# install.packages("tidyverse")
# install.packages("pkgverse")
# install.packages("desc")
pkgname <- "jbkverse"

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
   "hrbrthemes", "ggrepel", "patchwork", "ggforce",
  # others
  "reprex", "furrr", "santoku"
)


# creating package --------------------------------------------------------
tmpdr      <- tempdir()
tmpdrp_pkg <- fs::path(tmpdr, pkgname)

try(fs::dir_delete(tmpdrp_pkg))

pkgverse::pkgverse(pkgname, pkgs, keep = tmpdr)

dir(tmpdrp_pkg)

fs::dir_copy(tmpdrp_pkg, ".", overwrite = TRUE)


# modify DESCRIPTION ------------------------------------------------------
DESC <- desc::description$new()

DESC$set_authors(
  person(
      given = "Joshua",
      family = "Kunst",
      email = "jbkunst@gmail.com",
      role = c("aut", "cre")
  )
)

DESC$get_authors()

dfdeps <- DESC$get_deps()

dfsuggets <- tibble::tibble(
  type = "Suggests",
  package = extras,
  version = "*"
)

dfpgks <- dplyr::bind_rows(
  dfdeps,
  dfsuggets
  )

dfpgks

DESC$set_deps(dfpgks)

# write -------------------------------------------------------------------
DESC$write()

DESC$validate()

# LICENSE -----------------------------------------------------------------
usethis::proj_set(getwd())

options(usethis.full_name = "Joshua Kunst")

usethis::use_mit_license()

# check -------------------------------------------------------------------
devtools::check()

devtools::build()

