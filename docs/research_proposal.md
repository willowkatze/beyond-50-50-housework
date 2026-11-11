# Pre-consultation research proposal (draft, 11 Nov 2026)

## Proposed title

**Beyond the 50/50 Split: Gender, Housework Shares, and Perceived Time Scarcity**

Alternative presentation hook: *Equal Chores, Unequal Time?*

## Motivation

A reported equal split of housework need not imply equal experiences of time pressure. Recent mental-load research distinguishes the physical execution of domestic tasks from cognitive and organizational responsibility. Our dataset does **not** directly capture those hidden responsibilities, so the paper asks a narrower measurable question: how does perceived time scarcity vary with reported housework shares and gender?

## Research questions

- RQ1: Is respondent-reported housework share associated with perceived insufficient time?
- RQ2: Does the association between housework share and time pressure differ by gender?
- RQ3: Do these associations remain after adjusting for respondent and partner paid-work time, children, and age?
- Secondary: Is the pattern similar for satisfaction with housework division?

## Pre-specified hypotheses (not results)

- H0a: Conditional on the controls, coefficient on `female` = 0 in an interaction model centered at a reported 50/50 division.
- H0b: The interaction coefficient `female × (housework_share − 50)` = 0.
- Exploratory alternative: A higher share correlates with greater time pressure more strongly among female respondents.

## Data

ELKiD second-wave online survey, Germany, June–early July 2021. Up to 936 completed questionnaires in the provided Wave 2 export. Only a subset answered the household task allocation modules; the final estimation sample N must be audited. National stratification by gender/age/state does not automatically make a *restricted partnered subsample* nationally representative.

## Key measures

- Y1 primary: `Q201_4` — feeling that there is not enough time to complete everything, five-level ordinal response coded 0–4.
- Y2 secondary: `Q197_3` — satisfaction with own share of housework, 0–10.
- Y3 robustness: binary frequent time pressure (`Oft` / `Sehr häufig`).
- X: `Q243_9` — self-reported percentage share of time spent on housework relative to partner (0–100).
- Moderator: `Q256` — respondent gender, primarily women/men due to tiny other-category cell counts. Do not interpret gender as causal treatment.
- Controls: `Q179`, `Q224` (paid working-hour bands), `Q237` (children under 18), `Q80_1` (age); `Q222` and `Q229` WFH days as optional sensitivity variables due to missingness.

## Models

Baseline: `time_pressure ~ share_centered`, then add `female`.

Interaction: `time_pressure ~ share_centered * female`.

Adjusted: `time_pressure ~ share_centered * female + respondent_paid_hours + partner_paid_hours + children_under18 + age`.

`share_centered = housework_share - 50`; thus the `female` coefficient is the adjusted gender difference at exactly a reported 50/50 division, holding controls constant. The interaction term asks whether the slope differs, not whether cognitive labor exists.

Use a common complete-case estimation sample when comparing nested models. The primary model uses OLS for course consistency; clarify that the dependent variable is ordinal. Use robust standard errors / ordered logit only after mentor discussion or in robustness appendix. Working-hour band midpoint assumptions must be disclosed.

## Identification and risks

1. Cross-sectional associations and potential reverse causation; time pressure could shape home-task choices.
2. One respondent's self-report, no paired partner diary or partner verification.
3. Unmeasured household decision-making, norms, personal organization, health and labor-market selection.
4. Pandemic year 2021 and possible school closures; limited contemporary external validity.
5. Skip-logic conditioning: housework questions are restricted to respondents reporting partner household arrangements.
6. Gender is an observed social characteristic, not a manipulable causal exposure.
7. No direct psychological or cognitive mental-load scale; do not claim proof of invisible labor.
8. Small 50/50 subgroup: descriptive illustrative only; main model uses all eligible partnered respondents.
9. Survey categories and item reference periods need verification against exact questionnaire wording.

## Planned results to deliver (not yet validated)

- Figure 1: descriptive share vs time-pressure score, stratified by gender.
- Figure 2: adjusted predictions, centered at a 50/50 reported split.
- Table 1: four incremental OLS models on common complete-case sample.
- Table 2: time-pressure index, high-pressure indicator, and household-satisfaction outcome; different scales clearly labeled.
- Data/sample table and literature synthesis.

## Teacher decisions needed

- Is it acceptable to operationalize subjective time scarcity from one item, rather than calling it mental load?
- Is OLS appropriate for 0–4 ordinal stress response, with logit robustness?
- Which controls are essential in the 10-minute format?
- Are association-focused hypotheses sufficient for this seminar, given observational data and selection?
- Should household work & food preparation be separated? Are there survey weights or design factors expected?
