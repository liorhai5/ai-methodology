---
name: plan
description: Create a lightweight structured plan for bounded, known-scope tasks — no Q&A loop, no research phase. Produces an approved design log ready for implementation. Use when you know what needs doing and scope is clear.
argument-hint: "[problem description or leave empty to capture from conversation]"
disable-model-invocation: true
plugin_data: ../..
---

# Plan Workflow

Read the template from {{plugin_data}}/templates/methodology-template.tpl.

## Input

- If `$ARGUMENTS` is provided, use it as the problem statement.
- If empty, extract the topic from the current conversation context.

## When to use this skill

| Situation | Use |
|---|---|
| One file, no decisions, fits in a commit message | Nothing — just commit |
| You know what needs doing, scope is clear, no design decisions to resolve | `/mtg:plan` (this skill) |
| Uncertain, multiple decisions, requires research or Q&A | `/mtg:design` |
| When in doubt | `/mtg:design` |

## Workflow

Copy this checklist and track progress:

```
Plan Progress:
- [ ] Step 1: Problem — capture problem statement and constraints
- [ ] Step 2: Design — describe what will be done (no Q&A loop)
- [ ] Step 3: Verification — define done criteria
- [ ] Step 4: Plan — write implementation task table
- [ ] Step 5: Approve — gate on user approval
```

**Step 1: Problem**

Capture the problem statement from `$ARGUMENTS` or conversation context:
- What is being changed and why?
- What are the constraints?
- What is explicitly out of scope?

Summarize findings to the user. If you discover the problem has open design decisions or unclear scope, recommend switching to `/mtg:design` instead.

**Step 2: Design**

Describe what will be done — no Q&A loop, no research phase:
- What changes will be made?
- Which files, systems, or interfaces are touched?
- What stays the same?

This is a direct description, not a discovery process. If you find yourself needing to resolve decisions, stop and switch to `/mtg:design`.

**Step 3: Verification**

Define done criteria as testable statements:
- What must be true after implementation?
- What behavior must remain unchanged?
- How will correctness be confirmed?

**Step 4: Plan**

Write the implementation task table for §5 of the design log:

```
| # | Task | Status | Notes |
|---|------|--------|-------|
```

- Break into ordered, atomic tasks
- Include a documentation check task
- Include a verification pass as final task
- Status values: `pending`, `done`, `skipped`

**Step 5: Scaffold and Approve**

- Find the next available NNN number in `.ai/design-logs/`
- Derive a short kebab-case semantic name from the problem
- Create `.ai/design-logs/NNN-<name>.md` using the template from methodology-template.tpl
- Fill in:
  - §1 (Problem Statement) from Step 1
  - §2 (Q&A) — leave empty (no Q&A for plan-produced logs)
  - §3 (Design) from Step 2
  - §4 (Verification) from Step 3
  - §5 (Implementation Plan) from Step 4
  - Status: `draft`
- Present the full plan to the user for review
- Prompt: "Approve this plan? [Y/n]"
- On approval: update status to `approved`
- **Do NOT start implementation automatically.**

## Next Step

When the plan is approved:
  Prompt: "Run `/mtg:implement <NNN>`? [Y/n]"
  If Y → invoke `/mtg:implement <NNN>`.
  If n → end.

When the plan is abandoned:
  End without suggestion.
