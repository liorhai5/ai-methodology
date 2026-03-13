# AI-Assisted Development Methodology

## Design Log Template

Location: `design-logs/NNN-semantic-name.md` (at project root)

```
# [Title] — Design Log

[Status: draft | approved | implemented | abandoned]
[Created: YYYY-MM-DD]

## 1. Problem Statement
What problem are we solving? Why now?

## 2. Questions & Answers
Socratic method — ask questions, answer them, iterate.

## 3. Design
The solution. Only written after Q&A is sufficient.

## 4. Verification
How to test that the design works.

## 5. Implementation Plan
Ordered task table. Filled before implementation starts.

## 6. Implementation Results
Appended after coding. What was built, what changed.

## 7. Revision History
| Version | Date | Changes |
(Optional — used for complex, multi-session designs)
```

## Structured Design Pattern

For complex features, break the design into numbered topics:

1. Create a topic list (high-level breakdown)
2. Discuss and approve each topic one by one
3. Each topic contains specific numbered decisions
4. After all topics approved, implement in order

## Design Review Checklist

Before requesting approval, pressure-test the design from these angles:

- **Structure** — Are interfaces clear? Are dependencies appropriate? Is the scope well-bounded?
- **Simplicity** — Is anything over-engineered? Could we do less and still solve the problem?
- **Correctness** — Does it follow conventions? Are edge cases handled? Is the contract solid?
- **Resilience** — What are the failure modes? Is performance acceptable? What breaks under load?
- **Value** — Does it solve the stated problem? Is the user value clear and measurable?

## Agent Operating Rules

These apply to all work, not just design logs.

1. **Suggest before change** — Do not implement, write, or modify anything without explicit approval. Present the proposed change and wait for confirmation.
2. **Options before action** — When alternatives exist, present them with trade-offs. Let the user choose.
3. **Research before opinion** — Read relevant code, context, and memory before forming recommendations. Do not guess.
4. **Scope discipline** — Do exactly what was asked. No extras, no "improvements", no adjacent cleanup unless requested.
5. **One gate at a time** — Each decision point gets its own approval. Never bundle multiple approvals into one question.
6. **No auto-commit** — Do not commit, push, or create PRs unless explicitly asked. Implementation means writing code, not shipping it.

## Data Aggregation Rule
- DO: read one source item, write findings to disk immediately, then move to the next item.
- DON'T: batch many source reads in memory before writing.
- WHEN LARGE: split into shard files + one small manifest/index, and query shards/canonical files.
