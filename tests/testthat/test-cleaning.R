testthat::test_that("German time-pressure and satisfaction coding is explicit", {
  testthat::expect_identical(
    parse_time_pressure(c("Überhaupt nicht", "Selten", "Manchmal", "Oft", "Sehr häufig")),
    0:4
  )
  testthat::expect_true(is.na(parse_time_pressure("unknown")))
  testthat::expect_equal(parse_satisfaction(c("0=ganz und gar unzufrieden", "5", "10=ganz und gar zufrieden")), c(0, 5, 10))
})

testthat::test_that("Only completed partnered respondents with valid variables enter the sample", {
  f <- fixture_wave2(30)
  f$Q2[1] <- "Mitbewohner"
  f$Finished[2] <- "False"
  f$Q243_9[3] <- "110" # impossible percentage
  f$Q256[4] <- "Divers" # too few for specified gender comparison
  f$Q201_4[5] <- "?" # no silent zero recode
  c <- build_analysis_sample(f)
  testthat::expect_equal(nrow(c), 25L)
  testthat::expect_true(all(c$housework_share >= 0 & c$housework_share <= 100))
  testthat::expect_true(all(!is.na(c$time_pressure)))
})

testthat::test_that("Centering makes 50/50 equal zero and working hours remain approximate", {
  d <- build_analysis_sample(fixture_wave2(30))
  testthat::expect_equal(unique(d$share_centered[d$housework_share == 50]), 0)
  testthat::expect_equal(parse_paid_hours_midpoint("31-40 Stunden"), 35.5)
  testthat::expect_equal(unique(d$partner_wfh_days), 0)
})
