# NA-aware Extrema Functions

Drop-in replacements for `min()`, `max()`, `range()`, `pmax()`, and
`pmin()` that default to `na.rm = TRUE`.

## Usage

``` r
min(..., na.rm = TRUE, all_na = NULL)

max(..., na.rm = TRUE, all_na = NULL)

range(..., na.rm = TRUE, all_na = NULL, finite = FALSE)

pmax(..., na.rm = TRUE, all_na = NULL)

pmin(..., na.rm = TRUE, all_na = NULL)
```

## Arguments

- ...:

  Numeric or character arguments.

- na.rm:

  Logical. Should missing values be removed? Default `TRUE`.

- all_na:

  Character. What to do when all values are NA: `"error"` (default)
  throws an error, `"base"` returns what base R does with `na.rm = TRUE`
  (e.g., `Inf` for `min()`, `-Inf` for `max()`), `"na"` returns `NA`. If
  `NULL`, uses `getOption("tidyna.all_na", "error")`.

- finite:

  Logical. If `TRUE`, removes all non-finite values (NA, NaN, Inf,
  -Inf). Only applies to `range()`. Default `FALSE`.

## Value

For `min()` and `max()`, a length-one vector. For `range()`, a
length-two vector containing the minimum and maximum. For `pmax()` and
`pmin()`, a vector of length equal to the longest input.

## Examples

``` r
x <- c(1, NA, 5, 3)
min(x)
#> Warning: ⚠️ 1 missing value removed.
#> [1] 1
max(x)
#> Warning: ⚠️ 1 missing value removed.
#> [1] 5
range(x)
#> Warning: ⚠️ 1 missing value removed.
#> [1] 1 5

# Multiple arguments
min(c(5, NA), c(1, 2))
#> Warning: ⚠️ 1 missing value removed.
#> [1] 1

# Parallel max/min
pmax(c(1, 5, 3), c(2, 1, 4))
#> [1] 2 5 4
pmin(c(1, NA, 3), c(NA, NA, 1))
#> Warning: ⚠️ 1 missing value removed.
#> Warning: ⚠️ 1 position had all NA values.
#> [1]  1 NA  1

# range with infinite values
y <- c(1, Inf, 3, -Inf)
range(y)
#> [1] -Inf  Inf
range(y, finite = TRUE)
#> Warning: ⚠️ 2 infinite values removed.
#> [1] 1 3
```
