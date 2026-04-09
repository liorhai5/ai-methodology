# ai-methodology

A design-first AI development methodology, packaged as an [AgentSkills](https://agentskills.io) skill.

## Install

**Recommended** — using [vercel-labs/skills](https://github.com/vercel-labs/skills):

```bash
npx skills add liorhai5/ai-methodology
```

This installs the skill to all your selected agents (Claude Code, Codex, and 50+ others). Use `npx skills update` to update, `npx skills remove mtg` to uninstall.

**Always-on rules (recommended):**

```bash
~/.agents/skills/mtg/scripts/install-rules.sh
```

This injects the 8 agent operating rules into your `CLAUDE.md` and `AGENTS.md` so they're active in every session — not just when you invoke `/mtg`.

**Manual alternative** (no npm required):

```bash
# Clone to canonical location
git clone https://github.com/liorhai5/ai-methodology ~/.agents/skills/mtg

# Symlink to the agents you use
ln -s ~/.agents/skills/mtg ~/.claude/skills/mtg    # Claude Code
ln -s ~/.agents/skills/mtg ~/.codex/skills/mtg     # Codex

# Always-on rules (recommended)
~/.agents/skills/mtg/scripts/install-rules.sh
```

**Migrating from ai-stack?** Remove stale `mtg_*` skill directories from `~/.claude/skills/`, `~/.agents/skills/`, and `~/.codex/skills/`.

## Usage

```
/mtg design [topic]          — Full Q&A design log for uncertain/multi-decision problems
/mtg plan [topic]            — Lightweight plan for bounded, known-scope tasks
/mtg deep-interview [topic]  — Ambiguity reduction for underspecified inputs
/mtg review [NNN]            — Review a design log from multiple perspectives
/mtg implement [NNN]         — Systematically implement an approved design log
/mtg code-review [NNN]       — Review implementation against its design log
/mtg status [NNN]            — Progress briefing on a design log
/mtg commit                  — Quality-gated commit workflow
/mtg research [topic]        — Harvest sources into files to survive context compaction
```

## Command Chains

```
/mtg design → /mtg review → /mtg implement → /mtg code-review → /mtg commit
/mtg plan   →               /mtg implement → /mtg code-review → /mtg commit

/mtg deep-interview → /mtg design or /mtg plan → (continues)
```

Use `/mtg design` when the problem is uncertain or has multiple decisions to resolve. Use `/mtg plan` when scope is clear and bounded. Use `/mtg deep-interview` when the input is too fuzzy to start either.

## The Methodology

### Agent Operating Rules

1. Suggest before change — never implement without explicit approval.
2. Options before action — present alternatives with trade-offs, let user choose.
3. Research before opinion — read code, context, memory before recommending.
4. Scope discipline — do exactly what was asked, no extras.
5. One gate at a time — separate approval for each decision point.
6. No auto-commit — do not commit, push, or create PRs unless explicitly asked.
7. Data aggregation — write findings to disk incrementally; never batch many reads in memory before writing.
8. Branch discipline — never commit directly to master/main. Create a feature branch first.

### Design Log Workflow

Every non-trivial change follows: Research → Design → Approve → Implement → Verify → Record.

1. Read before write — check `.ai/design-logs/` for existing context before any work.
2. Design before implement — no non-trivial code without an approved design log.
3. Human approval gate — explicit approval required before coding starts.
4. Design freeze — once implementation starts, only append results.
5. Design logs live at `.ai/design-logs/NNN-semantic-name.md` in each project root.

### Design Logs

The design log is the primary unit of work. One markdown file carries a feature from idea to completion.

- **Location:** `.ai/design-logs/NNN-semantic-name.md` (at project root of any project)
- **Status lifecycle:** `draft` → `approved` → `implemented` (or `abandoned`)
- **Sections:** Problem Statement → Q&A → Design → Verification → Plan → Results
- **Key rule:** design is frozen once coding starts — only append to Results

See `docs/methodology-template.tpl` for the full template, structured design patterns, and review perspectives.

## Repository Layout

```
ai-methodology/
  SKILL.md                       # entry point — routes /mtg commands
  commands/
    design.md                    # /mtg design
    plan.md                      # /mtg plan
    deep-interview.md            # /mtg deep-interview
    review.md                    # /mtg review
    implement.md                 # /mtg implement
    code-review.md               # /mtg code-review
    status.md                    # /mtg status
    commit.md                    # /mtg commit
    research.md                  # /mtg research
  docs/
    rules.md                     # agent operating rules + design log workflow
    methodology-template.tpl     # design log template + review checklist
  scripts/
    install-rules.sh             # optional: inject rules into CLAUDE.md / AGENTS.md
  design-logs/                   # gitignored — decision history for this project
  README.md
```
