# Test that tidyna.warn = FALSE suppresses all warnings

test_that("tidyna.warn = FALSE suppresses warnings for all functions", {
  withr::with_options(list(tidyna.warn = FALSE), {
    x_na <- c(1, NA, 3)
    mat_na <- matrix(c(1, NA, 3, 4, 5, 6), nrow = 2, byrow = TRUE)

    # Summary functions
    expect_no_warning(mean(x_na))
    expect_no_warning(sum(x_na))
    expect_no_warning(prod(x_na))
    expect_no_warning(sd(x_na))
    expect_no_warning(var(x_na))
    expect_no_warning(median(x_na))
    expect_no_warning(quantile(x_na))

    # Extrema functions
    expect_no_warning(min(x_na))
    expect_no_warning(max(x_na))

    # Logical functions
    expect_no_warning(any(c(TRUE, NA, FALSE)))
    expect_no_warning(all(c(TRUE, NA, TRUE)))

    # Row functions
    expect_no_warning(rowSums(mat_na))
    expect_no_warning(rowMeans(mat_na))

    # Correlation
    expect_no_warning(cor(x_na, c(2, 4, 6)))
  })
})
