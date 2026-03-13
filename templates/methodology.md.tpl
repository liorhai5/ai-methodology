# Methodology

Read ~/.ai-methodology/soul.md at conversation start for identity and preferences.
Read ~/.ai-methodology/methodology.md for design log template and review checklist.

## Design-First Workflow

Every non-trivial change follows this pattern:

1. Research — understand the problem, check existing context
2. Design — write a design log with Q&A (Socratic method)
3. Approve — human reviews and approves the design
4. Implement — code the approved design (no scope creep)
5. Verify — test against criteria from the design
6. Record — append results to the design log

## Mandatory Gates

1. Read before write — check design-logs/ for existing context before any work.
2. Design before implement — no non-trivial code without an approved design log.
3. Human approval gate — explicit approval required before coding starts.
4. Design freeze — once implementation starts, only append results. Do not alter approved design.
5. Design logs live at design-logs/NNN-semantic-name.md in each project root.

## Agent Operating Rules

1. Suggest before change — never implement without explicit approval.
2. Options before action — present alternatives with trade-offs, let user choose.
3. Research before opinion — read code, context, memory before recommending.
4. Scope discipline — do exactly what was asked, no extras.
5. One gate at a time — separate approval for each decision point.
6. No auto-commit — do not commit, push, or create PRs unless explicitly asked.

## Design Log Status

- draft — being designed, Q&A ongoing
- approved — human approved, implementation can begin
- implemented — code written, results appended, design frozen
- abandoned — decided not to proceed, kept for history
