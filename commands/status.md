# Design Status Briefing

Read docs/methodology-template.tpl for the template structure.

## Target

- Use the design log number or path provided after the command name.
- If none provided, scan `.ai/design-logs/` and list all with their status. Ask which to brief on, or if the user says "all", present the summary table only.

## For a specific design log

Read the design log and report:

**Status**: draft / approved / implemented / abandoned

**Progress**:
- Questions resolved vs. total (count `[decided]` vs `[draft]` markers)
- Which sections are filled in (Problem Statement, Q&A, Design, Verification, Results)

**Key decisions so far**: Bullet list of resolved questions and their answers.

**Open items**: Remaining `[draft]` questions or empty sections.

**Code metrics** (when the log has implementation activity):
- Report **logical SLOC over raw LOC** — count meaningful statements, not blank/comment/boilerplate lines. AI inflates raw LOC; logical SLOC is the honest size signal.
- Flag a **fix-ratio >50%** (commits/edits that fix prior commits in the same effort) as a **review-gap signal** — it means changes are shipping under-reviewed and bouncing back.

**Next step**: One clear action, e.g.:
- "3 questions remain — continue deep dive with Q4"
- "All questions resolved — ready for review"
- "Approved — ready for implementation"
- "Implemented — append results to close out"

**Blockers**: External dependencies, missing information, or references that need follow-up.

## Next Step Suggestion

After displaying the status briefing for a specific design log, suggest the next action based on these rules:

| Status | §5 (Plan) | §6 (Results) | Suggestion |
|---|---|---|---|
| `draft` | — | — | "Run `/mtg design <NNN>`? [Y/n]" |
| `approved` | any | empty or absent | "Run `/mtg implement <NNN>`? [Y/n]" |
| `approved` | filled | has content | "Run `/mtg code-review <NNN>`? [Y/n]" |
| `implemented` | — | — | "Run `/mtg commit`? [Y/n]" |
| `abandoned` | — | — | No suggestion |

If Y → invoke the suggested command. If n → end.

## Summary table (for "all" or no-args listing)

```
| # | Name | Status | Progress | Next Step |
|---|------|--------|----------|-----------|
```
