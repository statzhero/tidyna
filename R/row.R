#' NA-aware Row-wise Functions
#'
#' @description
#' Drop-in replacements for `rowMeans()` and `rowSums()` that default to
#' `na.rm = TRUE`. Importantly, `rowSums()` returns `NA` for rows where
#' ALL values are missing.
#'
#' @param x A numeric matrix or data frame.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#' @param dims Integer. Number of dimensions to treat as rows.
#' @param ... Additional arguments passed to the base function.
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
rowMeans <- make_narm_true(base::rowMeans)

#' @rdname row-functions
#' @export
rowSums <- function(x, na.rm = TRUE, dims = 1L, ...) {
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  # Identify rows where ALL values are NA
  all_na_rows <- apply(x, 1, function(row) all(is.na(row)))

  # Error if ALL rows are all-NA (entire matrix is NA)
  if (na.rm && all(all_na_rows)) {
    cli::cli_abort("All values are NA; something likely went wrong.")
  }

  if (na.rm && anyNA(x) && warn) {
    n_na <- sum(is.na(x))
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed.")
    )
  }

  if (any(all_na_rows) && warn) {
    n_all_na <- sum(all_na_rows)
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f {n_all_na} row{?s} had all NA values.")
    )
  }

  result <- base::rowSums(x, na.rm = na.rm, dims = dims, ...)
  result[all_na_rows] <- NA
  result
}
