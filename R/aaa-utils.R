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
    if (na.rm && anyNA(x)) {
      if (base::all(is.na(x))) {
        cli::cli_abort("All values are NA; check if something went wrong.")
      }
      if (isTRUE(getOption("tidyna.warn", TRUE))) {
        n_na <- base::sum(is.na(x))
        cli::cli_warn(
          cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed.")
        )
      }
    }
    base_fn(x, na.rm = na.rm, ...)
  }
}
