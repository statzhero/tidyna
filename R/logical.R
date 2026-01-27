#' NA-aware Logical Functions
#'
#' @description
#' Drop-in replacements for `any()` and `all()` that default to `na.rm = TRUE`.
#'
#' @param x A logical vector.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#' @param all_na Character. What to do when all values are NA:
#'   `"error"` (default) throws an error, `"base"` returns what base R does
#'   with `na.rm = TRUE` (`FALSE` for `any()`, `TRUE` for `all()`),
#'   `"na"` returns `NA`. If `NULL`, uses `getOption("tidyna.all_na", "error")`.
#' @param ... Additional arguments passed to the base function.
#'
#' @return A single logical value.
#'
#' @examples
#' x <- c(TRUE, NA, FALSE)
#' any(x)
#' all(x)
#'
#' @name logical-functions
NULL

#' @rdname logical-functions
#' @export
any <- make_narm_true(base::any)

#' @rdname logical-functions
#' @export
all <- make_narm_true(base::all)
