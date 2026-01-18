#' NA-aware Extrema Functions
#'
#' @description
#' Drop-in replacements for `min()`, `max()`, `range()`, `pmax()`, and `pmin()`
#' that default to `na.rm = TRUE`.
#'
#' @param ... Numeric or character arguments.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#' @param finite Logical. If `TRUE`, removes all non-finite values (NA, NaN,
#'   Inf, -Inf). Only applies to `range()`. Default `FALSE`.
#'
#' @return For `min()` and `max()`, a length-one vector. For `range()`, a
#'   length-two vector containing the minimum and maximum. For `pmax()` and
#'   `pmin()`, a vector of length equal to the longest input.
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
#' # Parallel max/min
#' pmax(c(1, 5, 3), c(2, 1, 4))
#' pmin(c(1, NA, 3), c(NA, NA, 1))
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

  if (na.rm && anyNA(args)) {
    if (base::all(is.na(args))) {
      cli::cli_abort("All values are NA; check if something went wrong.")
    }

    if (isTRUE(getOption("tidyna.warn", TRUE))) {
      n_nan <- base::sum(is.nan(args))
      n_na <- base::sum(is.na(args)) - n_nan
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
  }

  base::min(args, na.rm = na.rm)
}

#' @rdname extrema-functions
#' @export
max <- function(..., na.rm = TRUE) {
  args <- c(...)

  if (na.rm && anyNA(args)) {
    if (base::all(is.na(args))) {
      cli::cli_abort("All values are NA; check if something went wrong.")
    }

    if (isTRUE(getOption("tidyna.warn", TRUE))) {
      n_nan <- base::sum(is.nan(args))
      n_na <- base::sum(is.na(args)) - n_nan
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
  }

  base::max(args, na.rm = na.rm)
}

#' @rdname extrema-functions
#' @export
range <- function(..., na.rm = TRUE, finite = FALSE) {
  args <- c(...)

  if (finite) na.rm <- TRUE

  to_remove <- if (finite) {
    !is.finite(args)
  } else if (na.rm) {
    is.na(args)
  } else {
    rep(FALSE, length(args))
  }

  if (na.rm && length(args) > 0 && base::all(to_remove)) {
    cli::cli_abort("All values are NA or non-finite; check if something went wrong.")
  }

  if (na.rm && isTRUE(getOption("tidyna.warn", TRUE))) {
    n_na <- base::sum(is.na(args) & !is.nan(args))
    n_nan <- base::sum(is.nan(args))
    n_inf <- if (finite) base::sum(is.infinite(args)) else 0L

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

#' @rdname extrema-functions
#' @export
pmax <- function(..., na.rm = TRUE) {
  args <- list(...)
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  if (length(args) == 0) return(base::pmax())

  max_len <- base::max(lengths(args))
  args_recycled <- lapply(args, rep_len, max_len)
  all_na_positions <- Reduce(`&`, lapply(args_recycled, is.na))

  if (na.rm && base::all(all_na_positions)) {
    cli::cli_abort("All values are NA; check if something went wrong.")
  }

  if (na.rm && anyNA(unlist(args)) && warn) {
    n_all_na <- base::sum(all_na_positions)

    total_na <- base::sum(vapply(args_recycled, \(x) base::sum(is.na(x)), integer(1)))
    n_removed <- total_na - n_all_na * length(args)

    if (n_removed > 0) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f {n_removed} missing value{?s} removed.")
      )
    }
    if (n_all_na > 0) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f {n_all_na} position{?s} had all NA values.")
      )
    }
  }

  base::pmax(..., na.rm = na.rm)
}

#' @rdname extrema-functions
#' @export
pmin <- function(..., na.rm = TRUE) {
  args <- list(...)
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  if (length(args) == 0) return(base::pmin())

  max_len <- base::max(lengths(args))
  args_recycled <- lapply(args, rep_len, max_len)
  all_na_positions <- Reduce(`&`, lapply(args_recycled, is.na))

  if (na.rm && base::all(all_na_positions)) {
    cli::cli_abort("All values are NA; check if something went wrong.")
  }

  if (na.rm && anyNA(unlist(args)) && warn) {
    n_all_na <- base::sum(all_na_positions)

    total_na <- base::sum(vapply(args_recycled, \(x) base::sum(is.na(x)), integer(1)))
    n_removed <- total_na - n_all_na * length(args)

    if (n_removed > 0) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f {n_removed} missing value{?s} removed.")
      )
    }
    if (n_all_na > 0) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f {n_all_na} position{?s} had all NA values.")
      )
    }
  }

  base::pmin(..., na.rm = na.rm)
}
