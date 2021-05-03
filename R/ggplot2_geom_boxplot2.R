#' A box and whiskers plot (in the style of Tukey)
#'
#' All credits to @kongdd https://github.com/rpkgs/Ipaper
#' 
#' @param mapping mapping
#' @param data data
#' @param stat stat
#' @param position position
#' @param ... ...
#' @param outlier.colour outlier.colour
#' @param outlier.color outlier.color
#' @param outlier.fill outlier.fill
#' @param outlier.shape outlier.shape
#' @param outlier.size outlier.size
#' @param outlier.stroke outlier.stroke
#' @param outlier.alpha outlier.alpha
#' @param na.rm na.rm
#' @param show.legend show.legend
#' @param inherit.aes inherit.aes 
#' @param show.errorbar boolean
#' @param width.errorbar width of errorbar.
#' @param notch If `FALSE` (default) make a standard box plot. If
#'   `TRUE`, make a notched box plot. Notches are used to compare groups;
#'   if the notches of two boxes do not overlap, this suggests that the medians
#'   are significantly different.
#' @param notchwidth For a notched box plot, width of the notch relative to
#'   the body (defaults to `notchwidth = 0.5`).
#' @param varwidth If `FALSE` (default) make a standard box plot. If
#'   `TRUE`, boxes are drawn with widths proportional to the
#'   square-roots of the number of observations in the groups (possibly
#'   weighted, using the `weight` aesthetic).
#'   
#' @examples 
#' 
#' df <- data.frame(
#'   x = sample(LETTERS[1:3], prob = 1:3, size = 1000, replace = TRUE),
#'   y = rgamma(1000, shape = 1)
#' )
#' 
#' df <- data.frame(
#'   x = sample(LETTERS[1:3], prob = 1:3, size = 1000, replace = TRUE),
#'   y = rt(1000, df = 3)
#' )
#' 
#' ggplot(df) +
#'   geom_boxplot(aes(x, y))
#' 
#' ggplot(df) +
#'   geom_boxplot2(aes(x, y))
#'
#' ggplot(df) +
#'   geom_boxplot2(aes(x, y), width.errorbar = 0.2, width = 0.25)
#'
#' @importFrom grid grobTree
#' @importFrom ggplot2 layer
#' @export
geom_boxplot2 <- function(mapping = NULL,
                          data = NULL,
                          stat = "boxplot",
                          position = "dodge2",
                          ...,
                          outlier.colour = NULL,
                          outlier.color = NULL,
                          outlier.fill = NULL,
                          outlier.shape = 19,
                          outlier.size = 1.5,
                          outlier.stroke = 0.5,
                          outlier.alpha = NULL,
                          show.errorbar = TRUE,
                          width.errorbar = 0.7,
                          notch = FALSE,
                          notchwidth = 0.5,
                          varwidth = FALSE,
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE) {
    
    # varwidth = TRUE is not compatible with preserve = "total"
    if (is.character(position)) {
        if (varwidth == TRUE) position <- ggplot2::position_dodge2(preserve = "single")
    } else {
        if (identical(position$preserve, "total") & varwidth == TRUE) {
            warning("Can't preserve total widths when varwidth = TRUE.", call. = FALSE)
            position$preserve <- "single"
        }
    }
    
  ggplot2::layer(
        data = data,
        mapping = mapping,
        stat = stat,
        geom = GeomBoxplot2,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(
            outlier.colour = outlier.color %||% outlier.colour,
            outlier.fill = outlier.fill,
            outlier.shape = outlier.shape,
            outlier.size = outlier.size,
            outlier.stroke = outlier.stroke,
            outlier.alpha = outlier.alpha,
            show.errorbar = show.errorbar,
            width.errorbar = width.errorbar,
            notch = notch,
            notchwidth = notchwidth,
            varwidth = varwidth,
            na.rm = na.rm,
            ...
        )
    )
}

#' 
#' No description
#' 
#' @format NULL
#' @usage NULL
#' 
#' @param mapping mapping
#' @param data data
#' @param stat stat
#' @param position position
#' @param ... ...
#' @param outlier.colour outlier.colour
#' @param outlier.color outlier.color
#' @param outlier.fill outlier.fill
#' @param outlier.shape outlier.shape
#' @param outlier.size outlier.size
#' @param outlier.stroke outlier.stroke
#' @param outlier.alpha outlier.alpha
#' @param na.rm na.rm
#' @param show.legend show.legend
#' @param inherit.aes inherit.aes
#' 
#' @export
GeomBoxplot2 <- ggplot2::ggproto("GeomBoxplot2", ggplot2::Geom,
                        
                        # need to declare `width`` here in case this geom is used with a stat that
                        # doesn't have a `width` parameter (e.g., `stat_identity`).
                        extra_params = c("na.rm", "width"),
                        
                        setup_data = function(data, params) {
                            data$width <- data$width %||%
                                params$width %||% (resolution(data$x, FALSE) * 0.9)
                            
                            data$outliers <- NULL
                            if (!is.null(data$outliers)) {
                                suppressWarnings({
                                    out_min <- vapply(data$outliers, min, numeric(1))
                                    out_max <- vapply(data$outliers, max, numeric(1))
                                })
                                
                                data$ymin_final <- pmin(out_min, data$ymin)
                                data$ymax_final <- pmax(out_max, data$ymax)
                            }
                            
                            # if `varwidth` not requested or not available, don't use it
                            if (is.null(params) || is.null(params$varwidth) || !params$varwidth || is.null(data$relvarwidth)) {
                                data$xmin <- data$x - data$width / 2
                                data$xmax <- data$x + data$width / 2
                            } else {
                                # make `relvarwidth` relative to the size of the largest group
                                data$relvarwidth <- data$relvarwidth / max(data$relvarwidth)
                                data$xmin <- data$x - data$relvarwidth * data$width / 2
                                data$xmax <- data$x + data$relvarwidth * data$width / 2
                            }
                            # data$width <- NULL
                            if (!is.null(data$relvarwidth)) data$relvarwidth <- NULL
                            data
                        },
                        
                        draw_group = function(data, panel_params, coord, fatten = 2,
                                              outlier.colour = NULL, outlier.fill = NULL,
                                              outlier.shape = 19,
                                              outlier.size = 1.5, outlier.stroke = 0.5,
                                              outlier.alpha = NULL,
                                              show.errorbar = TRUE,
                                              width.errorbar = 0.7,
                                              notch = FALSE, notchwidth = 0.5, varwidth = FALSE) {
                            common <- list(
                                colour   = data$colour,
                                size     = data$size,
                                linetype = data$linetype,
                                fill     = alpha(data$fill, data$alpha),
                                group    = data$group
                            )

                            whiskers <- new_data_frame(c(
                                list(
                                    x     = c(data$x, data$x),
                                    xend  = c(data$x, data$x),
                                    y     = c(data$upper, data$lower),
                                    yend  = c(data$ymax, data$ymin),
                                    alpha = c(NA_real_, NA_real_)
                                ),
                                common
                            ), n = 2)

                            box <- new_data_frame(c(
                                list(
                                    xmin = data$xmin,
                                    xmax = data$xmax,
                                    ymin = data$lower,
                                    y = data$middle,
                                    ymax = data$upper,
                                    ynotchlower = ifelse(notch, data$notchlower, NA),
                                    ynotchupper = ifelse(notch, data$notchupper, NA),
                                    notchwidth = notchwidth,
                                    alpha = data$alpha
                                ),
                                common
                            ))
                            
                            errorbar <- new_data_frame(c(
                                list(
                                    xmin = data$x - width.errorbar / 2, 
                                    xmax = data$x + width.errorbar / 2,
                                    x = data$x, 
                                    ymin = data$ymin,
                                    ymax = data$ymax, 
                                    alpha = data$alpha
                                ), 
                                common
                            ))

                            grob_whiskers <- ggplot2::GeomSegment$draw_panel(whiskers, panel_params, coord)
                            grob_errorbar <- NULL

                            if (show.errorbar) {
                                grob_errorbar <- GeomErrorbar$draw_panel(errorbar, panel_params, coord)
                            }
                            # if (!is.null(data$outliers) && length(data$outliers[[1]] >= 1)) {
                            #     outliers <- new_data_frame(
                            #         y = data$outliers[[1]],
                            #         x = data$x[1],
                            #         colour = outlier.colour %||% data$colour[1],
                            #         fill = outlier.fill %||% data$fill[1],
                            #         shape = outlier.shape %||% data$shape[1],
                            #         size = outlier.size %||% data$size[1],
                            #         stroke = outlier.stroke %||% data$stroke[1],
                            #         fill = NA,
                            #         alpha = outlier.alpha %||% data$alpha[1],
                            #         stringsAsFactors = FALSE
                            #     )
                            #     outliers_grob <- GeomPoint$draw_panel(outliers, panel_params, coord)
                            # } else {
                            #     outliers_grob <- NULL
                            # }
                            
                            ggplot2:::ggname("geom_boxplot2", grobTree(
                                # outliers_grob,
                                grob_errorbar,
                                # grob_whiskers,
                                GeomCrossbar$draw_panel(box, fatten = fatten, panel_params, coord)
                            ))
                        },
                        
                        draw_key = ggplot2::draw_key_boxplot,
                        default_aes = ggplot2::aes(weight = 1, colour = "grey20", fill = "white", size = 0.5,
                                          alpha = NA, shape = 19, linetype = "solid"),
                        
                        required_aes = c("x", "lower", "upper", "middle", "ymin", "ymax")
)

`%||%` <- function (a, b) 
{
    if (!is.null(a)) 
        a
    else b
}

# Fast data.frame constructor and indexing
# No checking, recycling etc. unless asked for
new_data_frame <- function(x = list(), n = NULL) {
  if (length(x) != 0 && is.null(names(x))) stop("Elements must be named", call. = FALSE)
  lengths <- vapply(x, length, integer(1))
  if (is.null(n)) {
    n <- if (length(x) == 0) 0 else max(lengths)
  }
  for (i in seq_along(x)) {
    if (lengths[i] == n) next
    if (lengths[i] != 1) stop("Elements must equal the number of rows or 1", call. = FALSE)
    x[[i]] <- rep(x[[i]], n)
  }

  class(x) <- "data.frame"

  attr(x, "row.names") <- .set_row_names(n)
  x
}
