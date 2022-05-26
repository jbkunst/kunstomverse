#' A function to applied some forcats functions
#' 
#' @param x A vector
#' @param na_level If this argument is not null, then `fct_explicit_na` is applied
#'   with this argument.
#' @param n If this argument is not null, then `fct_lump_n` is applied with `n`
#'   and `other_level`.
#' @param other_level this argument is used if `n` is not null.
#' @param infreq Logical value to apply or not `fct_infreq`.
#' @importFrom forcats fct_explicit_na fct_lump_n fct_infreq  
#' 
#' @examples 
#' 
#' x1 <- c(rep(LETTERS[1:9], times = c(10, 40, 5, 27, 1, 1, 1, 1, 1)), rep(NA, 10))
#' x2 <- factor(x1)
#' 
#' table(x1, useNA = "always")
#' table(x2, useNA = "always")
#' 
#' identical(fct_clean(x1), fct_clean(x2))
#' 
#' xf <- fct_clean(x1, n = 4)
#' xf
#' 
#' table(xf, useNA = "always")
#' 
#' @export
fct_clean <- function(
  x,
  na_level = "(Missing)",
  n = NULL, 
  other_level = "Other",
  infreq = TRUE) {

  if(is.character(x)) x <- factor(x)
  
  if(!is.null(na_level)) x <- forcats::fct_explicit_na(x, na_level = na_level)
  if(!is.null(n))        x <- forcats::fct_lump_n(x, n = n, other_level = other_level)
  if(infreq)             x <- forcats::fct_infreq(x)
  
  x
  
}

#' A function to apply before export values to excel
#' 
#' @param x A factor
#' @importFrom forcats fct_explicit_na fct_lump_n fct_infreq  
#' @examples 
#' 
#' f <- factor(c("b", "b", "a", "c", "c", "c"))
#' 
#' fct_to_excel_values(f)
#' 
#' 
#' 
#' @export
fct_to_excel_values <- function(x) {
  
  stopifnot(is.factor(x))
  
  levels(x) <- stringr::str_c(1:length(levels(x)), ") ", levels(x))
  
  x
  
}
