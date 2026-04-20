# Commit Workflow

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
| Private methodology references (`.ai/` paths, design-log names, `NNN-` identifiers) in staged diff | Always | Warn |
| README and ARCHITECTURE reflects changes | Always | Warn |
| Lint script (`npm run lint` / Makefile lint) | Auto-detect | Warn |
| Test script (`npm test` / Makefile test) | Auto-detect | Warn |

- **Auto-detect**: check `package.json` scripts or `Makefile` targets for lint/test. Skip gracefully if none exist.
- **Content scan**: review staged diff for leaked secrets — API keys (`sk-`, `ghp_`, `xoxb-`, `AKIA`), tokens, private keys (`-----BEGIN .* PRIVATE KEY-----`), passwords in assignments, connection strings with credentials.
- **Private context scan**: review staged diff for references to internal methodology artifacts — `.ai/` paths, design-log filenames, `NNN-semantic-name` identifiers. These may be legitimate (e.g. documenting the convention in README) — warn and ask, do not auto-strip.
- On any **block**: stop, report, let user decide.
- On **warn**: report all warnings together, ask user to proceed or fix.

**Step 4: Message & Commit**

- Review the full diff of staged changes
- Draft a free-form commit message (short title + body). Message must stand on its own — describe the change, not the process that produced it.
- **Run the Redaction module** (fail-closed) on the proposed message. On match → halt, surface the match with context, user revises, re-scan. Do not proceed until the scan passes. See `## Redaction module` below.
- Present: diff summary + proposed message
- Prompt: "Commit with this message? [Y/n/edit]"
- On approval → `git commit`

**Step 5: Push**

- After successful commit, ask: "Push to remote? [Y/n]"
- If yes → `git push -u origin <branch>` (sets upstream on first push)

## Next Step

When the commit and push succeed, detect whether this branch has an open PR:

```
gh pr view --json state -q .state
```

If the result is `OPEN` → run **Stage B — Drift update** automatically (see section below). End after Stage B completes.

Otherwise (no PR found, detection call failed, or any other non-`OPEN` result), prompt: "Create a PR? [Y/n]"
  If Y → run **Stage A — PR body synthesis** (see section below), which handles body synthesis, approval, and `gh pr create`.
    Then prompt: "PR merged? Clean up branch? [Y/n]"
    If Y:
      1. `git checkout master` (or `main` — use whichever is the default branch)
      2. `git pull origin master`
      3. `git branch -d <branch>` — delete local branch (the one from Step 1)
      4. Confirm: "master is up to date. Branch <branch> removed."
    If n → end.
  If n → end.

When the commit fails (pre-commit hook failure, lint errors, test failures):
  Prompt: "Run `/mtg implement <NNN>` to fix and retry? [Y/n]"
  If Y → invoke `/mtg implement <NNN>`.
  If n → end.

## Tier signals

Used by Stage A and Stage B to select the PR body tier.

**Base detection** — resolve `<default-branch>` in this order, stop at the first one that succeeds:

1. `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`
2. `git symbolic-ref refs/remotes/origin/HEAD | sed 's|^refs/remotes/origin/||'`
3. Fallback: `main`, then `master`

Then compute `BASE = git merge-base HEAD <default-branch>`.

**Signals** (all diffs computed against `BASE`):

| Signal | Trips when |
|---|---|
| `design_log_present` | A design log was selected during Stage A step 1 (user did not choose `none`) |
| `files_changed` | `git diff --name-only $BASE..HEAD \| wc -l` ≥ 10 |
| `top_level_dirs` | Distinct first-segment paths from `git diff --name-only $BASE..HEAD` ≥ 3 |
| `new_dependency` | `git diff $BASE..HEAD --` on `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`, `pyproject.toml`, or `Gemfile` contains an added dependency line |
| `migration_file` | Any path in `git diff --name-only $BASE..HEAD` matches `**/migrations/**`, `**/schema.sql`, `*.migration.*`, or `**/db/migrate/**` |

**Tier selection**: deep if any signal trips; otherwise light. Selection is deterministic — re-running on the same diff produces the same tier. The LLM never judges "big change"; signals are mechanical.

**Override**: the user may override the proposed tier at the approval prompt via natural language ("use light", "go deep"). Override is **single-commit scope** — the next `/mtg commit` re-evaluates signals from scratch. No persistent state records the override.

## Template structures

Used by Stage A step 5 and Stage B step 6 to render the PR body.

**Light template** — section order fixed:

```
## Reason
## What changed
## Verification
```

**Deep template** — section order fixed; LLM slot-fills, never reorders:

```
## Reason
## What changed
## Decisions & rationale
- **<decision>** (reversible | one-way door)
  <2-4 sentences covering: what was considered, why this won, what it costs>
## Alternatives considered   # omitted when nothing meets the "seriously weighed" bar
## Verification
<details>                    # omitted when nothing qualifies
<summary>Additional metadata</summary>
...
</details>
```

**Decisions & rationale format**:

- Each entry starts with a **bolded decision line** followed by a reversibility marker in parentheses.
- Reversibility marker is exactly one of `(reversible)` or `(one-way door)`. No other values permitted. If the source design log does not specify, prompt the user per decision with the two-value choice.
- Beneath the decision line, a **2-4 sentence prose rationale** (not bullet fragments) covering: what was considered, why this won, what it costs.

**Alternatives considered — inclusion bar**:

Include only alternatives that were seriously weighed — satisfying all three:
- Has explicit pros/cons recorded
- Has a stated rationale for rejection
- Was compared directly against the chosen option

Drive-by mentions ("we could also do X") do not qualify. If no alternative meets the bar, **omit the section entirely** — no empty "Alternatives: N/A".

**Reason source**: synthesized from the selected design log's §1 (Problem Statement) when one is selected, otherwise prompted from the user. Mandatory in both tiers; synthesis halts if missing.

**Verification source**: from the selected design log's §4 when present; otherwise derived from the commit context (commit messages + diff summary).

## Redaction module

Single authority for privacy scrubbing across every write the skill produces. Invoked from:

- **Step 4 (Message & Commit)** on the proposed commit message before `git commit`.
- **Stage A step 6** on the synthesized PR body before `gh pr create`.
- **Stage B step 7** on the regenerated managed section before merge.

**Deny-list** (built at invocation time):

| Kind | Patterns |
|---|---|
| Static regex | `\bNNN-[a-z0-9-]+`, `\.ai/` |
| Static literal | `design log`, `implementation log`, internal `§N` section references |
| Dynamic literal | For each file in `.ai/design-logs/`, the filename stem with `.md` stripped |

**Match algorithm**: case-insensitive substring / regex match against the full proposed text.

**On match**: halt the containing write; never auto-strip. Surface:

```
REDACTION HALT — matched: "<match>"
Context: ...<~40 chars before>[MATCH]<~40 chars after>...
Please revise before continuing.
```

A match against an actual design log filename stem is always a hard halt with no bypass.

**Logging**: redactions are appended to the selected design log's §6 (Implementation Results). Never surfaced in the PR body or commit message.

## Fence convention

Used by the drift-update merge contract in Stage B.

Two regions in every PR body the skill produces:

- **Managed** — content between `<!-- mtg:body-begin -->` and `<!-- mtg:body-end -->`. Regenerated by the skill on each drift update.
- **Unmanaged** — anything outside the managed fence. Preserved byte-for-byte across updates.

Unmanaged content includes:
- `<!-- reviewer-notes -->` blocks
- Human-added `<details>` blocks
- User-added checklists
- Review-reply text pasted into the body
- Anything typed outside the fences

**First-drift migration**: if the current PR body has no fences (e.g., it was created outside this skill or predates fences), Stage B treats the entire existing body as unmanaged and appends the regenerated sections below a new managed fence. The user's legacy body is preserved verbatim.

**Body reflects HEAD, not journey** — no revision log is ever appended.

## Stage A — PR body synthesis

Triggered when the user approves `Create a PR? [Y/n]` after Step 5.

1. **Detect design log**:
   - Scan `.ai/design-logs/*.md` sorted by mtime, most-recent first.
   - If the directory is missing or empty → prompt: `Design log for this change? [path / none]`.
   - Otherwise → present top 3 as numbered suggestions with `other` and `none` options:
     ```
     Design log for this change?
       1. 017-commit-skill-pr-templates.md  (modified 2 min ago)
       2. 016-agentskills-migration.md      (modified 9 days ago)
       3. 015-stateless-deployment-migration.md  (modified 2 weeks ago)
       other — specify path or NNN
       none  — no design log applies
     Choice:
     ```
   - User picks a number, types a path/NNN, or selects `none`.
   - **No inference from conversation context** — selection is always explicit.

2. **Evaluate tier signals** — see `## Tier signals`.

3. **Propose tier**:
   ```
   Tier: <light|deep>. Signal: <first tripped>[, <more>]. Proceed? [Y / use light / use deep / edit]
   ```
   Accept natural-language override. Override is single-commit scope only.

4. **If deep chosen without design log** — emit banner, degrade to light, log suppression:
   ```
   DEEP TIER SUPPRESSED — no design log found.
   Signals tripped: <list>.
   Operating in light tier.
   ```
   Continue with light. Do not refuse; do not proceed as deep.

5. **Synthesize body** per the chosen tier (see `## Template structures`):
   - **Reason**: from the selected design log's §1 rewritten in self-contained prose (no identifiers); otherwise prompt the user.
   - **What changed**: 2-3 sentences derived from commit messages on the branch + diff summary.
   - **Decisions & rationale** (deep only): extract from design log §3. Format each as: bolded decision line + `(reversibility)` marker + 2-4 sentence prose rationale. If reversibility isn't explicit in the design log, prompt the user per decision with the two-value choice.
   - **Alternatives considered** (deep, conditional): include only alternatives meeting the "seriously weighed" bar (see `## Template structures`). Omit the section if none qualify.
   - **Verification**: from design log §4 when present; otherwise derive from commit context.
   - **`<details>`** (conditional): propose candidate items per the allow-list below. User approves each before inclusion. Omit the block if no items are approved.

   **`<details>` allow-list** — candidates for inclusion:
   - Benchmark / performance numbers
   - API or schema before/after diffs
   - Migration steps for downstream consumers
   - Exact verification commands run (with terse output)
   - Links to related PRs or commits within this repo
   - Breaking-change impact breakdown

   **`<details>` deny-list** — never include:
   - Design log excerpts (raw or paraphrased)
   - Chain-of-thought / decision history
   - Internal paths, identifiers, methodology vocabulary

6. **Run the Redaction module** on the full synthesized body (fail-closed). On match → halt, surface context, user revises, re-scan. See `## Redaction module`.

7. **Wrap the body in fences** (see `## Fence convention`):
   ```
   <!-- mtg:body-begin -->
   <synthesized body>
   <!-- mtg:body-end -->
   ```

8. **Present for approval**: render the full body and prompt `Create PR with this body? [Y/n/edit]`.

9. **Execute**: `gh pr create --title "<latest commit title>" --body "<body>"`.

   **On `gh` failure** (auth, install, network, other):
   - Surface the `gh` stderr output verbatim.
   - Print actionable next steps based on failure mode: `gh auth login`, install instructions (`brew install gh` / `https://cli.github.com`), or retry after resolving connectivity.
   - Print the full synthesized PR body so the user can paste it into the GitHub UI manually.
   - Commit + push remain intact. No silent failures; no automatic retries.

## Stage B — Drift update

Triggered automatically after Step 5 completes, if the current branch has an open PR. Detection:

```
gh pr view --json state -q .state
```

Proceed if the value is `OPEN`. If the call fails, apply the `gh` failure fallback (surface stderr, print next steps, skip drift update; commit + push remain intact).

1. **Fetch current PR body**: `gh pr view --json body -q .body`. On failure, apply `gh` failure fallback.

2. **Partition the body**: identify the `<!-- mtg:body-begin -->...<!-- mtg:body-end -->` region. Content inside is managed; everything outside is unmanaged.

3. **First-drift migration**: if no fence markers exist, treat the entire current body as unmanaged. The new managed region will be appended below it.

4. **Recompute tier** from current HEAD signals (see `## Tier signals`). This includes selecting a design log for the `design_log_present` signal — use the same selection flow as Stage A step 1 (filesystem scan, top 3 by mtime, user selects). Prior-commit overrides are **not** carried forward; the user is re-prompted this invocation if they want a non-default tier.

5. **Re-read design log** — if one was selected in step 4, read its contents for use in synthesis.

6. **Regenerate managed section** using the same synthesis logic as Stage A step 5 (Reason, What changed, Decisions & rationale, Alternatives, Verification, `<details>`). Handle the deep-without-log degrade and the `<details>` per-item approval the same way.

7. **Run the Redaction module** on the regenerated managed section (fail-closed). See `## Redaction module`.

8. **Merge**: preserve unmanaged content byte-for-byte; replace the managed region with the newly regenerated content, wrapped in `<!-- mtg:body-begin -->...<!-- mtg:body-end -->` fences.

9. **Diff-preview**: render a unified diff of current body → proposed body. This is the sole gate for all body changes, including tier transitions (deep → light content removal is visible here; no separate warning).

10. **Prompt**: `Update PR body? [Y/n/edit]`.

11. **Execute**: `gh pr edit --body "<merged>"`.
    **On `gh` failure**: surface `gh` stderr, print actionable next steps, print the full merged body for manual paste. Commit + push remain intact. No silent failures; no automatic retries.
