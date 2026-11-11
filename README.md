# Beyond the 50/50 Split

**Gender, Housework Shares, and Perceived Time Scarcity**
TUM · Data Science in Business and Economics with R · Winter 2026/27
Research status: **exploratory / pre-consultation (November 2026)**

## Research question

When partners report a similar division of housework, do women and men still report different levels of perceived time scarcity? Is any difference robust to adjustment for respondent/partner paid working hours and parenthood?

**Interpretation boundary:** The ELKiD survey does **not** directly measure cognitive or emotional *mental load*. Its time-insufficiency item is a proxy for *perceived time scarcity*, not an objective time-use diary or validated complete time-poverty measure. This is an **observational association**, not a causal estimate.

## Course deliverables

- 10-minute presentation, references, at least one null hypothesis.
- Summary statistics table; **two substantive figures and two regression tables**.
- Data, regression equation, identification limitations, interpretation, and policy implications.
- Mandatory group consultation **Monday, 16 November 2026, 11:00–11:30 Europe/Berlin, Microsoft Teams**. Teams link to be obtained from course organization sheet.

## 1. Local setup

Install [R](https://cran.r-project.org/), [RStudio](https://posit.co/download/rstudio-desktop/), and optional [Quarto](https://quarto.org/docs/get-started/). Open `beyond-50-50-housework.Rproj` in RStudio.

In the R console:

```r
install.packages(c("readr", "dplyr", "ggplot2", "tidyr", "broom", "knitr", "testthat"))
```

Download **Data_Wave2.csv** from the teacher's private course folder to `data/raw/Data_Wave2.csv` (exact capitalization). Do **not** commit raw data, participant identifiers, or row-level exported data to GitHub.

- [Data source folder (course access required)](https://drive.google.com/drive/folders/1FhI0Iqd7UhXWXqHBNZG2kRKfNsTxhTB9)
- [Topic / consultation schedule](https://docs.google.com/spreadsheets/d/10yXCb5Cn2QtRmovT62ktZoDbRKkzkRV_sEJZbfVaADk/edit)

## 2. Run the project

From the RStudio **project root**:

```r
source("scripts/run_all.R")
results <- run_project()
```

The pipeline reads Wave 2, drops Qualtrics export metadata rows, creates a pre-registered analysis sample, estimates OLS models, and saves figures/tables under the **gitignored** `outputs/` folder.

Run unit tests with **synthetic data only**:

```r
testthat::test_dir("tests/testthat")
```

Optional, to build the presentation-style research draft:

```bash
quarto render report.qmd --to html
```

The report needs the private dataset locally. CI intentionally tests only synthetic fixtures, so a public GitHub Actions job never needs the raw survey data.

## 3. Research workflow

1. **Scope** — Read `docs/research_proposal.md`, attend first feedback session, refine question.
2. **Audit** — Confirm survey routing, missing data, coding, final N, and quality checks.
3. **Descriptives** — Produce subgroup tables and two publication-readable figures.
4. **Models** — Use centered housework share (`share - 50`) and a gender interaction. Interpret predicted differences, confidence intervals, and limitations.
5. **Writing** — Literature and bibliography; 10-minute slides; robustness checks.

See `docs/consultation_2026-11-16.md`, `docs/variable_dictionary.md`, and `docs/literature_tracker.csv`.

## 4. GitHub / Codex collaboration

- Create a **new private** repository named `beyond-50-50-housework` on your GitHub account; do not reuse the unrelated pricing project.
- Use `main` for reviewed work, and branches such as `research/data-audit`, `research/specification`, `docs/literature-review`.
- Open one issue per decision or deliverable, and one PR per coherent change. CI checks synthetic-data tests on pushes/PRs.
- Give Codex a scoped issue and ask it to read [`AGENTS.md`](AGENTS.md) before making changes.
- Never ask Codex to upload raw survey files, publish participant-level rows, or claim causal effects based on descriptive regressions.

`docs/github_setup.md` provides the concrete new-repository and push commands. `docs/codex_first_task.md` is a ready-to-paste initial Codex task.

## Statistical notes

- The 2021 pandemic period affects interpretation and generalizability.
- Wave 2 has at most 936 completed interviews, but housework-share responses occur only in a subset (around 383 before final auditing); the model must explicitly report its analysis N.
- `Q243_9` is the respondent's **self-reported percentage share** of household work relative to their partner, not the partner's independently observed share.
- Outcome `Q201_4` is a **single ordinal time-insufficiency item**; OLS is a pedagogically transparent approximation. An ordered-response robustness model can be considered after consultation.
- A 50/50 split is a *reported share*, not proof that the family is fair or that mental load is shared equally.

## Data ethics

The repository contains **code and documentation only**. Raw/processed data, row-level files, figures containing potentially identifying small cells, and analysis exports are ignored by default. Before sharing final aggregate results, review consent/usage rules for ELKiD course data.
