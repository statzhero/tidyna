#' @section Masked functions:
#' When you attach tidyna with `library(tidyna)`, it masks these
#' base/stats functions:
#' * `mean`, `sum`, `prod` (base)
#' * `min`, `max`, `range`, `pmax`, `pmin` (base)
#' * `any`, `all` (base)
#' * `sd`, `var`, `median`, `quantile` (stats)
#' * `rowMeans`, `rowSums` (base)
#' * `cor` (stats)
#' * `table` (base)
#'
#' @section Options:
#' * `tidyna.warn`: Set to `FALSE` to suppress warnings. Default `TRUE`.
#' * `tidyna.all_na`: Controls behavior when all values are NA. One of
#'   `"error"` (default, throws an error), `"base"` (returns base R behavior),
#'   or `"na"` (returns NA).
#'
#' @section Related packages:
#' * [naflex](https://cran.r-project.org/package=naflex): Conditional
#'   NA removal based on thresholds (e.g., remove only if <5)
#' * [na.tools](https://cran.r-project.org/package=na.tools):
#'   Utilities for working with missing values
#'
#' @keywords internal
"_PACKAGE"
