#' NA-aware Correlation Function
#'
#' @description
#' Drop-in replacement for `cor()` that defaults to
#' `use = "pairwise.complete.obs"`.
#'
#' @param x A numeric vector, matrix, or data frame.
#' @param y Optional. A numeric vector, matrix, or data frame.
#' @param use Method for handling missing values.
#'   Default `"pairwise.complete.obs"`.
#' @param method Correlation method: "pearson", "kendall", or "spearman".
#' @param ... Additional arguments passed to `stats::cor()`.
#'
#' @return A correlation matrix or single correlation coefficient.
#'
#' @examples
#' x <- c(1, 2, NA, 4)
#' y <- c(2, 4, 6, 8)
#' cor(x, y)
#'
#' @name correlation-functions
NULL

#' @rdname correlation-functions
#' @export
cor <- function(x, y = NULL, use = "pairwise.complete.obs",
                method = c("pearson", "kendall", "spearman"), ...) {
  method <- match.arg(method)
  warn <- isTRUE(getOption("tidyna.warn", TRUE))

  has_na <- anyNA(x) || (!is.null(y) && anyNA(y))
  uses_complete <- use %in% c("pairwise.complete.obs", "complete.obs")

  if (has_na && uses_complete && warn) {
    cli::cli_warn(
      cli::col_yellow("\u26a0\ufe0f Missing values handled via '{use}'.")
    )
  }

  stats::cor(x, y = y, use = use, method = method, ...)
}
