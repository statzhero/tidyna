# Simple test matrices
mat_na <- matrix(c(1, NA, 3, 4, 5, 6), nrow = 2, byrow = TRUE)
mat_clean <- matrix(1:6, nrow = 2, byrow = TRUE)
mat_all_na <- matrix(c(1, NA, 3, NA, NA, NA), nrow = 2, byrow = TRUE)
mat_nan <- matrix(c(1, NaN, 3, 4, 5, 6), nrow = 2, byrow = TRUE)
mat_inf <- matrix(c(1, Inf, 3, 4, 5, 6), nrow = 2, byrow = TRUE)

# rowSums ----
test_that("rowSums returns NA for all-NA rows", {
  expect_warning(result <- rowSums(mat_all_na), "all NA")
  expect_equal(result, c(4, NA))
})

test_that("rowSums warns about removed NAs", {
  expect_warning(result <- rowSums(mat_na), "Missing values")
  expect_equal(result, c(4, 15))
})

test_that("rowSums with no NAs produces no warning", {
  expect_no_warning(result <- rowSums(mat_clean))
  expect_equal(result, c(6, 15))
})

test_that("rowSums handles NaN (treated as NA)", {
  expect_warning(result <- rowSums(mat_nan), "Missing values")
  expect_equal(result, c(4, 15))
})

test_that("rowSums handles Inf", {
  expect_no_warning(result <- rowSums(mat_inf))
  expect_equal(result, c(Inf, 15))
})

test_that("rowSums with na.rm = FALSE returns NA for rows with NA", {
  withr::with_options(list(tidyna.warn = FALSE), {
    result <- rowSums(mat_na, na.rm = FALSE)
  })
  expect_true(is.na(result[1]))
  expect_equal(result[2], 15)
})

# rowMeans ----
test_that("rowMeans warns about removed NAs", {
  expect_warning(result <- rowMeans(mat_na), "Missing values")
  expect_equal(result, c(2, 5))
})

test_that("rowMeans with no NAs produces no warning", {
  expect_no_warning(result <- rowMeans(mat_clean))
  expect_equal(result, c(2, 5))
})

test_that("rowMeans handles NaN (treated as NA)", {
  expect_warning(result <- rowMeans(mat_nan), "Missing values")
  expect_equal(result, c(2, 5))
})

test_that("rowMeans handles Inf", {
  expect_no_warning(result <- rowMeans(mat_inf))
  expect_equal(result, c(Inf, 5))
})

# Edge cases ----
test_that("rowSums matrix with all-NA row returns NA for that row", {
  mat <- matrix(c(NA, NA, NA, 1, 2, 3), nrow = 2, byrow = TRUE)
  expect_warning(result <- rowSums(mat), "all NA")
  expect_equal(result, c(NA, 6))
})

test_that("rowMeans of all-NA row returns NaN", {
  mat <- matrix(c(NA, NA, NA, 1, 2, 3), nrow = 2, byrow = TRUE)
  expect_warning(result <- rowMeans(mat), "Missing values")
  expect_true(is.nan(result[1]))
  expect_equal(result[2], 2)
})

test_that("rowSums with mixed Inf and -Inf", {
  mat <- matrix(c(Inf, -Inf, 0, 1, 2, 3), nrow = 2, byrow = TRUE)
  expect_no_warning(result <- rowSums(mat))
  expect_true(is.nan(result[1]))  # Inf + -Inf = NaN
  expect_equal(result[2], 6)
})

test_that("rowSums preserves row names", {
  mat <- matrix(1:4, nrow = 2, dimnames = list(c("a", "b"), NULL))
  expect_no_warning(result <- rowSums(mat))
  expect_equal(names(result), c("a", "b"))
})

# Data frame input ----
test_that("rowSums works with data frame", {
  df <- data.frame(x = c(1, NA), y = c(2, 3))
  expect_warning(result <- rowSums(df), "Missing values")
  expect_equal(result, c(3, 3))
})

test_that("rowMeans works with data frame", {
  df <- data.frame(x = c(1, NA), y = c(2, 3))
  expect_warning(result <- rowMeans(df), "Missing values")
  expect_equal(result, c(1.5, 3))
})
