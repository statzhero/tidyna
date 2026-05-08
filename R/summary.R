#' NA-aware Summary Functions
#'
#' @description
#' Drop-in replacements for summary functions that default to `na.rm = TRUE`
#' and warn when missing values are removed.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#' @param all_na Character. What to do when all values are NA:
#'   `"error"` (default) throws an error, `"base"` returns what base R does
#'   with `na.rm = TRUE` (e.g., `NaN` for `mean()`, `0` for `sum()`),
#'   `"na"` returns `NA`. If `NULL`, uses `getOption("tidyna.all_na", "error")`.
#' @param ... Additional arguments passed to the base function.
#'
#' @return The computed summary statistic.
#'
#' @examples
#' x <- c(1, 2, NA, 4)
#' mean(x)
#'
#' # Suppress warnings
#' options(tidyna.warn = FALSE)
#' mean(x)
#' options(tidyna.warn = TRUE)
#'
#' # Control all-NA behavior
#' mean(c(NA, NA), all_na = "na")
#'
#' @name summary-functions
NULL

#' @rdname summary-functions
#' @export
mean <- make_narm_true(base::mean)

#' @rdname summary-functions
#' @export
sum <- make_narm_true(base::sum)

#' @rdname summary-functions
#' @export
prod <- make_narm_true(base::prod)

#' @rdname summary-functions
#' @export
sd <- make_narm_true(stats::sd)

#' @rdname summary-functions
#' @export
var <- make_narm_true(stats::var)

#' @rdname summary-functions
#' @export
median <- make_narm_true(stats::median)

#' @rdname summary-functions
#' @export
quantile <- make_narm_true(stats::quantile)

#' NA-aware weighted mean
#'
#' Drop-in replacement for [stats::weighted.mean()] that defaults to
#' `na.rm = TRUE` and warns when missing values are removed.
#' Unlike base R, missing values in either `x` or `w` cause the
#' corresponding pair to be removed.
#'
#' @param x A numeric vector of values.
#' @param w A numeric vector of weights the same length as `x`.
#' @param ... Additional arguments passed to [stats::weighted.mean()].
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#' @param all_na Character. What to do when all values are NA:
#'   `"error"` (default) throws an error, `"base"` returns what base R does
#'   with `na.rm = TRUE`, `"na"` returns `NA`.
#'   If `NULL`, uses `getOption("tidyna.all_na", "error")`.
#'
#' @return A length-one numeric vector.
#'
#' @examples
#' x <- c(1, 2, NA, 4)
#' w <- c(1, 1, 1, 1)
#' weighted.mean(x, w)
#'
#' @export
weighted.mean <- function(x, w, ..., na.rm = TRUE, all_na = NULL) {
  all_na <- resolve_all_na(all_na)

  if (na.rm) {
    na_mask <- is.na(x) | if (!missing(w)) is.na(w) else FALSE
    n_na <- base::sum(na_mask)

    if (n_na > 0L) {
      if (base::all(na_mask)) {
        return(switch(all_na,
          error = cli::cli_abort(
            "All values are NA; check if something went wrong."
          ),
          base = stats::weighted.mean(x, w, ..., na.rm = TRUE),
          na = NA
        ))
      }
      if (isTRUE(getOption("tidyna.warn", TRUE))) {
        cli::cli_warn(
          cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed.")
        )
      }
      keep <- !na_mask
      x <- x[keep]
      if (!missing(w)) w <- w[keep]
    }
  }

  if (missing(w)) {
    stats::weighted.mean(x, ..., na.rm = FALSE)
  } else {
    stats::weighted.mean(x, w, ..., na.rm = FALSE)
  }
}
