---
name: deep-interview
description: Structured ambiguity-reduction workflow for underspecified inputs — goals unclear, constraints missing, success criteria undefined, or the problem could be interpreted multiple ways. Produces a scaffolded design log ready for /mtg:design or /mtg:plan to continue.
argument-hint: "[fuzzy topic or leave empty to capture from conversation]"
disable-model-invocation: true
plugin_data: ../..
---

# Deep Interview Workflow

Read the template from {{plugin_data}}/templates/methodology-template.tpl.

## Input

- If `$ARGUMENTS` is provided, use it as the starting topic.
- If empty, extract the topic from the current conversation context.

## When to use this skill

| Situation | Use |
|---|---|
| Problem is clear enough to design or plan | Skip — go directly to `/mtg:design` or `/mtg:plan` |
| Goals are unclear, constraints missing, success criteria undefined | `/mtg:deep-interview` (this skill) |
| Request could be interpreted multiple ways | `/mtg:deep-interview` (this skill) |
| When in doubt whether design or plan is right | `/mtg:deep-interview` (this skill) |

## Workflow

Copy this checklist and track progress:

```
Deep Interview Progress:
- [ ] Step 1: Recognize — confirm this input qualifies for deep interview
- [ ] Step 2: Interview — ask structured questions to reduce ambiguity
- [ ] Step 3: Summarize — synthesize answers into a problem statement
- [ ] Step 4: Scaffold — create a design log with §1 filled and §2 seeded
- [ ] Step 5: Route — recommend design or plan based on remaining complexity
```

**Step 1: Recognize**

Confirm the input is underspecified enough to warrant a deep interview. If the problem is already clear, tell the user and recommend `/mtg:design` or `/mtg:plan` directly.

Signs this step is needed:
- Goals are stated in vague terms ("improve", "fix", "make it better")
- Constraints are not mentioned
- Success criteria are undefined or subjective
- The same request could lead to two very different implementations

**Step 2: Interview**

Ask structured questions to surface the missing information. Cover:

1. **Goals** — What outcome is expected? What problem does this solve for the user?
2. **Constraints** — What must not change? What technologies, timelines, or interfaces are fixed?
3. **Out of scope** — What is explicitly not included?
4. **Success criteria** — What does done look like? How will you know it worked?
5. **Known blockers** — Anything known to be hard, risky, or uncertain?

Ask only what is missing — do not interrogate a clear answer. Proceed to Step 3 when enough is known to write a problem statement.

**Step 3: Summarize**

Synthesize the interview answers into a clear problem statement:
- Restate goals in specific, actionable terms
- List constraints
- List explicit out-of-scope items
- List success criteria
- Flag any remaining unknowns as open questions

Present the summary to the user for confirmation before scaffolding.

**Step 4: Scaffold**

- Find the next available NNN number in `.ai/design-logs/`
- Derive a short kebab-case semantic name from the topic
- Create `.ai/design-logs/NNN-<name>.md` using the template from methodology-template.tpl
- Fill in:
  - §1 (Problem Statement) from the Step 3 synthesis
  - §2 (Q&A) — seed with open questions identified in Step 3, each marked `[draft]`
  - Status: `draft`
- Leave §3 (Design), §4 (Verification), §5 (Implementation Plan) empty — those are filled by the next skill in the chain

**Step 5: Route**

Based on the interview findings, recommend the next step:

- **Recommend `/mtg:design`** if: open questions remain, design decisions need resolving, scope is uncertain, or the problem has multiple valid approaches.
- **Recommend `/mtg:plan`** if: the interview resolved all ambiguity and the scope is now clear and bounded.

Prompt: "Continue with `/mtg:design <NNN>`? [Y/n]" (or `/mtg:plan` if appropriate)

## Output

A scaffolded design log at `.ai/design-logs/NNN-<name>.md`:
- §1 (Problem Statement) filled from interview findings
- §2 (Q&A) seeded with initial questions marked `[draft]`
- Status: `draft`

This is a standard design log. No new file type, no separate directory. The next skill in the chain continues from the same file.
