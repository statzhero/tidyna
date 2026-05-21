# tidyna: NA-Aware Defaults for Common R Functions

Provides drop-in replacements for common R functions (mean(), sum(),
sd(), min(), etc.) that default to 'na.rm = TRUE' and issue warnings
when missing values are removed. It handles some special cases. The
table() default is set to 'useNA = ifany'.

## Masked functions

When you attach tidyna with
[`library(tidyna)`](https://statzhero.github.io/tidyna/), it masks these
base/stats functions:

- `mean`, `sum`, `prod` (base)

- `min`, `max`, `range`, `pmax`, `pmin` (base)

- `any`, `all` (base)

- `sd`, `var`, `median`, `quantile` (stats)

- `rowMeans`, `rowSums` (base)

- `cor` (stats)

- `table` (base)

## Options

- `tidyna.warn`: Set to `FALSE` to suppress warnings. Default `TRUE`.

- `tidyna.all_na`: Controls behavior when all values are NA. One of
  `"error"` (default, throws an error), `"base"` (returns base R
  behavior), or `"na"` (returns NA).

## Related packages

- [naflex](https://cran.r-project.org/package=naflex): Conditional NA
  removal based on thresholds (e.g., remove only if \<5)

- [na.tools](https://cran.r-project.org/package=na.tools): Utilities for
  working with missing values

## See also

Useful links:

- <https://github.com/statzhero/tidyna>

- Report bugs at <https://github.com/statzhero/tidyna/issues>

## Author

**Maintainer**: Ulrich Atz <ulrich.atz@unibocconi.it>
([ORCID](https://orcid.org/0000-0002-1719-3780)) \[copyright holder\]

Authors:

- Ulrich Atz <ulrich.atz@unibocconi.it>
  ([ORCID](https://orcid.org/0000-0002-1719-3780)) \[copyright holder\]
