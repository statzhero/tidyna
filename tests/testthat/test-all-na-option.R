# Tests for all_na argument and tidyna.all_na option

test_that("resolve_all_na returns correct values", {
  # Default from option
  withr::with_options(list(tidyna.all_na = "error"), {
    expect_equal(tidyna:::resolve_all_na(NULL), "error")
  })
  withr::with_options(list(tidyna.all_na = "base"), {
    expect_equal(tidyna:::resolve_all_na(NULL), "base")
  })
  withr::with_options(list(tidyna.all_na = "na"), {
    expect_equal(tidyna:::resolve_all_na(NULL), "na")
  })

  # Explicit argument overrides option
  withr::with_options(list(tidyna.all_na = "na"), {
    expect_equal(tidyna:::resolve_all_na("error"), "error")
    expect_equal(tidyna:::resolve_all_na("base"), "base")
  })

  # Invalid argument throws error
  expect_error(tidyna:::resolve_all_na("invalid"), "arg")
})

# Summary functions (mean, sum, prod, sd, var, median, quantile)

test_that("all_na = 'error' throws error for summary functions", {
  all_na <- c(NA_real_, NA_real_)

  expect_error(mean(all_na, all_na = "error"), "All values are NA")
  expect_error(sum(all_na, all_na = "error"), "All values are NA")
  expect_error(prod(all_na, all_na = "error"), "All values are NA")
  expect_error(sd(all_na, all_na = "error"), "All values are NA")
  expect_error(var(all_na, all_na = "error"), "All values are NA")
  expect_error(median(all_na, all_na = "error"), "All values are NA")
  expect_error(quantile(all_na, all_na = "error"), "All values are NA")
})

test_that("all_na = 'base' returns base R values for summary functions", {
  all_na <- c(NA_real_, NA_real_)

  expect_true(is.nan(mean(all_na, all_na = "base")))
  expect_equal(sum(all_na, all_na = "base"), 0)
  expect_equal(prod(all_na, all_na = "base"), 1)
  expect_true(is.na(sd(all_na, all_na = "base")))
  expect_true(is.na(var(all_na, all_na = "base")))
  expect_true(is.na(median(all_na, all_na = "base")))
  expect_true(base::all(is.na(quantile(all_na, all_na = "base"))))
})

test_that("all_na = 'na' returns NA for summary functions", {
  all_na <- c(NA_real_, NA_real_)

  expect_true(is.na(mean(all_na, all_na = "na")))
  expect_true(is.na(sum(all_na, all_na = "na")))
  expect_true(is.na(prod(all_na, all_na = "na")))
  expect_true(is.na(sd(all_na, all_na = "na")))
  expect_true(is.na(var(all_na, all_na = "na")))
  expect_true(is.na(median(all_na, all_na = "na")))
  expect_true(is.na(quantile(all_na, all_na = "na")))
})

# Logical functions (any, all)

test_that("all_na = 'error' throws error for logical functions", {
  all_na <- c(NA, NA)

  expect_error(any(all_na, all_na = "error"), "All values are NA")
  expect_error(all(all_na, all_na = "error"), "All values are NA")
})

test_that("all_na = 'base' returns base R values for logical functions", {
  all_na <- c(NA, NA)

  expect_false(any(all_na, all_na = "base"))
  expect_true(all(all_na, all_na = "base"))
})

test_that("all_na = 'na' returns NA for logical functions", {
  all_na <- c(NA, NA)

  expect_true(is.na(any(all_na, all_na = "na")))
  expect_true(is.na(all(all_na, all_na = "na")))
})

# Extrema functions (min, max, range)

test_that("all_na = 'error' throws error for extrema functions", {
  all_na <- c(NA_real_, NA_real_)

  expect_error(min(all_na, all_na = "error"), "All values are NA")
  expect_error(max(all_na, all_na = "error"), "All values are NA")
  expect_error(range(all_na, all_na = "error"), "All values are NA")
})

test_that("all_na = 'base' returns base R values for extrema functions", {
  all_na <- c(NA_real_, NA_real_)

  expect_warning(result <- min(all_na, all_na = "base"))
  expect_equal(result, Inf)

  expect_warning(result <- max(all_na, all_na = "base"))
  expect_equal(result, -Inf)

  expect_warning(result <- range(all_na, all_na = "base"))
  expect_equal(result, c(Inf, -Inf))
})

test_that("all_na = 'na' returns NA for extrema functions", {
  all_na <- c(NA_real_, NA_real_)

  expect_true(is.na(min(all_na, all_na = "na")))
  expect_true(is.na(max(all_na, all_na = "na")))
  expect_equal(range(all_na, all_na = "na"), c(NA_real_, NA_real_))
})

# Parallel extrema (pmax, pmin)

test_that("all_na = 'error' throws error for pmax/pmin", {
  all_na1 <- c(NA_real_, NA_real_)

all_na2 <- c(NA_real_, NA_real_)

  expect_error(pmax(all_na1, all_na2, all_na = "error"), "All values are NA")
  expect_error(pmin(all_na1, all_na2, all_na = "error"), "All values are NA")
})

test_that("all_na = 'base' returns base R values for pmax/pmin", {
  all_na1 <- c(NA_real_, NA_real_)
  all_na2 <- c(NA_real_, NA_real_)

  expect_equal(pmax(all_na1, all_na2, all_na = "base"), c(NA_real_, NA_real_))
  expect_equal(pmin(all_na1, all_na2, all_na = "base"), c(NA_real_, NA_real_))
})

test_that("all_na = 'na' returns NA for pmax/pmin", {
  all_na1 <- c(NA_real_, NA_real_)
  all_na2 <- c(NA_real_, NA_real_)

  expect_equal(pmax(all_na1, all_na2, all_na = "na"), c(NA_real_, NA_real_))
  expect_equal(pmin(all_na1, all_na2, all_na = "na"), c(NA_real_, NA_real_))
})

# Row functions (rowMeans, rowSums)

test_that("all_na = 'error' throws error for row functions", {
  all_na_mat <- matrix(NA_real_, nrow = 2, ncol = 3)

  expect_error(rowMeans(all_na_mat, all_na = "error"), "All values are NA")
  expect_error(rowSums(all_na_mat, all_na = "error"), "All values are NA")
})

test_that("all_na = 'base' returns base R values for row functions", {
  all_na_mat <- matrix(NA_real_, nrow = 2, ncol = 3)

  expect_true(base::all(is.nan(rowMeans(all_na_mat, all_na = "base"))))
  expect_equal(rowSums(all_na_mat, all_na = "base"), c(0, 0))
})

test_that("all_na = 'na' returns NA for row functions", {
  all_na_mat <- matrix(NA_real_, nrow = 2, ncol = 3)

  expect_equal(rowMeans(all_na_mat, all_na = "na"), c(NA_real_, NA_real_))
  expect_equal(rowSums(all_na_mat, all_na = "na"), c(NA_real_, NA_real_))
})

# Global option tests

test_that("tidyna.all_na option is respected", {
  all_na <- c(NA_real_, NA_real_)

  withr::with_options(list(tidyna.all_na = "na", tidyna.warn = FALSE), {
    expect_true(is.na(mean(all_na)))
    expect_true(is.na(sum(all_na)))
    expect_true(is.na(min(all_na)))
    expect_true(is.na(max(all_na)))
  })

  withr::with_options(list(tidyna.all_na = "base", tidyna.warn = FALSE), {
    expect_true(is.nan(mean(all_na)))
    expect_equal(sum(all_na), 0)
  })
})

test_that("all_na argument overrides global option", {
  all_na <- c(NA_real_, NA_real_)

  withr::with_options(list(tidyna.all_na = "na", tidyna.warn = FALSE), {
    expect_error(mean(all_na, all_na = "error"), "All values are NA")
  })

  withr::with_options(list(tidyna.all_na = "error", tidyna.warn = FALSE), {
    expect_true(is.na(mean(all_na, all_na = "na")))
  })
})
