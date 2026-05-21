# NA-aware Row-wise Functions

Drop-in replacements for `rowMeans()` and `rowSums()` that default to
`na.rm = TRUE`. Both return `NA` for rows where ALL values are missing
(base `rowMeans()` returns `NaN`, base `rowSums()` returns `0`).

## Usage

``` r
rowMeans(x, na.rm = TRUE, all_na = NULL, dims = 1L, ...)

rowSums(x, na.rm = TRUE, all_na = NULL, dims = 1L, ...)
```

## Arguments

- x:

  A numeric matrix or data frame.

- na.rm:

  Logical. Should missing values be removed? Default `TRUE`.

- all_na:

  Character. What to do when all values are NA: `"error"` (default)
  throws an error, `"base"` returns what base R does with `na.rm = TRUE`
  (`NaN` for `rowMeans()`, `0` for `rowSums()`), `"na"` returns `NA`. If
  `NULL`, uses `getOption("tidyna.all_na", "error")`.

- dims:

  Integer. Number of dimensions to treat as rows.

- ...:

  Additional arguments passed to the base function.

## Value

A numeric or complex array of suitable size, or a vector if the result
is one-dimensional.

## Examples

``` r
mat <- matrix(c(1, NA, 3, NA, NA, NA), nrow = 2, byrow = TRUE)
rowSums(mat)
#> Warning: ⚠️ 4 missing values removed.
#> Warning: ⚠️ 1 row had all NA values.
#> [1]  4 NA

# Compare to base R:
base::rowSums(mat, na.rm = TRUE)
#> [1] 4 0
```
