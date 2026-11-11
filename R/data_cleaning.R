# All data imports/transforms stay here. Never publish row-level outputs.

assert_columns <- function(dat, required) {
  absent <- setdiff(required, names(dat))
  if (length(absent)) {
    stop("Missing expected columns: ", paste(absent, collapse = ", "), call. = FALSE)
  }
  invisible(TRUE)
}

read_wave2 <- function(path = "data/raw/Data_Wave2.csv") {
  if (!file.exists(path)) {
    stop("Wave 2 data missing. Download Data_Wave2.csv into data/raw/ (do not commit it).", call. = FALSE)
  }
  # Keep all original survey values as text to prevent Qualtrics metadata rows
  # from corrupting numeric inference. Names are read from line 1.
  dat <- readr::read_csv(
    path,
    col_types = readr::cols(.default = readr::col_character()),
    na = c("", "NA"),
    name_repair = "unique",
    show_col_types = FALSE
  )
  assert_columns(dat, c("StartDate", "Finished", "Q256", "Q243_9", "Q201_4"))
  if (nrow(dat) < 3L ||
      !identical(dat$StartDate[1L], "Start Date") ||
      !startsWith(dat$StartDate[2L], '{"ImportId"')) {
    stop("Unexpected Qualtrics header layout: verify the export before removing metadata rows.", call. = FALSE)
  }
  dat <- dat[-c(1L, 2L), , drop = FALSE]
  dplyr::filter(dat, tolower(trimws(Finished)) == "true")
}

parse_satisfaction <- function(x) {
  x <- trimws(as.character(x))
  x <- ifelse(grepl("^10=", x), "10", x)
  x <- ifelse(grepl("^0=", x), "0", x)
  suppressWarnings(as.numeric(x))
}

# Midpoints are researcher-chosen approximations, NOT exact observed hours.
# Sensitivity analysis should use hours as categories.
parse_paid_hours_midpoint <- function(x) {
  x <- trimws(as.character(x))
  lookups <- c(
    "Nicht erwerbstätig" = 0, "0 Stunden" = 0,
    "1-10 Stunden" = 5.5, "11-20 Stunden" = 15.5,
    "21-30 Stunden" = 25.5, "31-40 Stunden" = 35.5,
    "41-50 Stunden" = 45.5, "Mehr als 50 Stunden" = 55
  )
  unname(lookups[x])
}

parse_time_pressure <- function(x) {
  x <- trimws(as.character(x))
  lookups <- c(
    "Überhaupt nicht" = 0, "Selten" = 1,
    "Manchmal" = 2, "Oft" = 3, "Sehr häufig" = 4
  )
  as.integer(unname(lookups[x]))
}

parse_days_from_label <- function(x) {
  x <- trimws(as.character(x))
  valid <- grepl("^[0-5] Tage?$", x)
  out <- rep(NA_real_, length(x))
  out[which(!is.na(valid) & valid)] <- suppressWarnings(as.numeric(sub(" .*", "", x[which(!is.na(valid) & valid)])))
  out
}

build_analysis_sample <- function(dat) {
  req <- c(
    "Finished", "Q2", "Q80_1", "Q256", "Q179", "Q224", "Q237",
    "Q222", "Q229", "Q243_9", "Q197_3", "Q201_4"
  )
  assert_columns(dat, req)
  # For unit tests, only "Finished"==TRUE or "True" is retained; raw importer
  # also filters completed surveys before this function is called.
  dat <- dplyr::filter(dat, tolower(trimws(Finished)) == "true")
  clean <- dplyr::transmute(
    dat,
    female = dplyr::case_when(
      Q256 == "Weiblich" ~ 1,
      Q256 == "Männlich" ~ 0,
      TRUE ~ NA_real_
    ),
    gender = dplyr::case_when(
      Q256 == "Weiblich" ~ "Women",
      Q256 == "Männlich" ~ "Men",
      TRUE ~ NA_character_
    ),
    partner_reported = !is.na(Q2) & grepl("Partner", Q2, fixed = TRUE),
    housework_share = suppressWarnings(as.numeric(Q243_9)),
    share_centered = housework_share - 50,
    time_pressure = parse_time_pressure(Q201_4),
    time_pressure_high = dplyr::if_else(
      is.na(time_pressure), NA_integer_, as.integer(time_pressure >= 3)
    ),
    housework_satisfaction = parse_satisfaction(Q197_3),
    respondent_paid_hours = parse_paid_hours_midpoint(Q179),
    partner_paid_hours = parse_paid_hours_midpoint(Q224),
    hours_self_raw = Q179,
    hours_partner_raw = Q224,
    children_under18 = dplyr::case_when(
      Q237 == "Ja" ~ 1,
      Q237 == "Nein" ~ 0,
      TRUE ~ NA_real_
    ),
    respondent_wfh_days = parse_days_from_label(Q222),
    partner_wfh_days = parse_days_from_label(Q229),
    age = suppressWarnings(as.numeric(Q80_1))
  )
  # Only report as a partnered adult when Q2 explicitly lists a partner.
  clean <- dplyr::filter(
    clean, partner_reported, !is.na(female),
    !is.na(housework_share), housework_share >= 0, housework_share <= 100,
    !is.na(time_pressure)
  )
  clean$age[clean$age < 18 | clean$age > 95] <- NA_real_
  clean
}

model_complete_cases <- function(clean) {
  required <- c("female", "share_centered", "time_pressure", "time_pressure_high",
                "housework_satisfaction", "respondent_paid_hours",
                "partner_paid_hours", "children_under18", "age")
  dplyr::filter(clean, stats::complete.cases(clean[, required, drop = FALSE]))
}
