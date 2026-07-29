# Design Map Workflow

`/mtg design-map <destination>` maps a known destination whose route is still
foggy. It is a durable pre-design artifact: enough structure to drive discovery,
but never a disguised ticket list, implementation plan, or authorization to
build.

## When to use

| Situation | Use |
|---|---|
| Destination is known, but route or decision order is unclear | `/mtg design-map` |
| Material decisions are already precise | `/mtg design` |
| Scope and path are known and bounded | `/mtg plan` |

## Artifact

Design maps have their own sequence, independent from design logs. Find the
next available `NNN` under `.ai/design-maps/`, then write
`.ai/design-maps/NNN-<name>.md`:

```md
# <Destination> — Design Map

## Destination
## Decision frontier
| Decision | State | Evidence or dependency needed | Next move |

## Fog
## Decisions so far
## Evidence
## Out of scope
## Exit to design
```

Use `now`, `probe`, or `later` in the frontier. Keep genuinely imprecise
concerns as prose in **Fog** rather than inventing a decision or task.

## Mapping loop

1. State the destination, constraints, and out-of-scope boundary.
2. Add only actionable uncertainty to the frontier. For each item, name the
   evidence/dependency that would advance it and its smallest next move.
3. Work the nearest `now` or `probe` item. A `probe` may route to research,
   inspection, or another evidence-gathering discipline; record what comes back
   in **Evidence**.
4. Reclassify the frontier and record settled choices in **Decisions so far**.
   Keep unresolved but still-imprecise concerns in **Fog**.
5. Repeat until the blocking frontier is clear, then use **Exit to design** to
   state what `/mtg design` should decide next and which evidence it inherits.

The map never contains tasks, owners, estimates, sequencing, tickets, or an
implementation plan. Its output is clarified decisions and evidence; normal
`/mtg design` owns the resulting design and approval flow.
