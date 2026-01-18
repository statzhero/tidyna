#' @keywords internal
"_PACKAGE"

#' @section Masked functions:
#' When you attach tidyna with `library(tidyna)`, it masks these
#' base/stats functions:
#' \itemize{
#'   \item `mean`, `sum`, `prod` (base)
#'   \item `min`, `max`, `range`, `pmax`, `pmin` (base)
#'   \item `any`, `all` (base)
#'   \item `sd`, `var`, `median`, `quantile` (stats)
#'   \item `rowMeans`, `rowSums` (base)
#'   \item `cor` (stats)
#'   \item `table` (base)
#' }
#'
#' @section Options:
#' \itemize{
#'   \item `tidyna.warn`: Set to `FALSE` to suppress warnings. Default `TRUE`.
#' }
#'
#' @section Related packages:
#' \itemize{
#'   \item \href{https://cran.r-project.org/package=naflex}{naflex}: Conditional
#'     NA removal based on thresholds (e.g., remove only if <5)
#'   \item \href{https://cran.r-project.org/package=na.tools}{na.tools}:
#'     Utilities for working with missing values
#' }
