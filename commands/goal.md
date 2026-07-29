# Goal Orchestration

`/mtg goal <expected result>` keeps a broad expected result moving through the
right MTG disciplines until there is direct evidence that it is met. It is a
top-level navigator, not a project-management system or implementation permit.

A host may manage its own native goal state. MTG does not mirror that state or
write a separate goal artifact; design, research, plan, and review artifacts
remain the project record.

## Loop

1. Clarify the expected result, constraints, and observable success condition
   only when they would change the route or scope.
2. Read the current conversation, repository, and existing MTG artifacts.
3. Name and invoke one next discipline, with the evidence or uncertainty that
   makes it the next move.
4. Reassess the resulting evidence before choosing another move. Respect the
   invoked discipline's normal gates; goal never grants blanket authority.
5. Finish only when the expected result has direct evidence. Activity, an agent
   report, or an unrelated green check is not completion evidence.

## Next-route guide

Use judgment; these are guides, not a closed state machine:

| Current blocker | Usually route to |
|---|---|
| Root cause is unknown | `/mtg investigate` before proposing a fix |
| Premise is unexamined | `/mtg challenge` |
| Destination is known but route is foggy | `/mtg design-map` |
| Material design decisions remain | `/mtg design` |
| Scope and path are known and bounded | `/mtg plan` |
| Approved scope is ready to execute | `/mtg implement`, then `/mtg code-review` |

If a fresh session loses goal framing, invoke `/mtg goal <expected result>`
again and recover from the normal MTG artifacts; do not create a second status
system.

## Parallelism

Goal alone coordinates parallel work. Independent read-only research or review
may fan out. Writes stay serial by default.

When concurrent writes are genuinely useful, state a compact coordination table
in the active conversation and obtain one explicit confirmation before dispatch:

| Outcome | Change surface | Verification | Integration check |
|---|---|---|---|

The change surface must include owned paths/symbols and shared generated,
configuration, test, contract, or integration surfaces. Run only disjoint
writes, name the integration check, and verify the combined result afterward.
Otherwise serialize the work. Leaf commands remain unaware of this orchestration.
