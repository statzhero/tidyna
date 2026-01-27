#' NA-aware Row-wise Functions
#'
#' @description
#' Drop-in replacements for `rowMeans()` and `rowSums()` that default to
#' `na.rm = TRUE`. Both return `NA` for rows where ALL values are missing
#' (base `rowMeans()` returns `NaN`, base `rowSums()` returns `0`).
#'
#' @param x A numeric matrix or data frame.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#' @param all_na Character. What to do when all values are NA:
#'   `"error"` (default) throws an error, `"base"` returns what base R does
#'   with `na.rm = TRUE` (`NaN` for `rowMeans()`, `0` for `rowSums()`),
#'   `"na"` returns `NA`. If `NULL`, uses `getOption("tidyna.all_na", "error")`.
#' @param dims Integer. Number of dimensions to treat as rows.
#' @param ... Additional arguments passed to the base function.
#'
#' @return A numeric or complex array of suitable size, or a vector if the
#'   result is one-dimensional.
#'
#' @examples
#' mat <- matrix(c(1, NA, 3, NA, NA, NA), nrow = 2, byrow = TRUE)
#' rowSums(mat)
#'
#' # Compare to base R:
#' base::rowSums(mat, na.rm = TRUE)
#'
#' @name row-functions
NULL

#' @rdname row-functions
#' @export
rowMeans <- function(x, na.rm = TRUE, all_na = NULL, dims = 1L, ...) {
  all_na <- resolve_all_na(all_na)
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  all_na_rows <- base::rowSums(!is.na(x), dims = dims) == 0L

  if (na.rm && base::all(all_na_rows)) {
    return(switch(all_na,
      error = cli::cli_abort("All values are NA; check if something went wrong."),
      base = base::rowMeans(x, na.rm = TRUE, dims = dims, ...),
      na = rep(NA_real_, nrow(x))
    ))
  }

  if (na.rm && anyNA(x) && warn) {
    n_na <- base::sum(is.na(x))
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed.")
    )
  }

  if (base::any(all_na_rows) && warn) {
    n_all_na <- base::sum(all_na_rows)
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f {n_all_na} row{?s} had all NA values.")
    )
  }

  result <- base::rowMeans(x, na.rm = na.rm, dims = dims, ...)
  result[all_na_rows] <- NA
  result
}

#' @rdname row-functions
#' @export
rowSums <- function(x, na.rm = TRUE, all_na = NULL, dims = 1L, ...) {
  all_na <- resolve_all_na(all_na)
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  all_na_rows <- base::rowSums(!is.na(x), dims = dims) == 0L

  if (na.rm && base::all(all_na_rows)) {
    return(switch(all_na,
      error = cli::cli_abort("All values are NA; check if something went wrong."),
      base = base::rowSums(x, na.rm = TRUE, dims = dims, ...),
      na = rep(NA_real_, nrow(x))
    ))
  }

  if (na.rm && anyNA(x) && warn) {
    n_na <- base::sum(is.na(x))
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed.")
    )
  }

  if (base::any(all_na_rows) && warn) {
    n_all_na <- base::sum(all_na_rows)
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f {n_all_na} row{?s} had all NA values.")
    )
  }

  result <- base::rowSums(x, na.rm = na.rm, dims = dims, ...)
  result[all_na_rows] <- NA
  result
}
