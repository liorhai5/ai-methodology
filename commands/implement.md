# Design Log Implementation Workflow

Read docs/methodology-template.tpl for the template structure and review checklist.

## Target

- Use the design log number or path provided after the command name.
- If a design log is in the current conversation context, use that.
- If none provided, list design logs with `approved` status and ask which to implement.

## Workflow

**Phase 1: Load**

- Read the target design log fully
- Check status:
  - If `approved` → proceed
  - If any other status → warn and wait for explicit user approval before proceeding
- Read relevant code, configs, or architecture referenced by the design
- Summarize what will be implemented

**Phase 2: Plan**

- If §5 (Implementation Plan) is already filled, present it and ask: "Proceed with this plan? [Y/n]"
- If §5 is empty, derive tasks from §3 (Design) and §4 (Verification):
  - Implementation tasks from the Design section
  - Test-writing tasks if tests are specified in the design
  - Documentation check task (always included)
  - Verification pass as final task
- Write the plan as a task table into §5 of the design log:
  ```
  | # | Task | Status | Notes |
  |---|------|--------|-------|
  ```
- Status values: `pending`, `done`, `skipped`
- Present the plan for confirmation: "Implementation plan ready. Proceed? [Y/n]"

**Phase 3: Execute**

Work through the plan table sequentially. For each task:

1. **Read before write** — inspect relevant source files and understand the current code before changing anything
2. **Implement the change** — follow the design exactly, preserve existing code style and conventions
2.5. **Scope lock** — if the change touches a file or symbol not listed in the design's §3 or §5 → STOP, ask whether to expand scope or skip
2.6. **Blast-radius gate** — if a single task's change would touch **>5 files**, STOP and pick: **proceed** (scope is genuinely that wide — say why), **split** (break the task into smaller increments), or **rethink** (the approach may be wrong). Do not silently fan out across the repo.
3. **Self-audit** the change:
   - Does it match the design? No features added, no scope creep
   - Is it the simplest solution? Could we do less and still satisfy the requirement?
   - Are there obvious regressions? Does existing behavior break?
   - If tests exist, do they still pass and are added tests meaningful?
4. **Update the task status** to `done` in §5 of the design log
5. Add notes for any deviations from the original design
6. If a task is not applicable, mark `skipped` with reason in notes

This command executes its plan serially: complete one task, update the table,
then move to the next. Any parallel orchestration belongs outside this command.

**Phase 4: Verify**

Self-review the full implementation. Cite specific evidence (file:line, command output, comparable pattern) where it exists:

- **Design fidelity** — all requirements addressed, nothing added beyond the design
- **Test coverage** — tests cover the changes
- **Regression test** — if the change fixes a defect, the regression test must **fail without** the fix and **pass with** it (confirm both directions; a test that passes either way proves nothing)
- **Regressions** — no obvious regressions in existing behavior
- **Simplicity** — no over-engineering, no unnecessary abstractions
- **Code style** — consistent with existing codebase conventions

Report pass/fail for each.
- If all pass → proceed to Phase 5
- If any fail → stop, report failures, keep status as `approved`, let user decide next steps

**Phase 5: Record**

- Auto-append to §6 (Implementation Results):
  - Files changed
  - Deviations from plan (if any)
  - Verification outcomes
- Update design log status to `implemented`

## Next Step

When implementation completes successfully (all verification passes):
  Prompt: "Run `/mtg code-review <NNN>`? [Y/n]"
  If Y → invoke `/mtg code-review <NNN>`.
  If n → end.

When implementation fails or is blocked:
  Write findings to §6 of the design log before suggesting next step.
  Prompt:
    "Next:
      1. `/mtg design <NNN>` — revisit design (see findings in §6)
      2. Skip
    [1/2]"
  If 1 → invoke `/mtg design <NNN>`.
  If 2 → end.
