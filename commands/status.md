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

## Cleanup briefing

For one design, read its cleanup result and relevant referenced research INDEX/results and run STATE/results.
For `all` or the no-args listing, enumerate collection entry points: design logs, research topic INDEXes/legacy
standalone files, runs (including unassociated/legacy results), design maps, adopted codebase-research summaries
and referenced archive groups. Show other immediate `.ai` groups or missing usable records as not assessed.
Use existing summaries even without modern STATE/CHARTER files; no retrofit or relationship registry.

Read work/lifecycle and [recorded cleanup status](cleanup.md#recorded-status), not raw payloads. Summarize
active/intentionally retained material; list pending, deferred and not-assessed groups with reasons/actions,
grouping repeated unknowns. Pending needs recorded unfinished work or a concrete eligible group; a missing flag
is not proof of needed deletion. A complete result can retain all assets and remove zero bytes.

Report the last recorded scoped assessment, including known stale-result limits. State uninspected coverage;
leave unread groups not assessed. Approximate bytes are optional when already known/cheaply available. Do not
recursively inspect payloads, sizes, hashes or mtimes, repeat consumer verification, or treat RESULTS as cleanup proof.

When actionable, show a scoped `/mtg cleanup` as a briefing line alongside the existing next step. Only explicit
finish/no existing next action substitutes [cleanup's sole gate](cleanup.md#lifecycle-and-offers), after its concrete
plan is ready. Reporting grants no deletion authority; unchanged deferrals do not prompt again.

## Next Step Suggestion

After displaying the status briefing for a specific design log, suggest the next action based on these rules:

Interpret §6 by actual implementation activity. Cleanup-only flags/notes and "Not implemented" placeholders
do not advance the work step; use existing status, plan and results without another marker.

| Status | §5 (Plan) | §6 implementation activity | Suggestion |
|---|---|---|---|
| `draft` | — | — | "Run `/mtg design <NNN>`? [Y/n]" |
| `approved` | any | none (including cleanup-only results) | "Run `/mtg implement <NNN>`? [Y/n]" |
| `approved` | filled | implementation activity present | "Run `/mtg code-review <NNN>`? [Y/n]" |
| `implemented` | — | — | "Run `/mtg commit`? [Y/n]" |
| `abandoned` | — | — | No suggestion |

If Y → invoke the suggested command. If n → end.

## Summary table (for "all" or no-args listing)

```
| # / Group | Name | Work status / Progress | Cleanup (last recorded scope) | Next Step |
|-----------|------|------------------------|-------------------------------|-----------|
```
