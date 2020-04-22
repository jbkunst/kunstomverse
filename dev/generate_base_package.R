# parameters --------------------------------------------------------------
# install.packages("tidyverse")
# install.packages("pkgverse")
# install.packages("desc")
pkgname <- "kunstomverse"

try(fs::file_delete("DESCRIPTION"))
try(fs::file_delete("NAMESPACE"))

source("dev/pkgs.R")


# creating package --------------------------------------------------------
tmpdr      <- tempdir()

tmpdrp_pkg <- fs::path(tmpdr, pkgname)

try(fs::dir_delete(tmpdrp_pkg))

pkgverse::pkgverse(pkgname, pkgs, keep = tmpdr)

dir(tmpdrp_pkg)

fs::dir_copy(tmpdrp_pkg, ".", overwrite = TRUE)


# modify DESCRIPTION ------------------------------------------------------
usethis::proj_set(".")

DESC <- desc::description$new(file = "DESCRIPTION")

DESC

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

dfdeps <-  dplyr::bind_rows(
  dfdeps,
  tibble::tibble(
    type = "Imports",
    package = pkgs2,
    version = "*"
  )
)

dfdeps

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
usethis::proj_set(".")

options(usethis.full_name = "Joshua Kunst")

usethis::use_mit_license()

# check -------------------------------------------------------------------
devtools::document()

devtools::check()

# devtools::build()

