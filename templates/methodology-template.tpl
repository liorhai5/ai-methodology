# AI-Assisted Development Methodology

## Design Log Template

Location: `.ai/design-logs/NNN-semantic-name.md` (at project root)

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

