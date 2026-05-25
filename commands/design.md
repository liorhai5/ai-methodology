# Design Log Workflow

Read docs/methodology-template.tpl for the template structure and review checklist.

## Input

- Use the topic/description provided after the command name.
- If none provided, extract the topic from the current conversation context.

## When to use this command

| Situation | Use |
|---|---|
| One file, no decisions, fits in a commit message | Nothing — just commit |
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
- Fill in the Problem Statement — clearly answer "why now"

**Step 3: Break down**

Decompose the problem into numbered decisions/questions in the Q&A section:
- Each question should be specific and answerable
- Decision questions list ≥2 options with trade-offs. Clarifications don't.
- Mark each as `[draft]`
- Order by dependency — foundational decisions first
- Present the breakdown to the user for review before proceeding
- Prompt: "Start deep dive? [Y/n]"

**Step 4: Deep dive** (repeat for each question)

For each question from the breakdown:
1. Research as needed (read code, check docs, explore options)
2. Present options with trade-offs when relevant
3. Record the answer once the user confirms
4. Mark the question as `[decided]` in the Q&A section
5. Update the Design section with the decision and its trade-off
6. Prompt: "Next: Q<N> — <title>. Proceed? [Y/n]"

**Step 5: Complete**

When all questions are resolved:
- Ensure the Design section reflects all decisions and their trade-offs
- Fill in the Verification section with testable criteria
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
