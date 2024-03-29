#' My ggplot2 go-to theme inspired by \code{hrbrthemes}
#' @param ... Parameters for \code{hrbrthemes::theme_ipsum}
#' @param base_size 10
#' @param plot_margin ggplot2::margin(10, 10, 10, 10)
#' @param axis_title_size 10
#' @param grid_col "grey80"
#'
#' @param plot_title_face plot_title_face
#' @importFrom ggplot2 theme margin element_blank
#' @importFrom hrbrthemes theme_ipsum
#' @examples
#'
#' \dontrun{
#'
#' library(ggplot2)
#' library(extrafont)
#' library(hrbrthemes)
#'
#' p <- ggplot(mtcars) +
#'    geom_point(aes(mpg, hp, color = factor(carb)), size = 2.5) +
#'    hrbrthemes::scale_color_ipsum(name = "Carb") +
#'    labs(
#'      x = "Fuel effiiency (mpg)", y="Weight (tons)",
#'      title = "Seminal ggplot2 scatterplot example",
#'      subtitle = "A plot that is only useful for demonstration purposes",
#'      caption = "Brought to you by the letter 'g'"
#'      ) +
#'  theme_knst()
#'
#' p
#'
#' pp <- p + facet_wrap(vars(factor(carb)))
#'
#' pp + theme_knst(base_family = "Calibri")
#'
#' pp + theme_knst_segoe()
#' pp + theme_knst_calibri(base_size = 15, axis_title_size = 15)
#'
#' pp +
#'   theme_knst(
#'     base_family = "Calibri Light",
#'     plot_title_family = "Calibri"
#'    )
#'
#' }
#'
#' @export
theme_knst <- function(...,
                       base_size = 10,
                       plot_margin = ggplot2::margin(10, 10, 10, 10),
                       axis_title_size = 10,
                       grid_col = "grey80"
                       ) {

  hrbrthemes::theme_ipsum(
    base_size = base_size,
    plot_margin = plot_margin,
    axis_title_size = axis_title_size,
    grid_col = grid_col,
    ...
  ) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      legend.position = "bottom"
    )

}

#' @rdname theme_knst
#' @export
theme_knst_calibri <- function(..., plot_title_face = "plain") {
  theme_knst(
    base_family = "Calibri Light",
    plot_title_face = plot_title_face,
    ...
    )
}

#' @rdname theme_knst
#' @export
theme_knst_segoe <- function(..., plot_title_face = "plain") {
  theme_knst(
    base_family = "Segoe UI",
    plot_title_face = plot_title_face,
    ...
  )
}


#' Geom point/jitter with shape 21 and color white
#'
#' @param ... geom_point/geom_jitter parameters.
#' @param shape Shape 21
#' @param color Color "white"
#' @examples
#'
#' ggplot(iris) +
#'   geom_jitter(aes(Sepal.Length, Sepal.Width, color = Species))
#'
#' ggplot(iris) +
#'   geom_jitter2(aes(Sepal.Length, Sepal.Width, fill = Species))
#'
#' ggplot(iris) +
#'   geom_point(aes(Sepal.Length, Sepal.Width, color = Species))
#'
#' ggplot(iris) +
#'   geom_point2(aes(Sepal.Length, Sepal.Width, fill = Species))
#'
#' @importFrom ggplot2 geom_point
#' @export
geom_point2 <- function(..., shape = 21, color = "white") {
  ggplot2::geom_point(..., shape = shape, color = color)
}

#' @rdname geom_point2
#' @importFrom ggplot2 geom_jitter
#' @export
geom_jitter2 <- function(..., shape = 21, color = "white") {
  ggplot2::geom_jitter(..., shape = shape, color = color)
}
