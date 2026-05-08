# Simple test vectors
x_na <- c("a", "b", NA, "a")
x_clean <- c("a", "b", "a", "a")
x_multi_na <- c("a", NA, NA, "b")

# table shows NA by default ----
test_that("table shows NA by default", {
  result <- table(x_na)

  # Should have 3 unique values: "a", "b", NA
  expect_equal(length(result), 3)
  expect_equal(sum(result), 4)
})

test_that("table with useNA = 'no' hides NA", {
  result <- table(x_na, useNA = "no")

  expect_equal(sum(result), 3)
  expect_equal(length(result), 2)
})

test_that("table with useNA = 'always' shows NA even when none present", {
  result <- table(x_clean, useNA = "always")

  # Should include NA level even though count is 0
  expect_equal(length(result), 3)
})

test_that("table with no NAs", {
  result <- table(x_clean)

  expect_equal(sum(result), 4)
  expect_equal(as.numeric(result["a"]), 3)
})

# Multiple NA values ----
test_that("table counts multiple NAs correctly", {
  result <- table(x_multi_na)

  expect_equal(as.numeric(result[is.na(names(result))]), 2)
})

# Cross-tabulation ----
test_that("table cross-tabulation with NAs", {
  x <- c("a", "a", NA)
  y <- c("x", NA, "y")
  result <- table(x, y)

  # With useNA = "ifany", should include NA levels

  expect_true("NA" %in% rownames(result) || any(is.na(rownames(result))))
})

# Edge cases ----
test_that("table with all NA", {
  result <- table(c(NA, NA, NA))

  expect_equal(length(result), 1)
  expect_equal(sum(result), 3)
})

test_that("table with empty vector",
{
  result <- table(character(0))

  expect_equal(length(result), 0)
})

test_that("table with NaN (coerced to character 'NaN')", {
  result <- table(c(1, NaN, 2, NaN))

  # NaN becomes a character level "NaN", not treated as NA
  expect_true("NaN" %in% names(result))
})

test_that("table with Inf", {
  result <- table(c(1, Inf, 2, Inf, -Inf))

  expect_true("Inf" %in% names(result))
  expect_true("-Inf" %in% names(result))
  expect_equal(as.numeric(result["Inf"]), 2)
})

# Factor input ----
test_that("table with factor containing NA", {
  f <- factor(c("a", "b", NA, "a"))
  result <- table(f)

  # By default, useNA = "ifany" shows NA
  expect_equal(sum(result), 4)
})

test_that("table preserves factor levels", {
  f <- factor(c("a", "c"), levels = c("a", "b", "c"))
  result <- table(f)

  # Should show all levels including unused "b"
  expect_equal(length(result), 3)
  expect_equal(as.numeric(result["b"]), 0)
})

# dnn argument ----
test_that("table respects dnn argument", {
  result <- table(x_na, dnn = "Table")

  expect_equal(names(dimnames(result)), "Table")
})

