# NA-aware weighted mean

Drop-in replacement for
[`stats::weighted.mean()`](https://rdrr.io/r/stats/weighted.mean.html)
that defaults to `na.rm = TRUE` and warns when missing values are
removed. Unlike base R, missing values in either `x` or `w` cause the
corresponding pair to be removed.

## Usage

``` r
weighted.mean(x, w, ..., na.rm = TRUE, all_na = NULL)
```

## Arguments

- x:

  A numeric vector of values.

- w:

  A numeric vector of weights the same length as `x`.

- ...:

  Additional arguments passed to
  [`stats::weighted.mean()`](https://rdrr.io/r/stats/weighted.mean.html).

- na.rm:

  Logical. Should missing values be removed? Default `TRUE`.

- all_na:

  Character. What to do when all values are NA: `"error"` (default)
  throws an error, `"base"` returns what base R does with
  `na.rm = TRUE`, `"na"` returns `NA`. If `NULL`, uses
  `getOption("tidyna.all_na", "error")`.

## Value

A length-one numeric vector.

## Examples

``` r
x <- c(1, 2, NA, 4)
w <- c(1, 1, 1, 1)
weighted.mean(x, w)
#> Warning: ⚠️ 1 missing value removed.
#> [1] 2.333333
```
