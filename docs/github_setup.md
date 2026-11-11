# GitHub setup / workflow

GitHub account: **willowkatze**. A separate repository is needed; `ppo-perishable-pricing` is unrelated and should not be modified.

## Step 1: create the remote repository

Open <https://github.com/new> while logged in as `willowkatze`.

- Owner: `willowkatze`
- Repository name: `beyond-50-50-housework`
- Visibility: **Private** (recommended during the seminar)
- **Do not** generate a README, `.gitignore`, or license at creation: they already exist locally.

## Step 2: start from the provided downloaded starter archive

Unzip the provided project archive to a new folder, open a terminal *in the folder containing README.md*, then run:

```bash
git init -b main
git add .
git status  # confirm no raw data or outputs are staged
git commit -m "chore: initialize reproducible housework seminar study"
git remote add origin https://github.com/willowkatze/beyond-50-50-housework.git
git push -u origin main
```

If your local git is already initialized, skip `git init -b main` and verify `git remote -v` before adding origin. If `git commit` says **Author identity unknown**, configure `git config --global user.name "Your GitHub display name"` and `git config --global user.email "an email associated with your GitHub account"` on your own computer before retrying. Do not use someone else’s identity. If GitHub prompts for authentication, use your configured credential manager / GitHub CLI (not a plaintext password).

## Step 3: daily issue → branch → PR workflow

```bash
git switch main
git pull --ff-only
git switch -c research/sample-audit
# edit files, run R tests
git add R/ docs/ tests/ scripts/
git commit -m "research: audit sample eligibility and survey response coding"
git push -u origin research/sample-audit
```

In GitHub, open a **draft pull request** targeting `main`; reference the Issue number in the PR description. Review changed files and the **R synthetic-data checks** action before merging. Use a squash merge for one coherent task.

## Step 4: use Codex

- Open your newly-created GitHub repository in Codex (if Codex is available to your account and repo connection).
- Ask Codex to read `AGENTS.md` and work on one GitHub Issue / branch at a time.
- Do **not** provide the private raw survey file to a cloud coding agent without verifying institutional authorization. It can write and test transformation code using the synthetic fixtures and descriptive schema.
- Have Codex open a draft PR rather than writing directly into `main`.

## Suggested initial Issues

1. **Audit ELKiD Wave 2 eligibility and missingness** — validate partner filter, sample counts, category labels, age/percentage outliers; synthetic tests.
2. **Pre-register estimands and regression specifications** — verify hypotheses, ordinal outcome treatment, robust SEs and controls.
3. **Reproduce first two figures and regression tables** — generate publication-readable outputs and label observational associations.
4. **Literature synthesis: housework, cognitive labor, time scarcity** — collect recent peer-reviewed publications; separate mental load theory from observed measures.
5. **Prepare 10-minute course presentation** — summary stats, motivation, regression tables, results, limitations and references.

## CI notes

`.github/workflows/r-ci.yml` runs on PRs and main pushes. It installs R and dependencies, fails if raw or processed data are tracked, and executes tests against **synthetic fixtures only**. This cannot validate the private-data analysis: that remains a local/manual responsibility.
