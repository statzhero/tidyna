.onLoad <- function(libname, pkgname) {

  op <- options()
  op_tidyna <- list(
    tidyna.warn = TRUE,
    tidyna.all_na = "error"
  )
  toset <- !(names(op_tidyna) %in% names(op))
  if (any(toset)) options(op_tidyna[toset])
  invisible()
}

.onAttach <- function(libname, pkgname) {

  fns <- c(
    "mean", "sum", "prod", "min", "max", "range", "pmax", "pmin",
    "any", "all", "sd", "var", "median", "quantile"
  )

  fns2 <- c("rowMeans", "rowSums", "cor", "table")

  header <- cli::rule(
    left = cli::style_bold("\u26a0\ufe0f tidyna masks core R stats functions"),
    right = paste0("tidyna ", utils::packageVersion("tidyna"))
  )

  msg <- paste0(
    cli::symbol$arrow_right, " Masked: ", cli::col_blue(paste(fns, collapse = ", ")), "\n",
    "  \u2022 These now default to ", cli::col_cyan("na.rm = TRUE"), " and warn when NAs are removed.\n",
    cli::symbol$arrow_right, " Masked with comparable behavior: ", cli::col_blue(paste(fns2, collapse = ", ")), "\n",
    "  \u2022 Silence NA warnings with ", cli::col_cyan("options(tidyna.warn = FALSE)"), ".\n",
    "  \u2022 Set all-NA behavior with ", cli::col_cyan("options(tidyna.all_na = \"base\")"), " or ", cli::col_cyan("\"na\""), ".\n",
    "  \u2022 Silence this startup message with ", cli::col_cyan("suppressPackageStartupMessages(library(tidyna))"), "."
  )

  packageStartupMessage(header, "\n", msg)
}
