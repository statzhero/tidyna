# Simple test vectors
x_na <- c(1, NA, 3)
x_clean <- c(1, 2, 3)
x_nan <- c(1, NaN, 3)
x_inf <- c(1, Inf, 3)
x_neginf <- c(1, -Inf, 3)
x_mixed <- c(1, NA, NaN, Inf, 5)

# mean ----
test_that("mean removes NA and warns by default", {
  expect_warning(
    result <- mean(x_na),
    "missing value"

)
  expect_equal(result, 2)
})

test_that("mean with na.rm = FALSE returns NA without warning", {
  expect_no_warning(result <- mean(x_na, na.rm = FALSE))
  expect_true(is.na(result))
})

test_that("mean with no NAs produces no warning", {
  expect_no_warning(result <- mean(x_clean))
  expect_equal(result, 2)
})

test_that("tidyna.warn option suppresses warnings", {
  withr::with_options(list(tidyna.warn = FALSE), {
    expect_no_warning(mean(x_na))
  })
})

test_that("mean handles NaN (treated as NA)", {
  expect_warning(result <- mean(x_nan), "missing value")
  expect_equal(result, 2)
})

test_that("mean handles Inf", {
  expect_no_warning(result <- mean(x_inf))
  expect_equal(result, Inf)
})

test_that("mean handles -Inf", {
  expect_no_warning(result <- mean(x_neginf))
  expect_equal(result, -Inf)
})

test_that("mean handles mixed NA, NaN, Inf", {
  expect_warning(result <- mean(x_mixed), "missing value")
  expect_equal(result, Inf)
})

# sum ----
test_that("sum removes NA and warns", {
  expect_warning(result <- sum(x_na), "missing value")
  expect_equal(result, 4)
})

test_that("sum handles NaN", {
  expect_warning(result <- sum(x_nan), "missing value")
  expect_equal(result, 4)
})

test_that("sum handles Inf", {
  expect_no_warning(result <- sum(x_inf))
  expect_equal(result, Inf)
})

# prod ----
test_that("prod removes NA and warns", {
  expect_warning(result <- prod(c(2, NA, 3)), "missing value")
  expect_equal(result, 6)
})

test_that("prod handles Inf", {
  expect_no_warning(result <- prod(c(2, Inf, 3)))
  expect_equal(result, Inf)
})

test_that("prod handles zero with Inf", {
  expect_no_warning(result <- prod(c(0, Inf)))
  expect_true(is.nan(result))
})

# sd ----
test_that("sd removes NA and warns", {
  expect_warning(result <- sd(x_na), "missing value")
  expect_equal(result, sd(c(1, 3)))
})

test_that("sd handles NaN", {
  expect_warning(result <- sd(x_nan), "missing value")
  expect_equal(result, sd(c(1, 3)))
})

test_that("sd with Inf returns NaN", {
  expect_no_warning(result <- sd(x_inf))
  expect_true(is.nan(result))
})

# var ----
test_that("var removes NA and warns", {
  expect_warning(result <- var(x_na), "missing value")
  expect_equal(result, var(c(1, 3)))
})

test_that("var handles NaN", {
  expect_warning(result <- var(x_nan), "missing value")
  expect_equal(result, var(c(1, 3)))
})

# median ----
test_that("median removes NA and warns", {
  expect_warning(result <- median(x_na), "missing value")
  expect_equal(result, 2)
})

test_that("median handles Inf", {
  expect_no_warning(result <- median(c(1, 2, Inf)))
  expect_equal(result, 2)
})

test_that("median handles -Inf", {
  expect_no_warning(result <- median(c(-Inf, 2, 3)))
  expect_equal(result, 2)
})

# quantile ----
test_that("quantile removes NA and warns", {
  expect_warning(
    result <- quantile(c(1, NA, 2, 3, 4), probs = 0.5),
    "missing value"
  )
  expect_equal(unname(result), 2.5)
})

test_that("quantile handles Inf at boundaries", {
  expect_no_warning(result <- quantile(c(1, 2, 3, Inf), probs = 1))
  expect_equal(unname(result), Inf)
})

# Edge case: all-NA throws error ----
test_that("mean of all-NA throws error", {
  expect_error(mean(c(NA, NA)), "something likely went wrong")
})

test_that("sum of all-NA throws error", {
  expect_error(sum(c(NA, NA)), "something likely went wrong")
})

test_that("prod of all-NA throws error", {
  expect_error(prod(c(NA, NA)), "something likely went wrong")
})

test_that("sd of all-NA throws error", {
  expect_error(sd(c(NA, NA)), "something likely went wrong")
})

test_that("var of all-NA throws error", {
  expect_error(var(c(NA, NA)), "something likely went wrong")
})

test_that("median of all-NA throws error", {
  expect_error(median(c(NA, NA)), "something likely went wrong")
})

test_that("quantile of all-NA throws error", {
  expect_error(quantile(c(NA, NA)), "something likely went wrong")
})
