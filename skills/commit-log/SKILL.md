---
name: commit-log
description: Quality-gated commit workflow — branch check, staging, pre-commit checks (sensitive files, secrets, README, lint/test), commit message drafting with user approval, and optional push. Use when the user asks to commit changes.
disable-model-invocation: true
---

# Commit Log Workflow

## Workflow

Copy this checklist and track progress:

```
Commit Progress:
- [ ] Step 1: Branch Check
- [ ] Step 2: Stage
- [ ] Step 3: Check
- [ ] Step 4: Message & Commit
- [ ] Step 5: Push
```

**Step 1: Branch Check**

- Run `git branch --show-current`
- If on `master` or `main`:
  - Block: "You're on master. Create a branch first?"
  - Suggest branch name using convention `<type>/<short-description>` derived from context
  - On approval, create and switch to the branch
- If already on a feature branch → proceed

**Step 2: Stage**

- Run `git status` to see all changes
- If files are already staged → show what's staged and proceed
- If nothing is staged → present all modified + untracked files, ask user what to include
- Avoid `git add -A` or `git add .`

**Step 3: Check**

Run these checks on the staged changes:

| Check | Type | Action on fail |
|-------|------|---------------|
| Review all changed files and their purpose | Always | Present summary |
| Sensitive files and content (.env, credentials, keys, tokens, personal details) | Always | Block — unstage and warn |
| README and ARCHITECTURE reflects changes | Always | Warn |
| Lint script (`npm run lint` / Makefile lint) | Auto-detect | Warn |
| Test script (`npm test` / Makefile test) | Auto-detect | Warn |

- **Auto-detect**: check `package.json` scripts or `Makefile` targets for lint/test. Skip gracefully if none exist.
- **Content scan**: review staged diff for leaked secrets — API keys (`sk-`, `ghp_`, `xoxb-`, `AKIA`), tokens, private keys (`-----BEGIN .* PRIVATE KEY-----`), passwords in assignments, connection strings with credentials.
- On any **block**: stop, report, let user decide.
- On **warn**: report all warnings together, ask user to proceed or fix.

**Step 4: Message & Commit**

- Review the full diff of staged changes
- Draft a free-form commit message (short title + body)
- Present: diff summary + proposed message
- Prompt: "Commit with this message? [Y/n/edit]"
- On approval → `git commit`

**Step 5: Push**

- After successful commit, ask: "Push to remote? [Y/n]"
- If yes → `git push -u origin <branch>` (sets upstream on first push)

## Next Step

When the commit and push succeed:
  Prompt: "Create a PR? [Y/n]"
  If Y → create PR using `gh pr create`.
  If n → end.

When the commit fails (pre-commit hook failure, lint errors, test failures):
  Prompt: "Run `/design-log-implement <NNN>` to fix and retry? [Y/n]"
  If Y → invoke `/design-log-implement <NNN>`.
  If n → end.
