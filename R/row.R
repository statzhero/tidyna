#' NA-aware Row-wise Functions
#'
#' @description
#' Drop-in replacements for `rowMeans()` and `rowSums()` that default to
#' `na.rm = TRUE`. Both return `NA` for rows where ALL values are missing
#' (base `rowMeans()` returns `NaN`, base `rowSums()` returns `0`).
#'
#' @param x A numeric matrix or data frame.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
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
rowMeans <- function(x, na.rm = TRUE, dims = 1L, ...) {
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  # Vectorized: count non-NA values per row via base::rowSums
  all_na_rows <- base::rowSums(!is.na(x), dims = dims) == 0L

  if (na.rm && base::all(all_na_rows)) {
    cli::cli_abort("All values are NA; check if something went wrong.")
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
rowSums <- function(x, na.rm = TRUE, dims = 1L, ...) {
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  # Vectorized: count non-NA values per row via base::rowSums
  all_na_rows <- base::rowSums(!is.na(x), dims = dims) == 0L

  if (na.rm && base::all(all_na_rows)) {
    cli::cli_abort("All values are NA; check if something went wrong.")
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
