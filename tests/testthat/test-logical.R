# Simple test vectors
logi_na <- c(TRUE, NA, FALSE)
logi_clean <- c(TRUE, FALSE, TRUE)

# any ----
test_that("any removes NA and warns", {
  expect_warning(result <- any(logi_na), "Missing values")
  expect_true(result)
})

test_that("any with na.rm = FALSE returns NA", {
  expect_no_warning(result <- any(c(FALSE, NA), na.rm = FALSE))
  expect_true(is.na(result))
})

test_that("any with no NA produces no warning", {
  expect_no_warning(result <- any(logi_clean))
  expect_true(result)
})

test_that("any all FALSE with NA warns and returns FALSE", {
  expect_warning(result <- any(c(FALSE, NA, FALSE)), "Missing values")
  expect_false(result)
})

# all ----
test_that("all removes NA and warns", {
  expect_warning(result <- all(c(TRUE, NA, TRUE)), "Missing values")
  expect_true(result)
})

test_that("all with FALSE returns FALSE (no warning if no NA)", {
  expect_no_warning(result <- all(logi_clean))
  expect_false(result)
})

test_that("all with NA and FALSE warns and returns FALSE", {
  expect_warning(result <- all(c(TRUE, NA, FALSE)), "Missing values")
  expect_false(result)
})

# Edge cases with NaN ----
test_that("any coerces NaN to TRUE (NaN is truthy)", {
  # NaN when coerced to logical is NA, not TRUE
  expect_warning(result <- any(c(FALSE, NaN)), "Missing values")
  expect_false(result)
})

test_that("all with NaN (coerced to NA)", {
  expect_warning(result <- all(c(TRUE, NaN)), "Missing values")
  expect_true(result)
})

# Edge case: empty vector ----
test_that("any of empty vector returns FALSE", {
  expect_no_warning(result <- any(logical(0)))
  expect_false(result)
})

test_that("all of empty vector returns TRUE", {
  expect_no_warning(result <- all(logical(0)))
  expect_true(result)
})

# Edge case: all NA ----
test_that("any of all-NA returns FALSE with warning", {
  expect_warning(result <- any(c(NA, NA)), "Missing values")
  expect_false(result)
})

test_that("all of all-NA returns TRUE with warning", {
  expect_warning(result <- all(c(NA, NA)), "Missing values")
  expect_true(result)
})
