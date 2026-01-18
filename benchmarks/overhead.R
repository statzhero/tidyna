# Benchmark: tidyna overhead vs base R
# Uses bench::mark() per Advanced R recommendations
# https://adv-r.hadley.nz/perf-measure.html

library(bench)
library(ggplot2)
library(cli)

set.seed(97873)
n <- 1e7
na_rate <- 0.001

x_na <- rnorm(n)
x_na[sample(n, n * na_rate)] <- NA

y_na <- rnorm(n)
y_na[sample(n, n * na_rate / 2)] <- NA

mat_na <- matrix(rnorm(n), nrow = 1000)
mat_na[sample(length(mat_na), 100)] <- NA

# All FALSE so base::any() has the worst case
lgl_na <- rep(FALSE, n)
lgl_na[sample(n, n * na_rate)] <- NA

options(tidyna.warn = FALSE)

cli_h1("Benchmarks (10M elements, 0.1% NAs)")

results <- bench::mark(
  # Summary
  `base::mean` = base::mean(x_na, na.rm = TRUE),
  `tidyna::mean` = tidyna::mean(x_na),

  `base::sum` = base::sum(x_na, na.rm = TRUE),
  `tidyna::sum` = tidyna::sum(x_na),

  `base::median` = stats::median(x_na, na.rm = TRUE),
  `tidyna::median` = tidyna::median(x_na),

  `base::sd` = stats::sd(x_na, na.rm = TRUE),
  `tidyna::sd` = tidyna::sd(x_na),

  # Extrema
  `base::max` = base::max(x_na, na.rm = TRUE),
  `tidyna::max` = tidyna::max(x_na),

  # Logical
  `base::any` = base::any(lgl_na, na.rm = TRUE),
  `tidyna::any` = tidyna::any(lgl_na),

  # Row functions (1000 x 10000 matrix)
  `base::rowMeans` = base::rowMeans(mat_na, na.rm = TRUE),
  `tidyna::rowMeans` = tidyna::rowMeans(mat_na),

  `base::rowSums` = base::rowSums(mat_na, na.rm = TRUE),
  `tidyna::rowSums` = tidyna::rowSums(mat_na),

  check = FALSE,
  time_unit = "ms"
)

print(results[, 1:5])

# --- Chart -----------------
plot_data <- data.frame(
  expression = as.character(results$expression),
  median_ms = as.numeric(results$median)
)
plot_data$package <- ifelse(grepl("tidyna", plot_data$expression), "tidyna", "base R")
plot_data$fn <- sub("^.*::", "", plot_data$expression)

fn_order <- c("mean", "median", "sd", "max", "sum", "cor", "any", "rowMeans", "rowSums")
plot_data$fn <- factor(plot_data$fn, levels = rev(fn_order))

p <- ggplot(plot_data, aes(x = fn, y = median_ms, fill = package)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  coord_flip() +
  scale_fill_manual(
    values = c("base R" = "#666666", "tidyna" = "#0072B2")
  ) +
  labs(
    title = "tidyna overhead vs base R (10M rows, 0.1% NAs)",
    x = NULL,
    y = "Median in ms",
    fill = NULL,
    caption = "bench::mark() \u2022 R 4.5"
  ) +
  theme_light(base_size = 11) +
  theme(
    legend.position = "top",
    legend.justification = "left",
    plot.title = element_text(face = "bold", size = 13),
    plot.caption = element_text(color = "#999999", size = 8)
  )

ggsave("benchmarks/overhead.png", p, width = 8, height = 4, dpi = 150)
cli_alert_success("Chart saved to benchmarks/overhead.png")
