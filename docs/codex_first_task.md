# Ready-to-paste Codex task — first PR

**Repository:** `willowkatze/beyond-50-50-housework`
**Branch:** `research/sample-audit`
**Goal:** Prepare an instructor-ready data audit for a 2021 ELKiD Wave 2 seminar without exposing course survey data.

Read `AGENTS.md`, `README.md`, `docs/variable_dictionary.md` and `docs/research_proposal.md` before editing. Work only on sample audit / variable validation, not new hypotheses. Add an R function in `R/data_cleaning.R` that reports counts for: completed cases, respondents with partner in Q2, valid Q243_9 values (0–100), valid Q201_4 levels, valid satisfaction Q197_3, respondent and partner paid-hour values, and complete-case model N. It must return **only an aggregate table** and never write respondent-level data.

Write synthetic-fixture tests for missingness, unexpected survey labels and the 50/50 subgroup. Document each rule in `docs/variable_dictionary.md`, and update `docs/decision_log.md` with methodological questions. Do not use or request raw data or participant identifiers in the PR; do not invent results. Open a **draft PR**, include a short summary, how tests were run, and what decisions remain for the Nov 16 consultation.
