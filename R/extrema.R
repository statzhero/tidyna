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
#' pmin(c(1, NA, 3), c(NA, 2, 1))
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

#' @rdname extrema-functions
#' @export
pmax <- function(..., na.rm = TRUE) {
  args <- list(...)
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  if (length(args) == 0) return(base::pmax())

  max_len <- max(lengths(args))
  args_recycled <- lapply(args, rep_len, max_len)
  all_na_positions <- Reduce(`&`, lapply(args_recycled, is.na))

  if (na.rm && all(all_na_positions)) {
    cli::cli_abort("All values are NA; check if something went wrong.")
  }

  if (na.rm && anyNA(unlist(args)) && warn) {
    n_all_na <- sum(all_na_positions)

    total_na <- sum(vapply(args_recycled, \(x) sum(is.na(x)), integer(1)))
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

  max_len <- max(lengths(args))
  args_recycled <- lapply(args, rep_len, max_len)
  all_na_positions <- Reduce(`&`, lapply(args_recycled, is.na))

  if (na.rm && all(all_na_positions)) {
    cli::cli_abort("All values are NA; check if something went wrong.")
  }

  if (na.rm && anyNA(unlist(args)) && warn) {
    n_all_na <- sum(all_na_positions)

    total_na <- sum(vapply(args_recycled, \(x) sum(is.na(x)), integer(1)))
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
