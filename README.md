# ai-methodology

A design-first AI development methodology, packaged as an [AgentSkills](https://agentskills.io) skill.

## Install

**Recommended** — using [vercel-labs/skills](https://github.com/vercel-labs/skills):

```bash
npx skills add liorhai5/ai-methodology
```

When prompted, select **Claude Code** (and any other agents you use). The skill is installed to `~/.agents/skills/mtg/` and symlinked to each selected agent. Use `npx skills update` to update, `npx skills remove mtg` to uninstall.

**Always-on rules (recommended):**

```bash
~/.agents/skills/mtg/scripts/install-rules.sh
```

This injects the 8 agent operating rules into your `CLAUDE.md`, `AGENTS.md`, and `GEMINI.md` so they're active in every session — not just when you invoke `/mtg`.

**Manual alternative** (no npm required):

```bash
# Clone to canonical location
git clone https://github.com/liorhai5/ai-methodology ~/.agents/skills/mtg

# Symlink to the agents you use (relative paths)
cd ~/.claude/skills && ln -s ../../.agents/skills/mtg mtg    # Claude Code
cd ~/.codex/skills && ln -s ../../.agents/skills/mtg mtg     # Codex

# Always-on rules (recommended)
~/.agents/skills/mtg/scripts/install-rules.sh
```

## Usage

```
/mtg challenge [NNN|topic]   — Adversarially pressure-test whether the work should exist at all
/mtg design-map [destination]  — Map a known destination with a foggy route before design
/mtg research [topic]        — Harvest sources into files to survive context compaction
/mtg design [topic]          — Full Q&A design log for uncertain/multi-decision problems
/mtg plan [topic]            — Lightweight plan for bounded, known-scope tasks
/mtg review [NNN]            — Review a design log from multiple perspectives
/mtg implement [NNN]         — Systematically implement an approved design log
/mtg code-review [NNN]       — Review implementation against its design log
/mtg commit                  — Quality-gated commit workflow
/mtg investigate [topic]     — Root-cause debugging entry point (no fixes without root cause)
/mtg status [NNN]            — Progress briefing on a design log
```

## Command Chains

```
/mtg challenge → /mtg design → /mtg review → /mtg implement → /mtg code-review → /mtg commit
                 /mtg plan   →               /mtg implement → /mtg code-review → /mtg commit

/mtg investigate → fix (trivial) or → /mtg design (design flaw) → (continues)
```

Use `/mtg design-map` when the destination is known but the route is still foggy. Use `/mtg challenge` to pressure-test whether the work should exist before designing it. Use `/mtg design` when the problem is uncertain or has multiple decisions to resolve. Use `/mtg plan` when scope is clear and bounded. Use `/mtg investigate` to debug a defect to root cause before fixing.

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

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Licence

[MIT](LICENSE) © Lior Hai

## Repository Layout

```
ai-methodology/
  SKILL.md                       # entry point — routes /mtg commands
  commands/
    challenge.md                 # /mtg challenge
    design-map.md                # /mtg design-map
    research.md                  # /mtg research
    design.md                    # /mtg design
    plan.md                      # /mtg plan
    review.md                    # /mtg review
    implement.md                 # /mtg implement
    code-review.md               # /mtg code-review
    commit.md                    # /mtg commit
    investigate.md               # /mtg investigate
    status.md                    # /mtg status
  docs/
    rules.md                     # agent operating rules + design log workflow
    methodology-template.tpl     # design log template + review checklist
  scripts/
    install-rules.sh             # optional: inject rules into CLAUDE.md / AGENTS.md / GEMINI.md
  .ai/design-logs/               # gitignored — decision history for this project
  README.md
```
