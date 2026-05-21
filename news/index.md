# Changelog

## tidyna 0.5.0

- [`weighted.mean()`](https://statzhero.github.io/tidyna/reference/weighted.mean.md)
  now defaults to `na.rm = TRUE` and warns when missing values are
  removed. Unlike base R, missing values in either `x` or `w` cause the
  corresponding pair to be dropped.

## tidyna 0.4.1

- [`quantile()`](https://statzhero.github.io/tidyna/reference/summary-functions.md)
  now works without naming the `probs` argument, e.g.,
  `quantile(x, c(0.25, 0.5, 0.75))`.

## tidyna 0.4.0

CRAN release: 2026-01-27

- All functions now support configurable all-NA behavior via the
  `all_na` argument. Choose `"error"` (default, current behavior),
  `"base"` (return base R values like NaN, Inf, 0 depending on the
  function), or `"na"` (always return NA). Set globally with
  `options(tidyna.all_na = "base")`.

## tidyna 0.3.0

- [`pmax()`](https://statzhero.github.io/tidyna/reference/extrema-functions.md)
  and
  [`pmin()`](https://statzhero.github.io/tidyna/reference/extrema-functions.md)
  now default to `na.rm = TRUE` and warn when NAs are removed. Positions
  where all inputs are NA return NA with a warning. All-NAs in every
  position yields an error.

## tidyna 0.2.0

- [`range()`](https://statzhero.github.io/tidyna/reference/extrema-functions.md)
  now defaults to `na.rm = TRUE` and warns when NAs are removed.
  Supports `finite` argument to also remove infinite values with a
  warning.

## tidyna 0.1.3

- Small QoL changes.

## tidyna 0.1.0

- Initial release with NA-aware versions of common R functions:
  [`mean()`](https://statzhero.github.io/tidyna/reference/summary-functions.md),
  [`sum()`](https://statzhero.github.io/tidyna/reference/summary-functions.md),
  [`prod()`](https://statzhero.github.io/tidyna/reference/summary-functions.md),
  [`min()`](https://statzhero.github.io/tidyna/reference/extrema-functions.md),
  [`max()`](https://statzhero.github.io/tidyna/reference/extrema-functions.md),
  [`any()`](https://statzhero.github.io/tidyna/reference/logical-functions.md),
  [`all()`](https://statzhero.github.io/tidyna/reference/logical-functions.md),
  [`sd()`](https://statzhero.github.io/tidyna/reference/summary-functions.md),
  [`var()`](https://statzhero.github.io/tidyna/reference/summary-functions.md),
  [`median()`](https://statzhero.github.io/tidyna/reference/summary-functions.md),
  [`quantile()`](https://statzhero.github.io/tidyna/reference/summary-functions.md),
  [`rowMeans()`](https://statzhero.github.io/tidyna/reference/row-functions.md),
  [`rowSums()`](https://statzhero.github.io/tidyna/reference/row-functions.md),
  [`cor()`](https://statzhero.github.io/tidyna/reference/correlation-functions.md),
  and
  [`table()`](https://statzhero.github.io/tidyna/reference/table-functions.md).
