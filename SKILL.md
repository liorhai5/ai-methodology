---
name: mtg
description: Design-first AI development methodology — structured workflows for design, planning, implementation, review, and commit. Governs non-trivial changes through design logs with approval gates.
argument-hint: "design | plan | deep-interview | review | implement | code-review | status | commit | research"
---

# Methodology

Read docs/rules.md — these rules govern all work in this session.

## Commands

Based on $ARGUMENTS, read and follow the relevant command file:

| Command | File | Purpose |
|---|---|---|
| design [topic] | commands/design.md | Full Q&A design log for uncertain/multi-decision problems |
| plan [topic] | commands/plan.md | Lightweight plan for bounded, known-scope tasks |
| deep-interview [topic] | commands/deep-interview.md | Ambiguity reduction for underspecified inputs |
| review [NNN] | commands/review.md | Review a design log from multiple perspectives |
| implement [NNN] | commands/implement.md | Systematically implement an approved design log |
| code-review [NNN] | commands/code-review.md | Review implementation against its design log |
| status [NNN] | commands/status.md | Progress briefing on a design log |
| commit | commands/commit.md | Quality-gated commit workflow |
| research [topic] | commands/research.md | Harvest sources into files to survive context compaction |

If no command matches, show this table and ask what the user needs.
