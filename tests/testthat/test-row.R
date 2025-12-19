# Test matrices
mat_clean <- matrix(1:6, nrow = 2, byrow = TRUE)
mat_with_na <- matrix(c(1, NA, 3, 4, 5, 6), nrow = 2, byrow = TRUE)
mat_row_all_na <- matrix(c(NA, NA, NA, 1, 2, 3), nrow = 2, byrow = TRUE)
mat_entirely_na <- matrix(NA, nrow = 2, ncol = 3)
mat_nan <- matrix(c(1, NaN, 3, 4, 5, 6), nrow = 2, byrow = TRUE)
mat_inf <- matrix(c(1, Inf, 3, 4, 5, 6), nrow = 2, byrow = TRUE)
mat_inf_cancel <- matrix(c(Inf, -Inf, 0, 1, 2, 3), nrow = 2, byrow = TRUE)
mat_named <- matrix(1:4, nrow = 2, dimnames = list(c("a", "b"), NULL))
df_with_na <- data.frame(x = c(1, NA), y = c(2, 3))

# rowSums ----
test_that("rowSums warns about removed NAs", {
  expect_warning(result <- rowSums(mat_with_na), "missing value")
  expect_equal(result, c(4, 15))
})

test_that("rowSums with no NAs produces no warning", {
  expect_no_warning(result <- rowSums(mat_clean))
  expect_equal(result, c(6, 15))
})

test_that("rowSums returns NA for all-NA row and emits both warnings", {
  expect_warning(
    expect_warning(result <- rowSums(mat_row_all_na), "missing value"),
    "had all NA"
  )
  expect_equal(result, c(NA, 6))
})

test_that("rowSums of entirely NA matrix throws error", {
  expect_error(rowSums(mat_entirely_na), "something likely went wrong")
})

test_that("rowSums handles NaN (treated as NA)", {
  expect_warning(result <- rowSums(mat_nan), "missing value")
  expect_equal(result, c(4, 15))
})

test_that("rowSums handles Inf", {
  expect_no_warning(result <- rowSums(mat_inf))
  expect_equal(result, c(Inf, 15))
})

test_that("rowSums with Inf + -Inf produces NaN", {
  expect_no_warning(result <- rowSums(mat_inf_cancel))
  expect_true(is.nan(result[1]))
  expect_equal(result[2], 6)
})

test_that("rowSums with na.rm = FALSE returns NA for rows with NA", {
  withr::with_options(list(tidyna.warn = FALSE), {
    result <- rowSums(mat_with_na, na.rm = FALSE)
  })
  expect_true(is.na(result[1]))
  expect_equal(result[2], 15)
})

test_that("rowSums preserves row names", {
  expect_no_warning(result <- rowSums(mat_named))
  expect_equal(names(result), c("a", "b"))
})

test_that("rowSums works with data frame", {
  expect_warning(result <- rowSums(df_with_na), "missing value")
  expect_equal(result, c(3, 3))
})

# rowMeans ----
test_that("rowMeans warns about removed NAs", {
  expect_warning(result <- rowMeans(mat_with_na), "missing value")
  expect_equal(result, c(2, 5))
})

test_that("rowMeans with no NAs produces no warning", {
  expect_no_warning(result <- rowMeans(mat_clean))
  expect_equal(result, c(2, 5))
})

test_that("rowMeans of all-NA row returns NaN", {
  expect_warning(result <- rowMeans(mat_row_all_na), "missing value")
  expect_true(is.nan(result[1]))
  expect_equal(result[2], 2)
})

test_that("rowMeans of entirely NA matrix throws error", {
  expect_error(rowMeans(mat_entirely_na), "something likely went wrong")
})

test_that("rowMeans handles NaN (treated as NA)", {
  expect_warning(result <- rowMeans(mat_nan), "missing value")
  expect_equal(result, c(2, 5))
})

test_that("rowMeans handles Inf", {
  expect_no_warning(result <- rowMeans(mat_inf))
  expect_equal(result, c(Inf, 5))
})

test_that("rowMeans works with data frame", {
  expect_warning(result <- rowMeans(df_with_na), "missing value")
  expect_equal(result, c(1.5, 3))
})
