# Mandatory Q&A · Monday, 16 November 2026 · 11:00–11:30 CET

**Group:** Intra-household allocation of tasks
**Place:** Microsoft Teams (organization sheet link to be checked)
**Instructor:** Dr. Helen Zeidler
**Participation is mandatory.**

## Before the meeting (checklist)

- [ ] Check Teams join link in [course schedule](https://docs.google.com/spreadsheets/d/10yXCb5Cn2QtRmovT62ktZoDbRKkzkRV_sEJZbfVaADk/edit).
- [ ] Read `docs/research_proposal.md` and 2025 IZA mental-load paper abstract.
- [ ] Download Wave 2 CSV privately; run `results <- run_project()` after installing R packages.
- [ ] Note exact sample N, missingness of Q243_9, Q201_4, Q197_3, and control variables.
- [ ] Prepare a 60-second introduction and no more than three priority questions.

## 60-second opening statement

> I plan to study whether a self-reported equal division of housework corresponds to equal perceived time pressure for women and men. My provisional title is **Beyond the 50/50 Split**. I would use ELKiD Wave 2, focusing on the reported housework share (`Q243_9`), the time-insufficiency item (`Q201_4`) and satisfaction with housework division (`Q197_3`). The main analysis would compare gender-specific associations and adjust for paid working hours, the partner's working hours, children and age. I understand that the survey does not directly measure mental load, so I would present the findings as descriptive associations rather than causal evidence. I would appreciate your advice on how best to define the outcome and narrow the empirical strategy.

## 30-minute group slot: suggested use of your turn

| Time | Goal |
| --- | --- |
| 0–2 min | Introduce question, why original, exact variables |
| 2–4 min | Clarify sample size / question wording / skip logic |
| 4–6 min | Ask for guidance on OLS vs ordinal model and needed controls |
| 6–8 min | Confirm scope for two figures, two regression tables |

Other students must also use this 30-minute **group** slot; keep your individual contribution compact.

## Top three questions to ask

1. **Measurement:** “Is it methodologically defensible to use Q201_4 as a narrow measure of perceived time scarcity, while explicitly not claiming we observe mental load?”
2. **Model specification:** “Would you recommend the 0–4 time-pressure item as an OLS outcome with a gender–housework interaction, or should I use an ordered-response model? How many controls are realistic?”
3. **Sample and requirement:** “Because Q243_9 is asked only to a subset of partnered respondents, should I focus on the full eligible partnered sample and use the 50/50 group as an illustration rather than a stand-alone analysis? Would that satisfy your two-table requirement?”

## After meeting

Write a short dated decision log in `docs/decision_log.md`: supervisor comments, revised title, model, variable restrictions, next tasks. Convert concrete changes into GitHub Issues and a dedicated branch/PR.
