
# tidyna

Tired of littering your code with `na.rm = TRUE`? **tidyna** masks common R functions and warns you when NAs are removed. It handles some special cases. The `table()` default is set to `useNA = "ifany"`.

## Installation

Install from CRAN:

```r
install.packages("tidyna")
```
Or install the development version from GitHub:

```r
# install.packages("pak")
pak::pak("statzhero/tidyna")
```

## Usage

``` r
library(tidyna)

x <- c(1, 2, NA)
mean(x)
#> ⚠️ 1 missing value removed.
#> [1] 1.5
```

Suppress warnings with `options(tidyna.warn = FALSE)`.

## Functions

- **Summary**: `mean`, `sum`, `prod`, `sd`, `var`, `median`, `quantile`
- **Extrema**: `min`, `max`, `range`, `pmax`, `pmin`
- **Logical**: `any`, `all`
- **Row-wise**: `rowSums`, `rowMeans`
- **Correlation**: `cor`
- **Table**: `table`

## Special cases

**All-NA input throws error**: When all values are NA, tidyna throws an error instead of returning misleading values like `Inf`, `NaN`, or `0`:

``` r
sum(c(NA, NA))
#> Error: All values are NA; check if something went wrong.

base::sum(c(NA, NA), na.rm = TRUE)
#> [1] 0
```

**`rowSums`** returns `NA` for all-NA rows, but errors if the entire matrix is NA.

**`pmax`/`pmin`** return `NA` for positions where all inputs are NA (with a warning), but error if every position is all-NA:

``` r
pmax(c(NA, 1), c(NA, 2))
#> ⚠️ 1 position had all NA values.
#> [1] NA  2

pmax(c(NA, NA), c(NA, NA))
#> Error: All values are NA; check if something went wrong.
```

**`cor`** defaults to `use = "pairwise.complete.obs"` instead of erroring on NAs.

**`table`** defaults to `useNA = "ifany"`, showing NA counts when present rather than silently dropping them.

## Roadmap

- Add explicit `_aware` suffixed versions (`mean_aware`, `sum_aware`, etc.) for users who prefer not to mask base functions.

## Related packages

- [naflex](https://cran.r-project.org/package=naflex): Conditional NA removal based on thresholds
- [na.tools](https://cran.r-project.org/package=na.tools): Utilities for working with missing values
