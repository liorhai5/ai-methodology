---
name: research-log
description: Investigate a topic by harvesting sources into files — read one source, write findings to disk, move to next. Survives context compaction. Use when multiple sources need to be read and synthesized (Slack, docs, web, PRs, code).
argument-hint: "[research question or topic]"
disable-model-invocation: true
---

# Research Workflow

Follows the Data Aggregation Rule from [~/.ai-methodology/methodology-template.tpl](~/.ai-methodology/methodology-template.tpl):
read one source, write findings to disk immediately, then move to the next.

## Input

- If `$ARGUMENTS` is provided, use it as the research question.
- If empty, extract the topic from the current conversation context.

## File naming

Research files live in `research-logs/` at the project root, one folder per research topic:

```
research-logs/
  001-system-complexity/       # folder per research topic
    01-current-architecture.md # shard files (one per source)
    02-hook-fragility.md
    INDEX.md                   # manifest linking all shards
  002-auth-middleware/
    01-legal-requirements.md
    INDEX.md
```

- Folder: `NNN-short-name/` — `NNN` = research number (001, 002, ...), short kebab-case name
- Shards inside: `NN-source-name.md` — `NN` = shard number (01, 02, ...)
- `INDEX.md` per folder — manifest with research question, source list, and synthesis
- Find the next available NNN by scanning `research-logs/`

## Shard format

Each shard file has a simple metadata header:

```markdown
# <Title>

- **Source**: <URL, Slack thread, file path, or description>
- **Type**: <web | slack | doc | PR | code | other>
- **Accessed**: <date>

## Findings

<Harvested content relevant to the research question.
Focus on facts, decisions, patterns — not raw dumps.
Extract what matters for answering the research question.>
```

## Workflow

**Step 1: Define**

- Clarify the research question
- Derive a short kebab-case topic name for file naming

**Step 2: Seed sources**

- List initial sources from the user's links, instructions, or search locations
- Create `research-logs/NNN-short-name/INDEX.md` with the research question and seed sources
- Present the plan to the user
- Prompt: "Seed sources identified. Proceed with harvesting? [Y/n]"

The source list is a starting point — new sources will be discovered during harvesting.

**Step 3: Harvest** (systematic, one source at a time, with discovery)

For each source:
1. Read/fetch the source
2. Extract findings relevant to the research question
3. Identify links or references within the source that are relevant and need following
4. Write to `research-logs/NNN-short-name/NN-source-name.md`
5. Update `INDEX.md` with the shard link and a one-line summary
6. Add any discovered links to the harvest queue in the INDEX
7. Move to next source immediately — do not accumulate in memory

Discovery rules:
- Follow links that are relevant to the research question — skip tangential ones
- Go up to 2 levels deep from seed sources unless the user instructs otherwise
- Mark each entry in the INDEX as `[seed]` or `[discovered]`

Do NOT stop between sources for confirmation. Harvest all sources systematically.
If a source is unreachable, note it in the index and move on.

**Step 4: Synthesize**

After all sources are harvested:
1. Read the shard files (not memory — re-read from disk)
2. Answer the original research question based on the gathered findings
3. Update `INDEX.md` with a synthesis section

## Key rules

- **Write after each source** — this is the core rule. The LLM context will compact; the files won't.
- **Re-fetch on deep dive** — if the user wants to discuss a specific source in depth, go back to the original (URL, Slack thread, etc.), not just the shard. The shard is a summary, not a replacement.
- **Shards are focused** — extract what's relevant to the research question, not a raw dump of the source.
