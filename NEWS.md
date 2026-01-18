# tidyna 0.3.0

* `pmax()` and `pmin()` now default to `na.rm = TRUE` and warn when NAs are removed. Positions where all inputs are NA return NA with a warning. All-NAs in every position yields an error.

# tidyna 0.2.0

* `range()` now defaults to `na.rm = TRUE` and warns when NAs are removed. Supports `finite` argument to also remove infinite values with a warning.

# tidyna 0.1.3

* Small QoL changes.

# tidyna 0.1.0

* Initial release with NA-aware versions of common R functions: `mean()`, `sum()`, `prod()`, `min()`, `max()`, `any()`, `all()`, `sd()`, `var()`, `median()`, `quantile()`, `rowMeans()`, `rowSums()`, `cor()`, and `table()`.
