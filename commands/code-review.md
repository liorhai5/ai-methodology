# Implementation Review Workflow

Read docs/methodology-template.tpl for the review checklist.

## Target

- Use the design log number or path provided after the command name.
- If a design log is in the current conversation context, use that.
- If none provided, list design logs with `implemented` status and ask which to review.

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

Cite specific evidence (file:line, design section, command output, comparable pattern) where it exists. Vague findings ("it looks wrong") aren't actionable.

### Finding discipline (applies to every actionable finding)

**Pre-emit verification gate (FP killer).** Before any finding is promoted into the actionable list, quote the specific motivating line — `file:line` + verbatim text:
- If the claim is "field X doesn't exist on model Y", quote the lines of class Y.
- If the claim is "`dict.get()` might return None", quote the dict initialization.
- **If you cannot quote the motivating line(s), the finding is unverified → force confidence to 4-5 (suppressed).** Do not work around this by inventing speculative confidence 7+ — that defeats the gate.
- *Framework-meta nudge:* when the symbol is framework-generated (Django `Meta`, Rails `has_many`/`scope`, SQLAlchemy `relationship`, TypeORM/Sequelize/Prisma), quote the meta-construct that creates the symbol, not the class body. The verification is "I read the source that creates this symbol", not "I grep'd for the name and didn't find it."

**Confidence calibration rubric** (1-10, governs whether a finding is shown):

| Score | Meaning | Display |
|---|---|---|
| 9-10 | Verified by reading specific code; concrete bug/exploit demonstrated | Show normally |
| 7-8 | High-confidence pattern match; very likely correct | Show normally |
| 5-6 | Moderate; could be a false positive | Show with caveat ("verify") |
| 3-4 | Low; suspicious but may be fine | **Suppress — count only** |
| 1-2 | Speculation | **Omit unless severity = Critical** |

**Severity** ∈ {Critical, Major, Minor, Nit}. Critical = anything that trips a Hard Gate or breaks a public contract / data integrity / security. The 4 existing Hard Gates map to Critical.

**Do-not-flag (suppressions) list** — keep reviewer noise down; do not raise findings for:
- Harmless redundancy that aids readability.
- "Add a comment here" suggestions.
- Pure style nits already enforced by a linter.

Assess each of the 10 dimensions:

**Design fidelity**
- Does the code implement all of §3?
- Is every design decision reflected in a corresponding code change?
- Are there requirements in the design that have no matching implementation?

**Completeness**
- Were all §5 plan tasks addressed?
- Are any tasks left `pending` without explanation?
- Were skipped tasks justified?
- **Enum & value completeness:** before flagging a completeness gap, **READ** (not grep) every consumer outside the diff — switch/filter/display sites of a new enum/status/tier. The gap is only real if a consumer is genuinely missing a case.

**Deviation detection (scope-drift, operationalized)**
- Extract deliverables from the **§5 task table** and acceptance criteria from **§4 Verification**; cross-reference against the diff. Tag each item:
  - **DONE** — deliverable present in the diff.
  - **MISSING** — §5 task / §4 criterion with no matching diff.
  - **CREEP** — change in the diff not traceable to §5 or §4.
- Honesty rule: *"code that handles a deliverable is not the deliverable."*
- Are all deviations recorded in §6? Were files changed but not listed in §6, or listed but not changed?

**Test quality**
- Are tests meaningful and cover product requirements?
- Were existing tests changed without good reason?
- Do tests verify behavior, not just exercise code?
- **Score each new/changed test:** ★ smoke / ★★ happy-path / ★★★ behavior+edge+error.
- **Tag recommended coverage:** `[→E2E]` (3+ component flows, mock-hides-failure, auth/payment/destruction) or `[→EVAL]` (LLM/prompt/tool-def changes).

**Regression check**
- Does existing behavior break?
- Are there unintended side effects?
- Were existing interfaces or contracts preserved?
- **Regression IRON RULE:** if the diff broke previously-working code, a regression test is added as a **Critical** actionable item — **no gate, no skip.**

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

**Boundary & blast radius**
- Are all callers/consumers of the changed code identified?
- Do the changes preserve public contracts (types, schemas, wire protocols)?
- Are there cross-layer edits (e.g., UI calling DB directly)? If so, are they justified?
- For any destructive change (delete, migration, force-push, schema drop), is rollback documented?
- When the change has callers/consumers, include an explicit blast-radius statement — files/modules/consumers touched, layered by impact.

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
| Boundary & blast radius  | pass    | ...   |
| Security                 | pass    | ...   |
```

Dimension verdicts stay plain `pass` / `concern` / `fail` with prose notes (a dimension isn't a single finding).

If any dimension is concern or fail, add a numbered list of specific actionable items. **Every actionable item is emitted in the two-layer finding format:**

```
[Severity] (confidence: N/10) file:line — description
```

- Severity ∈ {Critical, Major, Minor, Nit}; order the list **Critical-first**.
- Confidence is governed by the Phase-3 rubric; items at confidence ≤4 are suppressed from this list.
- After the list, emit a single suppression count line (no appendix):

  `N low-confidence findings suppressed (conf ≤4; Critical-severity speculation shown above).`

## Hard Gates

If the implementation crosses any of these lines without explicit user approval, raise as a **fail** regardless of other dimensions:

- **Public contract change** — type/schema/wire-protocol modifications that affect external consumers
- **Cross-layer edit** — UI layer reaching into data layer, service reaching into UI, or similar architecture violations
- **Destructive action** — file deletes, table drops, force-pushes, irreversible migrations
- **Large blast radius** — change touches >10 files or >3 modules without commensurate design log scope

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
  Prompt: "Run `/mtg commit`? [Y/n]"
  If Y → invoke `/mtg commit`.
  If n → end.

When the review finds issues (Needs fixes / Needs rework):
  After applying updates to the design log (or if user skipped updates):
  Prompt: "Run `/mtg implement <NNN>` to fix issues per §6? [Y/n]"
  If Y → invoke `/mtg implement <NNN>`.
  If n → end.
