# Locking automation to the `deployment` branch

This repo keeps all CI/CD (`.github/workflows/`) physically on the
`deployment` branch only — `main` never contains it. That alone stops
anything from *running* anywhere else, since GitHub Actions only executes
workflow files that exist in the ref actually being built. The settings
below stop the file itself from ever being merged into `main` by
accident.

Apply these on **github.com → this repo → Settings**.

## 1. Protect `main`

**Settings → Branches → Add branch protection rule** (or **Settings →
Rules → Rulesets** for the newer UI), targeting `main`:

- Require a pull request before merging (no direct pushes).
- Require review from Code Owners — this makes `.github/CODEOWNERS`
  (`/.github/workflows/ @devduniya`) enforce that only you can approve a
  PR that touches `.github/workflows/**`, even by accident.
- Block force pushes.
- Restrict deletions.
- Do not allow bypassing the above settings, including for admins.

## 2. Never merge `deployment` → `main`

This is a workflow rule, not a GitHub setting: `deployment` only ever
receives merges *from* `main`, never the other way. Merging it back would
carry `.github/workflows/` into `main`.

## 3. Optional: restrict who can push to `deployment` directly

Since a push to `deployment` triggers a real build and spends your Apple
signing secrets, consider a lighter rule restricting which users/teams
can push to it directly, even without requiring a full PR.
