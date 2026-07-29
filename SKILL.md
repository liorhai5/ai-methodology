---
name: mtg
description: Design-first AI development methodology — structured workflows for design, planning, implementation, review, and commit. Governs non-trivial changes through design logs with approval gates.
argument-hint: "goal | challenge | design-map | research | design | plan | review | implement | code-review | commit | investigate | status"
---

# Methodology

Read docs/rules.md — these rules govern all work in this session.

## Commands

Based on $ARGUMENTS, read and follow the relevant command file:

| Command | File | Purpose |
|---|---|---|
| goal [expected result] | commands/goal.md | Navigate a broad objective through existing MTG flows until its DoD is evidenced |
| challenge [NNN\|topic] | commands/challenge.md | Adversarially pressure-test whether the work should exist at all |
| design-map [destination] | commands/design-map.md | Map a known destination with a foggy route before normal design |
| research [topic] | commands/research.md | Harvest sources into files to survive context compaction |
| design [topic] | commands/design.md | Full Q&A design log for uncertain/multi-decision problems |
| plan [topic] | commands/plan.md | Lightweight plan for bounded, known-scope tasks |
| review [NNN] | commands/review.md | Review a design log from multiple perspectives |
| implement [NNN] | commands/implement.md | Systematically implement an approved design log |
| code-review [NNN] | commands/code-review.md | Review implementation against its design log |
| commit | commands/commit.md | Quality-gated commit workflow |
| investigate [topic] | commands/investigate.md | Root-cause debugging entry point — no fixes without root cause first |
| status [NNN] | commands/status.md | Progress briefing on a design log |

If no command matches, show this table and ask what the user needs.
