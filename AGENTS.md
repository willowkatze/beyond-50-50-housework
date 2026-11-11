# Codex Research Instructions (AGENTS.md)

You are assisting on a TUM applied-econometrics seminar project in R. The scope is a research analysis—not a product/web application.

## Immutable research constraints

1. **Never commit or upload** data under `data/raw/`, `data/processed/`, participant IDs, free-text responses, credentials, or `outputs/`. Do not copy survey records into prompts or issue/PR discussions.
2. The ELKiD Wave 2 data are from **2021**. Interpret associations; do not write causal claims without an identification design.
3. Variables: `Q243_9` = self-reported share of housework; `Q201_4` = how often respondent feels there is insufficient time; `Q197_3` = satisfaction with own share of housework; `Q256` = gender; `Q179`, `Q224` = paid working-hours bands; `Q237` = children aged 0–17; `Q80_1` = age.
4. Do not equate perceived time scarcity with **directly observed mental load**. The survey has no direct cognitive-household-labor inventory.
5. Observe survey skip logic and sample restrictions. Keep original raw labels unchanged until a documented transformation. Never silently interpret unrecognized values as zero.
6. Do not merge Wave 1 and Wave 2 until a validated participant key and matching rule have been documented; the `tic` field has not been validated as a match key.
7. Do not fabricate empirical results, paper references, significance, CI status, or university requirements.

## Coding rules

- Write reproducible, readable R: `readr`, `dplyr`, `ggplot2`, `stats::lm`, `broom`.
- Keep data cleaning in `R/data_cleaning.R`, analytical functions in `R/analysis.R`, and execution in `scripts/run_all.R`.
- Add **synthetic-fixture tests** for changed variables, missingness, group filters, and analysis output. CI has no private data.
- Prefer minimal explicit code over novel dependencies; no ML just to look sophisticated.
- Every hypothesis, sample restriction, imputation, and alternative coding must be documented.
- Avoid repeated p-value fishing. Pre-register primary/secondary outcomes and note exploratory analyses.

## Pull request policy

Each PR should explain (a) why, (b) what changed, (c) expected effect on sample and estimand, (d) tests, (e) limitations. If changing recodes or model specification, update the dictionary or research proposal alongside code. Do not merge silently; seek human review for methodological changes.

## Immediate priority

Read `docs/consultation_2026-11-16.md`. Audit partner presence and missingness; prepare a transparent 1-page sample flow, and propose 2–3 alternative specifications for teacher feedback. Do not claim final results before data audit.
