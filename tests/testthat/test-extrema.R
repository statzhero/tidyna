# Simple test vectors
x_na <- c(1, NA, 3)
x_clean <- c(1, 2, 3)
x_nan <- c(1, NaN, 5)
x_inf <- c(1, Inf, 3)
x_neginf <- c(-Inf, 2, 3)
x_both_inf <- c(-Inf, 0, Inf)

# min ----
test_that("min removes NA and warns", {
  expect_warning(result <- min(x_na), "Missing values")
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

test_that("min handles NaN (treated as NA)", {
  expect_warning(result <- min(x_nan), "Missing values")
  expect_equal(result, 1)
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
  expect_warning(result <- max(x_na), "Missing values")
  expect_equal(result, 3)
})

test_that("max with no NAs produces no warning", {
  expect_no_warning(result <- max(x_clean))
  expect_equal(result, 3)
})

test_that("max handles NaN (treated as NA)", {
  expect_warning(result <- max(x_nan), "Missing values")
  expect_equal(result, 5)
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

# Edge cases ----
test_that("min of all-NA returns Inf with warning", {
  expect_warning(result <- min(c(NA, NA)), "Missing values")
  expect_equal(result, Inf)
})

test_that("max of all-NA returns -Inf with warning", {
  expect_warning(result <- max(c(NA, NA)), "Missing values")
  expect_equal(result, -Inf)
})

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
  expect_warning(result <- min(c(5, NA), c(1, 2)), "Missing values")
  expect_equal(result, 1)
})

test_that("max with multiple vectors containing NA", {
  expect_warning(result <- max(c(1, NA), c(5, 2)), "Missing values")
  expect_equal(result, 5)
})
