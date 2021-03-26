#' Auxiliar function to generate a filename following a pattern
#' @param folder .
#' @param pattern .
#' @param ext .
#' @param npad .
#' @param verbose npad .
#' @importFrom stringr str_pad str_c
#' @export
filename_gen <- function(folder = "plots", pattern = "plot", ext = "png",
                         npad = 3, verbose = TRUE) {
  
  n <- length(dir(folder, pattern = stringr::str_c("^", pattern)))
  
  n <- n + 1
  
  n <- stringr::str_pad(n, npad, pad = "0")
  
  fname <- stringr::str_c(pattern, "_", n, ".", ext)
  
  if(verbose) message(fname)
  
  file.path(folder, fname)
  
}
