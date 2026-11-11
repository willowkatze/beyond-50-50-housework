# Preliminary data audit (exploratory; verify with local R pipeline)

These are **unadjusted, hand-checked aggregate counts** from an earlier inspection of the instructor-provided `Data_Wave2.csv`. They are not model outputs or final reproducible estimates. They may change after verified eligibility and complete-case filtering.

| Descriptive count | Initial finding |
| --- | ---: |
| Completed Wave 2 questionnaires | 936 |
| Nonmissing `Q243_9` housework-share responses | 383 |
| Nonmissing `Q197_3` housework-satisfaction responses | 401 |
| Self-reported exact 50/50 share (`Q243_9 = 50`) | 99 |
| Within exact 50/50 subgroup: women / men | 33 / 66 |
| Within exact 50/50 women: often or very often insufficient time | 10 / 33 (30.3%) |
| Within exact 50/50 men: often or very often insufficient time | 2 / 66 (3.0%) |

**Critical interpretation:** With only 10 vs 2 high-pressure observations in the 50/50 subgroup, statistical uncertainty and confounding are substantial. No claim of a significant adjusted difference, sample representativeness, fairness, or directly observed *mental load* is justified. The final regression must use all eligible partnered respondents, not select a subgroup just because it illustrates a dramatic contrast. Avoid making the contrast the headline until the instructor has approved the methodological approach.

Initial provenance: instructor-provided ELKiD Wave 2 export, `Q243_9`, `Q201_4`, `Q256`, and `Finished` fields. Check exact extraction with the local R pipeline after obtaining the private file.
