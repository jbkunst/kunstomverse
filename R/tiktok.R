#' tic toc Wrappers
#' @param msg msg
#' @param quiet quiet
#' @param func.tik func.tik
#' @param func.tok func.tok
#' @param log log
#' @param tik tik
#' @param tok tok
#' @param info info
#' @examples
#'
#' tiktok_clear()
#'
#' tik(msg = "Go to sleep")
#'
#' Sys.sleep(2)
#'
#' tok()
#'
#' tik(msg = "Go to sleep again!")
#'
#' Sys.sleep(1)
#'
#' tok()
#'
#' tiktok_log()
#'
#' @importFrom tictoc tic toc tic.clear tic.log
#' @importFrom purrr map reduce
#' @importFrom dplyr as_data_frame bind_rows mutate_
#' @export
tik <- function(msg = NULL, quiet = FALSE, func.tik = tik_msg) {
  tictoc::tic(msg = msg, quiet = quiet, func.tic = func.tik)
}

#' @rdname tik
#' @export
tok <- function(log = TRUE, func.tok = tok_msg) {
  tictoc::toc(log = TRUE, func.toc = func.tok)
}

#' @rdname tik
#' @export
tiktok_clear <- function() {
  tictoc::tic.clear()
}

#' @rdname tik
#' @export
tik_msg <- function(tik, msg = NULL) {
  outmsg <- paste(msg, " - starting at: ", format(Sys.time(), "%X"), sep = "")
  outmsg
}

#' @rdname tik
#' @export
tok_msg <- function(tik, tok, msg, info) {
  
  t <- fmt_sec(round(tok - tik, 3))
  outmsg <- paste(msg, " - finished in: ", t,  sep = "")
  outmsg
  
}

fmt_sec <- function(delta){
  s_lt_60 <- delta < 60
  num <- ifelse(s_lt_60, delta, delta/60)
  num <- round(num, 2)
  txt <- ifelse(s_lt_60, "seconds", "minutes")
  sprintf("%s %s", num, txt)
}

#' @rdname tik
#' @importFrom rlang .data
#' @export
tiktok_log <- function() {
  tictoc::tic.log(format = FALSE) %>%
    purrr::map_df(tibble::as_tibble) %>%
    dplyr::mutate(
      time_seconds = (.data$toc - .data$tic),
      time_minutes = .data$time_seconds / 60,
    )
}