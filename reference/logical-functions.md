# NA-aware Logical Functions

Drop-in replacements for `any()` and `all()` that default to
`na.rm = TRUE`.

## Usage

``` r
any(x, ..., na.rm = TRUE, all_na = NULL)

all(x, ..., na.rm = TRUE, all_na = NULL)
```

## Arguments

- x:

  A logical vector.

- ...:

  Additional arguments passed to the base function.

- na.rm:

  Logical. Should missing values be removed? Default `TRUE`.

- all_na:

  Character. What to do when all values are NA: `"error"` (default)
  throws an error, `"base"` returns what base R does with `na.rm = TRUE`
  (`FALSE` for `any()`, `TRUE` for `all()`), `"na"` returns `NA`. If
  `NULL`, uses `getOption("tidyna.all_na", "error")`.

## Value

A single logical value.

## Examples

``` r
x <- c(TRUE, NA, FALSE)
any(x)
#> Warning: ⚠️ 1 missing value removed.
#> [1] TRUE
all(x)
#> Warning: ⚠️ 1 missing value removed.
#> [1] FALSE
```
