#' NA-aware Table Function
#'
#' @description
#' Drop-in replacement for `table()` that defaults to `useNA = "ifany"`,
#' showing NA counts when present.
#'
#' @param ... Objects to cross-tabulate.
#' @param useNA Whether to include NA values. Default `"ifany"`.
#'
#' @return A contingency table of class `table`.
#'
#' @examples
#' x <- c("a", "b", NA, "a", NA)
#' table(x)
#'
#' @name table-functions
NULL

#' @rdname table-functions
#' @export
table <- function(..., useNA = "ifany") {
  base::table(..., useNA = useNA)
}
