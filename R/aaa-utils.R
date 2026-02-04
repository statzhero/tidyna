#' Resolve all_na behavior from argument or global option
#'
#' @param all_na User-supplied argument (NULL to use option).
#' @return Character: "error", "base", or "na".
#' @keywords internal
#' @noRd
resolve_all_na <- function(all_na = NULL) {
  if (is.null(all_na)) {
    all_na <- getOption("tidyna.all_na", "error")
  }

  match.arg(all_na, c("error", "base", "na"))
}

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
  function(x, ..., na.rm = TRUE, all_na = NULL) {
    all_na <- resolve_all_na(all_na)
    if (na.rm && anyNA(x)) {
      if (base::all(is.na(x))) {
        return(switch(all_na,
          error = cli::cli_abort("All values are NA; check if something went wrong."),
          base = base_fn(x, ..., na.rm = TRUE),
          na = NA
        ))
      }
      if (isTRUE(getOption("tidyna.warn", TRUE))) {
        n_na <- base::sum(is.na(x))
        cli::cli_warn(
          cli::col_yellow("\u26a0\ufe0f {n_na} missing value{?s} removed.")
        )
      }
    }
    base_fn(x, ..., na.rm = na.rm)
  }
}
