# Working variable dictionary: ELKiD Wave 2

These mappings are based on the *provided* German Variable Overview and Wave 2 Qualtrics CSV column headers. Complete response codes and question routing should be verified before reporting final regression results.

| Survey code | English meaning / measurement | Role | Planned handling |
| --- | --- | --- | --- |
| `Finished` | Completion flag | Filter | Keep True; exclude Qualtrics 2 metadata rows |
| `Q2` | People living in the household, multiple choices | Eligibility | Requires response containing “Partner” |
| `Q243_9` | Respondent's share of housework vs partner (slider, 0–100) | Main predictor | Numeric, reject outside 0–100; center at 50 |
| `Q201_4` | “Felt that there was not enough time to do everything” in past week | Primary outcome | 0=Not at all, 1=Rarely, 2=Sometimes, 3=Often, 4=Very often |
| `Q197_3` | Satisfaction with own share of housework, 0–10 | Secondary outcome | Parse text-labeled endpoints 0 and 10 |
| `Q256` | Gender: männlich, weiblich, divers | Moderator | Women/men comparison; acknowledge tiny other category |
| `Q179` | Respondent's paid work hours last four weeks, bands | Covariate | Approximate midpoints 0, 5.5, 15.5, 25.5, 35.5, 45.5, 55; categorical sensitivity |
| `Q224` | Partner's paid work hours last four weeks, bands | Covariate | Same; missing not imputed |
| `Q237` | Whether children aged 0–17 in household | Covariate | Ja=1; Nein=0 |
| `Q80_1` | Age (years) | Covariate | Numeric; out-of-range ages (<18 or >95) set missing as pre-specified plausibility rule |
| `Q222` | Respondent WFH days in 5-day week | Optional covariate | Parse 0–5 days; examine missingness |
| `Q229` | Partner WFH days in 5-day week | Optional covariate | Parse 0–5 days; examine missingness |

## Important distinctions

- `Q243_1` is grocery shopping and meal preparation, **not** general household work. Do not mix this with `Q243_9` without explicitly labeling the alternative outcome.
- `Q243_2` is childcare/care of relatives; `Q243_3` is schooling/homework help; both can have substantially smaller eligible samples.
- `Q201_4` is a **single stress/time-insufficiency question**, not a complete time poverty/mental load inventory.
- WFH days are not necessarily defined for non-employed respondents; missingness is often structural, not zero.
- `Q2` is a multiple-choice household composition item; confirm respondent and partner share a household.
- 2021 pandemic context affects findings; no causal identification design has been verified.
- Survey may contain multiple same-label columns (e.g., Q252) in original exports; `readr` repairs duplicate names, but the selected core variables above should remain unambiguous.

## Pre-analysis audit

1. Print sample counts: finished, partnered, with valid share, time pressure, satisfaction, controls.
2. Check all unique raw values of `Q201_4`, `Q179`, `Q224`, `Q197_3` before modeling.
3. Check reporting sample sizes for any `50/50` descriptive comparison.
4. Confirm participants have one unpaired response each; do not treat them as matched couples.
5. If inference includes survey weights, verify weight variable with instructor first.
