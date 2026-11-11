testthat::test_that("Six pre-specified models fit the common complete-case sample", {
  dat <- build_analysis_sample(fixture_wave2(60))
  dat <- model_complete_cases(dat)
  models <- fit_models(dat)
  testthat::expect_named(models, c("m1", "m2", "m3", "m4", "m5", "m6"))
  testthat::expect_true(all(vapply(models, stats::nobs, numeric(1)) == nrow(dat)))
  testthat::expect_true("share_centered:female" %in% names(stats::coef(models$m4)))
})
