---
name: design-log-status
description: Progress briefing on a design log — what's decided, what's open, and what's the next step. Use when picking up a design in a new session or checking where things stand.
argument-hint: "[design log path or number, or leave empty to select]"
disable-model-invocation: true
---

# Design Status Briefing

## Target

- If `$ARGUMENTS` names a design log (path or NNN number), use it.
- If empty, scan `design-logs/` and list all with their status. Ask which to brief on, or if the user says "all", present the summary table only.

## For a specific design log

Read the design log and report:

**Status**: draft / approved / implemented / abandoned

**Progress**:
- Questions resolved vs. total (count `[decided]` vs `[draft]` markers)
- Which sections are filled in (Problem Statement, Q&A, Design, Verification, Results)

**Key decisions so far**: Bullet list of resolved questions and their answers.

**Open items**: Remaining `[draft]` questions or empty sections.

**Next step**: One clear action, e.g.:
- "3 questions remain — continue deep dive with Q4"
- "All questions resolved — ready for /design-review"
- "Approved — ready for implementation"
- "Implemented — append results to close out"

**Blockers**: External dependencies, missing information, or references that need follow-up.

## Next Step Suggestion

After displaying the status briefing for a specific design log, suggest the next action based on these rules:

| Status | §5 (Plan) | §6 (Results) | Suggestion |
|---|---|---|---|
| `draft` | — | — | "Run `/design-log <NNN>`? [Y/n]" |
| `approved` | any | empty or absent | "Run `/design-log-implement <NNN>`? [Y/n]" |
| `approved` | filled | has content | "Run `/design-log-implement-review <NNN>`? [Y/n]" |
| `implemented` | — | — | "Run `/commit-log`? [Y/n]" |
| `abandoned` | — | — | No suggestion |

If Y → invoke the suggested skill. If n → end.

## Summary table (for "all" or no-args listing)

```
| # | Name | Status | Progress | Next Step |
|---|------|--------|----------|-----------|
```
