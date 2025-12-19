#' Create NA-aware wrapper for a function
#'
#' Internal factory function to create wrappers that default to na.rm = TRUE
#' and issue warnings when NAs are removed.
#'
#' @param base_fn The base function to wrap.
#' @return A function with na.rm defaulting to TRUE.
#' @keywords internal
#' @noRd
make_narm_true <- function(base_fn) {
  function(x, na.rm = TRUE, ...) {
    if (na.rm && anyNA(x) && isTRUE(getOption("tidyna.warn", TRUE))) {
      cli::cli_warn(
        cli::col_yellow("\u26a0\ufe0f Missing values found and removed.")
      )
    }
    base_fn(x, na.rm = na.rm, ...)
  }
}
