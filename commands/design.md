# Design Log Workflow

Read docs/methodology-template.tpl for the template structure and review checklist.

## Input

- Use the topic/description provided after the command name.
- If none provided, extract the topic from the current conversation context.

## When to use this command

| Situation | Use |
|---|---|
| One file, no decisions, fits in a commit message | Nothing — just commit |
| The premise itself is unexamined — "should we even build this?" | `/mtg challenge` first, then design |
| You know what needs doing, scope is clear, no design decisions to resolve | `/mtg plan` |
| Uncertain, multiple decisions, requires research or Q&A | `/mtg design` (this command) |
| When in doubt | `/mtg design` |

## Workflow

Copy this checklist and track progress:

```
Design Log Progress:
- [ ] Step 1: Research — understand the problem and current state
- [ ] Step 2: Scaffold — create the design log file
- [ ] Step 3: Break down — decompose into decisions/questions
- [ ] Step 4: Deep dive — resolve each question with the user
- [ ] Step 5: Complete — design is ready for approval or abandonment
- [ ] Step 6: Plan — derive implementation plan from approved design
```

**Step 1: Research**

Investigate before writing anything:
- Read relevant code, configs, or architecture
- Check links provided by the user (docs, Slack, URLs)
- Scan `.ai/design-logs/` for related prior designs
- Summarize findings to the user before proceeding
- If research reveals the problem is well-understood and bounded with no open design decisions, suggest switching to `/mtg plan` instead

**Step 2: Scaffold**

- Find the next available NNN number in `.ai/design-logs/`
- Derive a short kebab-case semantic name from the problem
- Create `.ai/design-logs/NNN-<name>.md` with the template from methodology-template.tpl
- Set status: `draft`, created: today's date

**Fill missing context first.** Before writing the Problem Statement, if any of the following is unstated, ask the user (cooperative gap-fill — ask only what's genuinely missing, don't interrogate clear answers):

1. **Goals** — what outcome is expected? what problem does this solve?
2. **Prior art** — has anyone solved this before, even partially? (shapes the search space, prevents reinventing)
3. **Constraints** — what must not change? what tech / timelines / interfaces are fixed?
4. **Out of scope** — what is explicitly not included?
5. **Success criteria** — what does done look like? how will you know it worked?
6. **Known blockers** — anything known to be hard, risky, or uncertain?

- Fill in the Problem Statement — clearly answer "why now", synthesizing the gap-fill answers above.

**Step 3: Decision frontier**

Classify visible concerns in the Q&A section before turning them into a full
question list:

| State | Meaning | Action |
|---|---|---|
| `now` | Constrains the next architectural or product move | Resolve before approval. |
| `probe` | Needs research, a spike, prototype, or observation | Gather evidence, then reclassify. |
| `later` | Reversible detail | Do not pre-resolve. |
| `fog` | In-scope concern not yet precise enough to question | Keep visible; do not invent a question. |

Build only the current `now` frontier whose prerequisites are settled:
- Each `now` question is specific and answerable.
- Decision questions list ≥2 options with trade-offs; clarifications do not.
- Mark unresolved `now` questions as `[draft]` and order them by dependency.
- Present the current frontier, not a speculative complete questionnaire.
- Prompt: "Start with the current frontier? [Y/n]"

**Step 4: Deep dive** (repeat for the current frontier)

For each eligible `now` question:
1. Research as needed (read code, check docs, explore options)
2. Present options with trade-offs when relevant
3. Record the answer once the user confirms
4. Mark the question as `[decided]` in the Q&A section
5. Update the Design section with the decision and its trade-off
6. Recompute the frontier after the decision or evidence result
7. Prompt: "Next frontier item: Q<N> — <title>. Proceed? [Y/n]"

Independent low-risk defaults may be confirmed together when each can be
overridden. Dependent or consequential choices stay separate. New evidence that
changes an approved decision's basis reopens it, updates affected design content,
and re-runs approval when the design changes.

**Step 5: Complete**

When all questions are resolved:
- Ensure the Design section reflects all decisions and their trade-offs
- **Spec scope-lock** — the Design section must state, in this order: (1) explicit **out-of-scope** items *first*, (2) the **MVP cut** (smallest shippable slice), (3) a **failure / rollback path**.
- Fill in the Verification section with testable criteria
- **§4 "observable, not vibes" standard** — every done-criterion must be observable (a metric, a pass condition, a command output), not subjective. No "faster" / "better" / "cleaner" without a measurable bar.
- Present the full design for review
- Prompt: "Do you approve the design? [Y/n]"
- On approval, update the design log status to `approved`
- **Do NOT start implementation automatically.**

When the design is abandoned:
  End without suggestion.

**Step 6: Plan**

After the design is approved:
- Derive an implementation plan from §3 (Design) and §4 (Verification)
- Break into ordered tasks: implementation steps, test-writing, documentation check, verification pass
- Write the plan as a task table into §5 (Implementation Plan) of the design log
- Present for confirmation: "Implementation plan ready. Approve? [Y/n]"
- This is a separate gate — user approves the plan independently from the design
- **Do NOT start implementation automatically.**

## Existing-Project Framing (optional)

When the design topic modifies an existing system (not greenfield), the Problem Statement and Design sections should include three explicit buckets:

- **What exists today** — current state, with file:line citations or specific references
- **What should stay** — invariants and behaviors that must not change
- **What should improve** — concrete changes the design introduces

This prevents the common failure mode of designing in a vacuum and discovering the existing system contradicts the design.

## Next Step

When the design and plan are approved:
  Prompt: "Run `/mtg review <NNN>`? [Y/n]"
  If Y → invoke `/mtg review <NNN>`.
  If n → end.

When the design is abandoned:
  End without suggestion.
