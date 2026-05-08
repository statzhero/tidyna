# Test vectors
x_na <- c(1, NA, 3)
x_clean <- c(1, 2, 3)
x_nan <- c(1, NaN, 3)
x_inf <- c(1, Inf, 3)
x_neginf <- c(-Inf, 2, 3)
x_mixed <- c(1, NA, NaN, Inf, 5)
x_for_prod <- c(2, NA, 3)
x_for_quantile <- c(1, NA, 2, 3, 4)

# NA count in warnings ----
test_that("warning reports correct NA count", {
  expect_warning(mean(c(1, NA, 3)), "1 missing value")
  expect_warning(mean(c(1, NA, NA, 3)), "2 missing values")
  expect_warning(mean(c(NA, NA, NA, 1)), "3 missing values")
})

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
  expect_warning(result <- prod(x_for_prod), "missing value")
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
  expect_warning(result <- quantile(x_for_quantile, probs = 0.5), "missing value")
  expect_equal(unname(result), 2.5)
})

test_that("quantile handles Inf at boundaries", {
  expect_no_warning(result <- quantile(c(1, 2, 3, Inf), probs = 1))
  expect_equal(unname(result), Inf)
})

test_that("quantile works with multiple probs (named argument)", {
  expect_warning(
    result <- quantile(x_for_quantile, probs = c(0.25, 0.5, 0.75)),
    "missing value"
  )
  expect_length(result, 3)
})

test_that("quantile works with multiple probs (positional argument)", {
  expect_warning(
    result <- quantile(x_for_quantile, c(0.25, 0.5, 0.75)),
    "missing value"
  )
  expect_length(result, 3)
})

# Edge case: all-NA throws error ----
test_that("mean of all-NA throws error", {
  expect_error(mean(c(NA, NA)), "check if something went wrong")
})

test_that("sum of all-NA throws error", {
  expect_error(sum(c(NA, NA)), "check if something went wrong")
})

test_that("prod of all-NA throws error", {
  expect_error(prod(c(NA, NA)), "check if something went wrong")
})

test_that("sd of all-NA throws error", {
  expect_error(sd(c(NA, NA)), "check if something went wrong")
})

test_that("var of all-NA throws error", {
  expect_error(var(c(NA, NA)), "check if something went wrong")
})

test_that("median of all-NA throws error", {
  expect_error(median(c(NA, NA)), "check if something went wrong")
})

test_that("quantile of all-NA throws error", {
  expect_error(quantile(c(NA, NA)), "check if something went wrong")
})

# weighted.mean ----
test_that("weighted.mean removes NA in x and warns", {
  x <- c(1, NA, 3)
  w <- c(1, 1, 1)
  expect_warning(result <- weighted.mean(x, w), "1 missing value")
  expect_equal(result, stats::weighted.mean(c(1, 3), c(1, 1)))
})

test_that("weighted.mean removes NA in w and warns", {
  x <- c(1, 2, 3)
  w <- c(1, NA, 1)
  expect_warning(result <- weighted.mean(x, w), "1 missing value")
  expect_equal(result, stats::weighted.mean(c(1, 3), c(1, 1)))
})

test_that("weighted.mean removes paired NAs in both x and w", {
  x <- c(1, NA, 3, 4)
  w <- c(1, 1, NA, 1)
  expect_warning(result <- weighted.mean(x, w), "2 missing values")
  expect_equal(result, stats::weighted.mean(c(1, 4), c(1, 1)))
})

test_that("weighted.mean with no NAs produces no warning", {
  expect_no_warning(result <- weighted.mean(c(1, 2, 3), c(1, 2, 3)))
  expect_equal(result, stats::weighted.mean(c(1, 2, 3), c(1, 2, 3)))
})

test_that("weighted.mean with na.rm = FALSE returns NA without warning", {
  x <- c(1, NA, 3)
  w <- c(1, 1, 1)
  expect_no_warning(result <- weighted.mean(x, w, na.rm = FALSE))
  expect_true(is.na(result))
})

test_that("weighted.mean respects tidyna.warn option", {
  withr::with_options(list(tidyna.warn = FALSE), {
    expect_no_warning(weighted.mean(c(1, NA, 3), c(1, 1, 1)))
  })
})

test_that("weighted.mean of all-NA throws error", {
  expect_error(
    weighted.mean(c(NA, NA), c(1, 1)),
    "check if something went wrong"
  )
})

test_that("weighted.mean of all-NA with all_na = 'na' returns NA", {
  result <- suppressWarnings(
    weighted.mean(c(NA, NA), c(1, 1), all_na = "na")
  )
  expect_true(is.na(result))
})

test_that("weighted.mean works without explicit w argument", {
  expect_warning(result <- weighted.mean(c(1, NA, 3)), "1 missing value")
  expect_equal(result, base::mean(c(1, 3)))
})
