find_project_file <- function(relative_path) {
  # testthat::test_dir may execute helpers from the tests/testthat directory.
  candidates <- c(relative_path, file.path("..", "..", relative_path))
  available <- candidates[file.exists(candidates)]
  if (length(available) == 0L) stop("Could not locate project file: ", relative_path)
  available[[1L]]
}
source(find_project_file("R/data_cleaning.R"), encoding = "UTF-8")
source(find_project_file("R/analysis.R"), encoding = "UTF-8")

fixture_wave2 <- function(n = 30L) {
  data.frame(
    Finished = rep("True", n),
    Q2 = rep("Partner", n),
    Q80_1 = as.character(rep(35:44, length.out = n)),
    Q256 = rep(c("Weiblich", "Männlich"), length.out = n),
    Q179 = rep(c("31-40 Stunden", "11-20 Stunden", "41-50 Stunden", "0 Stunden"), length.out = n),
    Q224 = rep(c("31-40 Stunden", "0 Stunden", "21-30 Stunden"), length.out = n),
    Q237 = rep(c("Ja", "Nein", "Nein", "Ja", "Nein"), length.out = n),
    Q222 = rep("0 Tage", n),
    Q229 = rep("0 Tage", n),
    Q243_9 = as.character(rep(c(30, 50, 70), length.out = n)),
    Q197_3 = rep(c("10=ganz und gar zufrieden", "5", "0=ganz und gar unzufrieden"), length.out = n),
    Q201_4 = rep(c("Überhaupt nicht", "Manchmal", "Sehr häufig", "Oft", "Selten"), length.out = n),
    stringsAsFactors = FALSE
  )
}
