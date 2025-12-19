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
    "sd", "var", "median", "quantile"
  )

  fns2 <- c("rowMeans", "rowSums", "cor", "table")

  msg <- cli::format_message(c(
    " " = cli::col_yellow("\u26a0\ufe0f tidyna masks core R stats functions."),
    ">" = "Masked: {.field {paste(fns, collapse = ', ')}}",
    " " = "\u2022 These now default to {.code na.rm = TRUE} and warn when NAs are removed.",
    ">" = "Masked with compareable behavior: {.field {paste(fns2, collapse = ', ')}}",
    " " = "\u2022 Use {.code base::table()}, {.code stats::sd()}, etc. for original behavior.",
    " " = "\u2022 Silence NA warnings with {.code options(tidyna.warn = FALSE)}.",
    " " = "\u2022 Silence this startup message with {.code suppressPackageStartupMessages(library(tidyna))}."
  ))

  packageStartupMessage(msg)
}
  
