---
name: code-review
description: Review an implementation against its design log — verify design fidelity, test quality, deviation detection, documentation alignment, and more. Use after implementation to independently verify that what was built matches what was designed.
argument-hint: "[design log path or number, or leave empty to select]"
disable-model-invocation: true
plugin_data: ../..
---

# Implementation Review Workflow

Read the review checklist from {{plugin_data}}/templates/methodology-template.tpl.

## Target

- If `$ARGUMENTS` names a design log (path or NNN number), use it.
- If a design log is in the current conversation context, use that.
- If empty, list design logs with `implemented` status and ask which to review.

## Workflow

Copy this checklist and track progress:

```
Implementation Review Progress:
- [ ] Phase 1: Load — read design log and check pre-conditions
- [ ] Phase 2: Gather evidence — read files and git diff
- [ ] Phase 3: Evaluate — assess each dimension
- [ ] Phase 4: Verdict — present findings and recommendation
- [ ] Phase 5: Update Design Log — present findings for approval, then update
```

**Phase 1: Load**

- Read the target design log fully
- Check status:
  - If `implemented` → proceed
  - If any other status → warn and wait for explicit user approval before proceeding
- Read relevant code referenced by §3 (Design) and files listed in §6 (Implementation Results)

**Phase 2: Gather evidence**

- Read all files listed in §6 (Implementation Results)
- Run `git diff` to identify all changed files on the implementation branch
- Cross-reference: flag files in git diff not listed in §6, and files in §6 not found in diff
- Read §5 (Implementation Plan) task table for completion status

**Phase 3: Evaluate**

Assess each of the 9 dimensions:

**Design fidelity**
- Does the code implement all of §3?
- Is every design decision reflected in a corresponding code change?
- Are there requirements in the design that have no matching implementation?

**Completeness**
- Were all §5 plan tasks addressed?
- Are any tasks left `pending` without explanation?
- Were skipped tasks justified?

**Deviation detection**
- Are there code changes beyond the design scope?
- Are all deviations recorded in §6?
- Were files changed but not listed in §6, or listed but not changed?

**Test quality**
- Are tests meaningful and cover product requirements?
- Were existing tests changed without good reason?
- Do tests verify behavior, not just exercise code?

**Regression check**
- Does existing behavior break?
- Are there unintended side effects?
- Were existing interfaces or contracts preserved?

**Verification criteria**
- Does each criterion from §4 actually pass?
- Run or check each one and report the result.

**Results accuracy**
- Does §6 accurately reflect what was built?
- Are file lists correct and complete?
- Are deviations documented?

**Documentation alignment**
- Do architecture.md, README, and guides reflect the changes?
- Are new features or workflows documented where applicable?
- Are removed or changed features updated in docs?

**Security**
- Are there hardcoded secrets, API keys, or tokens in changed code?
- Is user input validated before use? (SQL, command, path injection risks)
- Is output escaped where rendered? (XSS)
- Is authentication/authorization enforced on any new paths or interfaces?
- Is sensitive data absent from logs and error messages?

Rate each dimension: **pass**, **concern**, or **fail** with specific notes.

**Phase 4: Verdict**

Present findings as a verdict table:

```
| Dimension                | Rating  | Notes |
|--------------------------|---------|-------|
| Design fidelity          | pass    | ...   |
| Completeness             | pass    | ...   |
| Deviation detection      | concern | ...   |
| Test quality             | pass    | ...   |
| Regression check         | pass    | ...   |
| Verification criteria    | pass    | ...   |
| Results accuracy         | fail    | ...   |
| Documentation alignment  | pass    | ...   |
| Security                 | pass    | ...   |
```

If any dimension is concern or fail, add a numbered list of specific actionable items to fix.

Then recommend one of:
- **Verified** — all pass, implementation matches the design
- **Needs fixes** — concerns or fails with clear actionable items
- **Needs rework** — fundamental divergence from the design

**Phase 5: Update Design Log**

If the review found concerns or fails:

1. **Present suggested changes** — show the user what you propose to append to §6 (Implementation Results):
   - A `### Review Findings (YYYY-MM-DD)` subsection with the verdict table and actionable items
2. **User approval gate** — prompt: "Apply these findings to the design log? [Y/n/edit]"
   - If Y → append findings to §6
   - If edit → incorporate user modifications, then append
   - If n → skip updates, leave design log unchanged

If the review passed cleanly (all dimensions pass):
  Prompt: "Append verification report to the design log? [Y/n]"
  If yes → append the verdict table to §6 as `### Review Verified (YYYY-MM-DD)`

## Next Step

When the review passes (Verified):
  Prompt: "Run `/mtg:commit`? [Y/n]"
  If Y → invoke `/mtg:commit`.
  If n → end.

When the review finds issues (Needs fixes / Needs rework):
  After applying updates to the design log (or if user skipped updates):
  Prompt: "Run `/mtg:implement <NNN>` to fix issues per §6? [Y/n]"
  If Y → invoke `/mtg:implement <NNN>`.
  If n → end.
