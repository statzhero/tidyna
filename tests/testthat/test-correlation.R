# Test vectors and matrices
x_na <- c(1, 2, NA, 4)
y_clean <- c(2, 4, 6, 8)
x_clean <- c(1, 2, 3, 4)
x_nan <- c(1, NaN, 3, 4)
x_inf <- c(1, 2, 3, Inf)
mat_with_na <- matrix(c(1, 2, 3, 4, 5, NA), nrow = 3)
mat_clean <- matrix(1:6, nrow = 3)

# cor with vectors ----
test_that("cor warns with pairwise.complete.obs", {
  expect_warning(result <- cor(x_na, y_clean), "pairwise.complete.obs")
  expect_true(!is.na(result))
})

test_that("cor without NAs produces no warning", {
  expect_no_warning(result <- cor(x_clean, y_clean))
  expect_equal(result, 1)
})

test_that("cor with use='everything' returns NA when data has NA", {
  expect_no_warning(result <- cor(x_na, y_clean, use = "everything"))
  expect_true(is.na(result))
})

test_that("cor with NaN (treated as NA)", {
  expect_warning(result <- cor(x_nan, y_clean), "pairwise")
  expect_true(!is.na(result))
})

test_that("cor handles Inf values", {
  expect_no_warning(result <- cor(x_inf, y_clean))
  expect_true(is.na(result))  # cor with Inf returns NA
})

# cor matrix ----
test_that("cor matrix works", {
  expect_warning(result <- cor(mat_with_na), "pairwise")
  expect_true(is.matrix(result))
  expect_equal(dim(result), c(2, 2))
})

test_that("cor matrix with no NA produces no warning", {
  expect_no_warning(result <- cor(mat_clean))
  expect_true(is.matrix(result))
})

# Different methods ----
test_that("cor with method spearman works", {
  expect_warning(result <- cor(x_na, y_clean, method = "spearman"), "pairwise")
  expect_true(!is.na(result))
})

test_that("cor with method kendall works", {
  expect_warning(result <- cor(x_na, y_clean, method = "kendall"), "pairwise")
  expect_true(!is.na(result))
})

# Different use options ----
test_that("cor with use='complete.obs' also warns", {
  expect_warning(result <- cor(x_na, y_clean, use = "complete.obs"), "complete.obs")
  expect_true(!is.na(result))
})

test_that("cor with use='na.or.complete' does not warn", {
  expect_no_warning(result <- cor(x_na, y_clean, use = "na.or.complete"))
})

# Edge cases ----
test_that("cor of constant vector returns NA with base R warning", {
  # Base R emits warning about standard deviation being zero
  expect_warning(result <- cor(c(1, 1, 1), c(1, 2, 3)), "standard deviation is zero")
  expect_true(is.na(result))
})

test_that("cor with single complete pair", {
  x <- c(NA, 2, NA)
  y <- c(1, 2, NA)
  expect_warning(result <- cor(x, y), "pairwise")
  expect_true(is.na(result))  # Need at least 2 obs for cor
})