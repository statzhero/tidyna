# Simple test vectors
x_na <- c(1, NA, 3)
x_clean <- c(1, 2, 3)
x_nan <- c(1, NaN, 5)
x_na_and_nan <- c(1, NA, NaN, 5)
x_inf <- c(1, Inf, 3)
x_neginf <- c(-Inf, 2, 3)
x_both_inf <- c(-Inf, 0, Inf)

# min ----
test_that("min removes NA and warns", {
  expect_warning(result <- min(x_na), "missing value")
  expect_equal(result, 1)
})

test_that("min with no NAs produces no warning", {
  expect_no_warning(result <- min(x_clean))
  expect_equal(result, 1)
})

test_that("min with na.rm = FALSE returns NA", {
  expect_no_warning(result <- min(x_na, na.rm = FALSE))
  expect_true(is.na(result))
})

test_that("min handles NaN with separate warning", {
  expect_warning(result <- min(x_nan), "NaN value")
  expect_equal(result, 1)
})

test_that("min with both NA and NaN issues both warnings", {
  warnings <- testthat::capture_warnings(result <- min(x_na_and_nan))
  expect_equal(result, 1)
  expect_length(warnings, 2)
  expect_true(any(grepl("missing value", warnings)))
  expect_true(any(grepl("NaN value", warnings)))
})

test_that("min handles Inf", {
  expect_no_warning(result <- min(x_inf))
  expect_equal(result, 1)
})

test_that("min handles -Inf", {
  expect_no_warning(result <- min(x_neginf))
  expect_equal(result, -Inf)
})

test_that("min of mixed Inf returns -Inf", {
  expect_no_warning(result <- min(x_both_inf))
  expect_equal(result, -Inf)
})

# max ----
test_that("max removes NA and warns", {
  expect_warning(result <- max(x_na), "missing value")
  expect_equal(result, 3)
})

test_that("max with no NAs produces no warning", {
  expect_no_warning(result <- max(x_clean))
  expect_equal(result, 3)
})

test_that("max handles NaN with separate warning", {
  expect_warning(result <- max(x_nan), "NaN value")
  expect_equal(result, 5)
})

test_that("max with both NA and NaN issues both warnings", {
  warnings <- testthat::capture_warnings(result <- max(x_na_and_nan))
  expect_equal(result, 5)
  expect_length(warnings, 2)
  expect_true(any(grepl("missing value", warnings)))
  expect_true(any(grepl("NaN value", warnings)))
})

test_that("max handles Inf", {
  expect_no_warning(result <- max(x_inf))
  expect_equal(result, Inf)
})

test_that("max handles -Inf", {
  expect_no_warning(result <- max(x_neginf))
  expect_equal(result, 3)
})

test_that("max of mixed Inf returns Inf", {
  expect_no_warning(result <- max(x_both_inf))
  expect_equal(result, Inf)
})

# Edge cases: all-NA throws error ----
test_that("min of all-NA throws error", {
  expect_error(min(c(NA, NA)), "check if something went wrong")
})

test_that("max of all-NA throws error", {
  expect_error(max(c(NA, NA)), "check if something went wrong")
})

test_that("min of all-NaN throws error", {
  expect_error(min(c(NaN, NaN)), "check if something went wrong")
})

test_that("max of all-NaN throws error", {
  expect_error(max(c(NaN, NaN)), "check if something went wrong")
})

# Edge cases: empty vector preserves base R behavior ----
test_that("min of empty vector returns Inf with base R warning", {
  # Base R emits warning about no non-missing arguments
  expect_warning(result <- min(numeric(0)), "no non-missing arguments")
  expect_equal(result, Inf)
})

test_that("max of empty vector returns -Inf with base R warning", {
  # Base R emits warning about no non-missing arguments
  expect_warning(result <- max(numeric(0)), "no non-missing arguments")
  expect_equal(result, -Inf)
})

# Multiple arguments ----
test_that("min with multiple vectors containing NA", {
  expect_warning(result <- min(c(5, NA), c(1, 2)), "missing value")
  expect_equal(result, 1)
})

test_that("max with multiple vectors containing NA", {
  expect_warning(result <- max(c(1, NA), c(5, 2)), "missing value")
  expect_equal(result, 5)
})
