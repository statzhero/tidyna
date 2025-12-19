# Simple test vectors
logi_na <- c(TRUE, NA, FALSE)
logi_clean <- c(TRUE, FALSE, TRUE)

# any ----
test_that("any removes NA and warns", {
  expect_warning(result <- any(logi_na), "missing value")
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
  expect_warning(result <- any(c(FALSE, NA, FALSE)), "missing value")
  expect_false(result)
})

# all ----
test_that("all removes NA and warns", {
  expect_warning(result <- all(c(TRUE, NA, TRUE)), "missing value")
  expect_true(result)
})

test_that("all with FALSE returns FALSE (no warning if no NA)", {
  expect_no_warning(result <- all(logi_clean))
  expect_false(result)
})

test_that("all with NA and FALSE warns and returns FALSE", {
  expect_warning(result <- all(c(TRUE, NA, FALSE)), "missing value")
  expect_false(result)
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

# Edge case: all NA throws error ----
test_that("any of all-NA throws error", {
  expect_error(any(c(NA, NA)), "something likely went wrong")
})

test_that("all of all-NA throws error", {
  expect_error(all(c(NA, NA)), "something likely went wrong")
})
