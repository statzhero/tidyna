#' NA-aware Extrema Functions
#'
#' @description
#' Drop-in replacements for `min()`, `max()`, and `range()` that default to
#' `na.rm = TRUE`.
#'
#' @param ... Numeric or character arguments.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#' @param finite Logical. If `TRUE`, removes all non-finite values (NA, NaN,
#'   Inf, -Inf). Only applies to `range()`. Default `FALSE`.
#'
#' @return For `min()` and `max()`, a length-one vector. For `range()`, a
#'   length-two vector containing the minimum and maximum.
#'
#' @examples
#' x <- c(1, NA, 5, 3)
#' min(x)
#' max(x)
#' range(x)
#'
#' # Multiple arguments
#' min(c(5, NA), c(1, 2))
#'
#' # range with infinite values
#' y <- c(1, Inf, 3, -Inf)
#' range(y)
#' range(y, finite = TRUE)
#'
#' @name extrema-functions
NULL

#' @rdname extrema-functions
#' @export
min <- function(..., na.rm = TRUE) {
  args <- c(...)

  if (na.rm && length(args) > 0 && all(is.na(args))) {
    cli::cli_abort("All values are NA; check if something went wrong.")
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

  if (na.rm && length(args) > 0 && all(is.na(args))) {
    cli::cli_abort("All values are NA; check if something went wrong.")
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

#' @rdname extrema-functions
#' @export
range <- function(..., na.rm = TRUE, finite = FALSE) {
  args <- c(...)

  # Match base::range() where finite = TRUE handles all non-finite values
  if (finite) na.rm <- TRUE

  is_inf <- is.infinite(args)
  is_nan <- is.nan(args)
  is_na_only <- is.na(args) & !is_nan

  to_remove <- if (finite) {
    is_na_only | is_nan | is_inf
  } else if (na.rm) {
    is_na_only | is_nan
  } else {
    rep(FALSE, length(args))
  }

  if (na.rm && length(args) > 0 && all(to_remove)) {
    cli::cli_abort("All values are NA or non-finite; check if something went wrong.")
  }

  if (na.rm && isTRUE(getOption("tidyna.warn", TRUE))) {
    n_na <- sum(is_na_only)
    n_nan <- sum(is_nan)
    n_inf <- if (finite) sum(is_inf) else 0L

    if (n_na > 0) {
      cli::cli_warn(cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed."))
    }
    if (n_nan > 0) {
      cli::cli_warn(cli::col_yellow("\u26a0\ufe0f {n_nan} NaN value{?s} removed."))
    }
    if (n_inf > 0) {
      cli::cli_warn(cli::col_yellow("\u26a0\ufe0f {n_inf} infinite value{?s} removed."))
    }
  }

  base::range(..., na.rm = na.rm, finite = finite)
}
