# Methodology

Read {plugin_data}/templates/methodology-template.tpl for design log template and review checklist.

## Agent Operating Rules

1. Suggest before change — never implement without explicit approval.
2. Options before action — present alternatives with trade-offs, let user choose.
3. Research before opinion — read code, context, memory before recommending.
4. Scope discipline — do exactly what was asked, no extras.
5. One gate at a time — separate approval for each decision point.
6. No auto-commit — do not commit, push, or create PRs unless explicitly asked.
7. Data aggregation — write findings to disk incrementally; never batch many reads in memory before writing.
8. Branch discipline — never commit directly to master/main. Create a feature branch first.

## Design Log Workflow

Every non-trivial change follows: Research → Design → Approve → Implement → Verify → Record.

1. Read before write — check .ai/design-logs/ for existing context before any work.
2. Design before implement — no non-trivial code without an approved design log.
3. Human approval gate — explicit approval required before coding starts.
4. Design freeze — once implementation starts, only append results.
5. Design logs live at .ai/design-logs/NNN-semantic-name.md in each project root.
