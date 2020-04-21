#' My ggplot2 go-to theme inspired by \code{hrbrthemes}
#' @param ... Parameters for \code{hrbrthemes::theme_ipsum}
#' @importFrom ggplot2 theme_set theme margin element_blank
#' @importFrom hrbrthemes theme_ipsum
#' @examples
#'
#' \dontrun{
#'
#' library(ggplot2)
#'  library(extrafont)
#'  library(hrbrthemes)
#' 
#' p <- ggplot(mtcars) +
#'    geom_point(aes(mpg, hp, color = factor(carb)), size = 2.5) +
#'    hrbrthemes::scale_color_ipsum() +
#'    labs(x="Fuel effiiency (mpg)", y="Weight (tons)",
#'         title="Seminal ggplot2 scatterplot example",
#'         subtitle="A plot that is only useful for demonstration purposes",
#'         caption="Brought to you by the letter 'g'") +
#'   theme_knst()
#'   
#' p
#'  
#'  p + 
#'    facet_wrap(vars(factor(carb)))
#' } 
#'
#' @export
theme_knst <- function(...) {
  
  hrbrthemes::theme_ipsum_rc(
    base_size = 10,
    plot_margin = margin(10, 10, 10, 10), 
    axis_title_size = 10,
    grid_col = "grey80",
    ...
  ) +
    theme(
      panel.grid.minor = element_blank(),
      legend.position = "bottom"
    ) 
  
}
