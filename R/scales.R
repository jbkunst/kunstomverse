#' Local version of scales::comma scales::percent 
#' 
#' @param x A numeric vector to format.
#' @param accuracy NULL
#' @param scale 1
#' @param prefix ""
#' @param suffix ""
#' @param big.mark "."
#' @param decimal.mark ","
#' @param trim TRUE
#' @param digits digits
#' @param ... Other arguments passed on to base::format(). 
#' @examples
#' 
#' x <- 10^c(1:10)
#' 
#' comma_cl(x)
#' 
#' comma_cl(x + .123, accuracy = 0.001)
#' 
#' comma_cl(x + .123, accuracy = 0.001, big.mark = " ")
#' 
#' scales::comma(x)
#' 
#' @importFrom scales comma
#' @export
comma_cl <- function(x,
                     accuracy = NULL,
                     scale = 1,
                     prefix = "",
                     suffix = "",
                     big.mark = ".",
                     decimal.mark = ",",
                     trim = TRUE,
                     digits,
                     ...) {
  
  scales::comma(
    x,
    accuracy = accuracy,
    scale = scale,
    prefix = prefix,
    suffix = suffix,
    big.mark = big.mark,
    decimal.mark = decimal.mark,
    trim = trim,
    digits = digits,
    ...
  )
  
}

#' @rdname comma_cl 
#' @importFrom scales percent
#' @export
percent_cl <- function(x,
                       accuracy = NULL,
                       scale = 100,
                       prefix = "",
                       suffix = "%",
                       big.mark = ".",
                       decimal.mark = ",",
                       trim = TRUE,
                       ...) {
  
  scales::percent(
    x,
    accuracy = accuracy,
    scale = scale,
    prefix = prefix,
    suffix = suffix,
    big.mark = big.mark,
    decimal.mark = decimal.mark,
    trim = trim,
    digits = digits,
    ...
  )
  
}
