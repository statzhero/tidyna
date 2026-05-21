# NA-aware Summary Functions

Drop-in replacements for summary functions that default to
`na.rm = TRUE` and warn when missing values are removed.

## Usage

``` r
mean(x, ..., na.rm = TRUE, all_na = NULL)

sum(x, ..., na.rm = TRUE, all_na = NULL)

prod(x, ..., na.rm = TRUE, all_na = NULL)

sd(x, ..., na.rm = TRUE, all_na = NULL)

var(x, ..., na.rm = TRUE, all_na = NULL)

median(x, ..., na.rm = TRUE, all_na = NULL)

quantile(x, ..., na.rm = TRUE, all_na = NULL)
```

## Arguments

- x:

  A numeric vector.

- ...:

  Additional arguments passed to the base function.

- na.rm:

  Logical. Should missing values be removed? Default `TRUE`.

- all_na:

  Character. What to do when all values are NA: `"error"` (default)
  throws an error, `"base"` returns what base R does with `na.rm = TRUE`
  (e.g., `NaN` for `mean()`, `0` for `sum()`), `"na"` returns `NA`. If
  `NULL`, uses `getOption("tidyna.all_na", "error")`.

## Value

The computed summary statistic.

## Examples

``` r
x <- c(1, 2, NA, 4)
mean(x)
#> Warning: ⚠️ 1 missing value removed.
#> [1] 2.333333

# Suppress warnings
options(tidyna.warn = FALSE)
mean(x)
#> [1] 2.333333
options(tidyna.warn = TRUE)

# Control all-NA behavior
mean(c(NA, NA), all_na = "na")
#> [1] NA
```
