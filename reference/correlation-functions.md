# NA-aware Correlation Function

Drop-in replacement for `cor()` that defaults to
`use = "pairwise.complete.obs"`.

## Usage

``` r
cor(
  x,
  y = NULL,
  use = "pairwise.complete.obs",
  method = c("pearson", "kendall", "spearman"),
  ...
)
```

## Arguments

- x:

  A numeric vector, matrix, or data frame.

- y:

  Optional. A numeric vector, matrix, or data frame.

- use:

  Method for handling missing values. Default `"pairwise.complete.obs"`.

- method:

  Correlation method: "pearson", "kendall", or "spearman".

- ...:

  Additional arguments passed to
  [`stats::cor()`](https://rdrr.io/r/stats/cor.html).

## Value

A correlation matrix or single correlation coefficient.

## Examples

``` r
x <- c(1, 2, NA, 4)
y <- c(2, 4, 6, 8)
cor(x, y)
#> Warning: ⚠️ Missing values handled via 'pairwise.complete.obs'.
#> [1] 1
```
