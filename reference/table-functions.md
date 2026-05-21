# NA-aware Table Function

Drop-in replacement for `table()` that defaults to `useNA = "ifany"`,
showing NA counts when present.

## Usage

``` r
table(..., useNA = "ifany")
```

## Arguments

- ...:

  Objects to cross-tabulate.

- useNA:

  Whether to include NA values. Default `"ifany"`.

## Value

A contingency table of class `table`.

## Examples

``` r
x <- c("a", "b", NA, "a", NA)
table(x)
#> x
#>    a    b <NA> 
#>    2    1    2 
```
