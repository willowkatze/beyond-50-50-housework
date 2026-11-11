# Run from RStudio project root: source("scripts/run_all.R"); results <- run_project()
source("R/data_cleaning.R", encoding = "UTF-8")
source("R/analysis.R", encoding = "UTF-8")

run_project <- function(wave2_path = "data/raw/Data_Wave2.csv") {
  raw <- read_wave2(wave2_path)
  clean <- build_analysis_sample(raw)
  analysis <- model_complete_cases(clean)
  if (!nrow(clean)) stop("No partnered respondents with valid key variables.")
  models <- fit_models(analysis)
  figures <- build_figures(clean, models, analysis)
  dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)
  dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)
  ggplot2::ggsave("outputs/figures/fig1_unadjusted.png", figures$fig1,
                  width = 9, height = 5.5, dpi = 200)
  ggplot2::ggsave("outputs/figures/fig2_adjusted.png", figures$fig2,
                  width = 9, height = 5.5, dpi = 200)
  readr::write_csv(gender_summary(clean), "outputs/tables/gender_summary.csv")
  readr::write_csv(sample_summary(clean, analysis), "outputs/tables/sample_flow.csv")
  readr::write_csv(model_long_table(models), "outputs/tables/model_coefficients.csv")
  message("Completed locally. Primary partnered sample N=", nrow(clean),
          "; common complete-case model N=", nrow(analysis),
          ". Results saved under gitignored outputs/.")
  invisible(list(raw_n = nrow(raw), clean = clean, analysis = analysis,
                 models = models, figures = figures))
}
