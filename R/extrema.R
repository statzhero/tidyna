#' NA-aware Extrema Functions
#'
#' @description
#' Drop-in replacements for `min()` and `max()` that default to `na.rm = TRUE`.
#'
#' @param ... Numeric or character arguments.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#'
#' @examples
#' x <- c(1, NA, 5, 3)
#' min(x)
#' max(x)
#'
#' # Multiple arguments
#' min(c(5, NA), c(1, 2))
#'
#' @name extrema-functions
NULL

#' @rdname extrema-functions
#' @export
min <- function(..., na.rm = TRUE) {
  args <- c(...)
  if (na.rm && anyNA(args) && isTRUE(getOption("tidyna.warn", TRUE))) {
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f Missing values found and removed.")
    )
  }
  base::min(..., na.rm = na.rm)
}

#' @rdname extrema-functions
#' @export
max <- function(..., na.rm = TRUE) {
  args <- c(...)
  if (na.rm && anyNA(args) && isTRUE(getOption("tidyna.warn", TRUE))) {
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f Missing values found and removed.")
    )
  }
  base::max(..., na.rm = na.rm)
}
