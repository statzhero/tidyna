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

  # Error if ALL values are NA/NaN
  if (na.rm && length(args) > 0 && all(is.na(args))) {
    cli::cli_abort("All values are NA; something likely went wrong.")
  }

  if (na.rm && isTRUE(getOption("tidyna.warn", TRUE))) {
    n_nan <- sum(is.nan(args))
    n_na <- sum(is.na(args) & !is.nan(args))
    if (n_na > 0) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed.")
      )
    }
    if (n_nan > 0) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f {n_nan} NaN value{?s} removed.")
      )
    }
  }
  base::min(..., na.rm = na.rm)
}

#' @rdname extrema-functions
#' @export
max <- function(..., na.rm = TRUE) {
  args <- c(...)

  # Error if ALL values are NA/NaN
  if (na.rm && length(args) > 0 && all(is.na(args))) {
    cli::cli_abort("All values are NA; something likely went wrong.")
  }

  if (na.rm && isTRUE(getOption("tidyna.warn", TRUE))) {
    n_nan <- sum(is.nan(args))
    n_na <- sum(is.na(args) & !is.nan(args))
    if (n_na > 0) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed.")
      )
    }
    if (n_nan > 0) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f {n_nan} NaN value{?s} removed.")
      )
    }
  }
  base::max(..., na.rm = na.rm)
}
