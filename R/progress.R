#' Wrapper of `Sys.sleep()` using  `{progress}` package
#' @param time The time interval to suspend execution for, in seconds.
#' @param format The format of the progress bar. A number of tokens can be 
#'   used here, see them below. It defaults to "[:bar] :percent", which means 
#'   that the progress bar is within brackets on the left, and the percentage 
#'   is printed on the right. Source: progress package.
#' @param ... Parameters for \code{progress::progress_bar$new}
#' @importFrom  progress progress_bar
#' @examples
#' 
#' progress_sleep(5)
#' 
#' system.time(progress_sleep(10))
#' 
#' @export
progress_sleep <- function(time, format = "  waiting [:bar] :percent eta: :eta" , ...) {
  
  time <- round(time) + 1
  
  pb <-  progress::progress_bar$new(total = time, format = format, ...)
  
  for (i in 1:time) {
    pb$tick()
    Sys.sleep(1)
  }
  
}
