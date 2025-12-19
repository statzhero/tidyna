.onLoad <- function(libname, pkgname) {
  op <- options()
  op_tidyna <- list(
    tidyna.warn = TRUE
  )
  toset <- !(names(op_tidyna) %in% names(op))
  if (any(toset)) options(op_tidyna[toset])
  invisible()
}

.onAttach <- function(libname, pkgname) {
  fns <- c(
    "mean", "sum", "prod", "min", "max", "any", "all",
    "sd", "var", "median", "quantile", "rowMeans", "rowSums",
    "cor", "table"
  )
  packageStartupMessage(
    pkgname, " attached: ", paste(fns, collapse = ", "),
    " now use na.rm = TRUE by default.\n",
    "Warnings issued when NAs removed. ",
    "Suppress with options(tidyna.warn = FALSE)"
  )
}
