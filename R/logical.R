#' NA-aware Logical Functions
#'
#' @description
#' Drop-in replacements for `any()` and `all()` that default to `na.rm = TRUE`.
#'
#' @inheritParams summary-functions
#'
#' @examples
#' x <- c(TRUE, NA, FALSE)
#' any(x)
#' all(x)
#'
#' @name logical-functions
NULL

#' @rdname logical-functions
#' @export
any <- make_narm_true(base::any)

#' @rdname logical-functions
#' @export
all <- make_narm_true(base::all)
