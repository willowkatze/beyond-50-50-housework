# Functions for transparent descriptive and regression analysis.

fit_models <- function(analysis_data) {
  if (nrow(analysis_data) < 15L) {
    stop("Too few complete observations to fit the specified models.", call. = FALSE)
  }
  # All models use the SAME complete-case sample for specification comparison.
  list(
    m1 = stats::lm(time_pressure ~ share_centered, data = analysis_data),
    m2 = stats::lm(time_pressure ~ share_centered + female, data = analysis_data),
    m3 = stats::lm(time_pressure ~ share_centered * female, data = analysis_data),
    m4 = stats::lm(time_pressure ~ share_centered * female +
                     respondent_paid_hours + partner_paid_hours +
                     children_under18 + age, data = analysis_data),
    # Secondary outcomes. For LPM: estimates reflect probability points.
    m5 = stats::lm(time_pressure_high ~ share_centered * female +
                     respondent_paid_hours + partner_paid_hours +
                     children_under18 + age, data = analysis_data),
    m6 = stats::lm(housework_satisfaction ~ share_centered * female +
                     respondent_paid_hours + partner_paid_hours +
                     children_under18 + age, data = analysis_data)
  )
}

regression_table <- function(models) {
  # Presentation-oriented wide layout; coefficient followed by (standard error).
  long <- lapply(names(models), function(name) {
    tab <- broom::tidy(models[[name]])
    data.frame(
      term = tab$term,
      model = name,
      coefficient_se = sprintf("%.3f (%.3f)", tab$estimate, tab$std.error),
      stringsAsFactors = FALSE
    )
  })
  wide <- tidyr::pivot_wider(dplyr::bind_rows(long),
                             names_from = model, values_from = coefficient_se)
  n <- vapply(models, stats::nobs, numeric(1))
  r2 <- vapply(models, function(m) summary(m)$adj.r.squared, numeric(1))
  bottom <- data.frame(term = c("N", "Adjusted R2"), stringsAsFactors = FALSE)
  for (name in names(models)) {
    bottom[[name]] <- c(as.character(n[[name]]), sprintf("%.3f", r2[[name]]))
  }
  dplyr::bind_rows(wide, bottom)
}

model_long_table <- function(models) {
  all <- lapply(names(models), function(name) {
    tmp <- broom::tidy(models[[name]], conf.int = TRUE)
    tmp$model <- name
    tmp$n <- stats::nobs(models[[name]])
    tmp$adjusted_r2 <- summary(models[[name]])$adj.r.squared
    tmp
  })
  dplyr::bind_rows(all)
}

sample_summary <- function(clean, analysis_data) {
  data.frame(
    metric = c("Partnered respondents with valid primary X/Y",
               "Complete cases for main and secondary models",
               "Women in complete-case sample", "Men in complete-case sample",
               "50/50 reported division in complete-case sample"),
    count = c(nrow(clean), nrow(analysis_data),
              sum(analysis_data$female == 1), sum(analysis_data$female == 0),
              sum(analysis_data$housework_share == 50)),
    stringsAsFactors = FALSE
  )
}

gender_summary <- function(clean) {
  clean |>
    dplyr::group_by(gender) |>
    dplyr::summarise(
      n = dplyr::n(),
      mean_housework_share = mean(housework_share, na.rm = TRUE),
      mean_time_pressure = mean(time_pressure, na.rm = TRUE),
      pct_high_time_pressure = 100 * mean(time_pressure_high == 1, na.rm = TRUE),
      mean_housework_satisfaction = mean(housework_satisfaction, na.rm = TRUE),
      .groups = "drop"
    )
}

build_figures <- function(clean, models, analysis_data) {
  fig1 <- ggplot2::ggplot(clean, ggplot2::aes(
    x = housework_share, y = time_pressure, color = gender
  )) +
    ggplot2::geom_jitter(width = 1.5, height = 0.15, alpha = 0.30, size = 1.4) +
    ggplot2::geom_smooth(method = "lm", formula = y ~ x, se = TRUE) +
    ggplot2::scale_y_continuous(breaks = 0:4, limits = c(-0.15, 4.15)) +
    ggplot2::labs(
      x = "Self-reported share of housework (%)",
      y = "Frequency of perceived time insufficiency (0–4)",
      color = "Respondent", title = "Housework share and perceived time pressure",
      subtitle = "Unadjusted relationships; confidence bands are descriptive"
    ) +
    ggplot2::theme_minimal(base_size = 12)

  # Prediction at typical control values; x centered at 50 is interpretable.
  grid <- expand.grid(
    share_centered = seq(-40, 50, by = 5), female = c(0, 1)
  )
  grid$respondent_paid_hours <- mean(analysis_data$respondent_paid_hours)
  grid$partner_paid_hours <- mean(analysis_data$partner_paid_hours)
  grid$children_under18 <- mean(analysis_data$children_under18)
  grid$age <- mean(analysis_data$age)
  pred <- stats::predict(models$m4, newdata = grid, interval = "confidence")
  grid$estimate <- pred[, "fit"]
  grid$lwr <- pred[, "lwr"]
  grid$upr <- pred[, "upr"]
  grid$share <- grid$share_centered + 50
  grid$gender <- ifelse(grid$female == 1, "Women", "Men")

  fig2 <- ggplot2::ggplot(grid, ggplot2::aes(
    x = share, y = estimate, color = gender, fill = gender
  )) +
    ggplot2::geom_ribbon(
      ggplot2::aes(ymin = lwr, ymax = upr), alpha = 0.16, color = NA
    ) +
    ggplot2::geom_line(linewidth = 0.9) +
    ggplot2::geom_vline(xintercept = 50, linetype = "dashed", color = "grey55") +
    ggplot2::labs(
      x = "Self-reported share of housework (%)",
      y = "Adjusted predicted time-pressure score (0–4)",
      color = "Respondent", fill = "Respondent",
      title = "Adjusted predictions by gender",
      subtitle = "OLS model m4; 95% confidence bands, associations only"
    ) +
    ggplot2::theme_minimal(base_size = 12)
  list(fig1 = fig1, fig2 = fig2)
}
