#' NA-aware Summary Functions
#'
#' @description
#' Drop-in replacements for summary functions that default to `na.rm = TRUE`
#' and warn when missing values are removed.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Default `TRUE`.
#' @param ... Additional arguments passed to the base function.
#'
#' @return The computed summary statistic.
#'
#' @examples
#' x <- c(1, 2, NA, 4)
#' mean(x)
#'
#' # Suppress warnings
#' options(tidyna.warn = FALSE)
#' mean(x)
#' options(tidyna.warn = TRUE)
#'
#' # Use base behavior
#' mean(x, na.rm = FALSE)
#'
#' @name summary-functions
NULL

#' @rdname summary-functions
#' @export
mean <- make_narm_true(base::mean)

#' @rdname summary-functions
#' @export
sum <- make_narm_true(base::sum)

#' @rdname summary-functions
#' @export
prod <- make_narm_true(base::prod)

#' @rdname summary-functions
#' @export
sd <- make_narm_true(stats::sd)

#' @rdname summary-functions
#' @export
var <- make_narm_true(stats::var)

#' @rdname summary-functions
#' @export
median <- make_narm_true(stats::median)

#' @rdname summary-functions
#' @export
quantile <- make_narm_true(stats::quantile)
