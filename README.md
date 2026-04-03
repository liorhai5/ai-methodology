# ai-methodology

A design-first AI development methodology, deployed as an [ai-stack](../ai-stack) plugin.

## Quick Start

```bash
# Ensure ai-stack is set up and this plugin is in ~/.ai-stack/manifest.json:
# { "plugins": [{ "name": "mtg", "source": "~/Projects/Wix/Playgrounds/ai-methodology" }] }

ais install
```

After install, every new AI session will enforce the methodology gates automatically.

## The Methodology

### Agent Operating Rules (injected into IDEs)

1. Suggest before change — never implement without explicit approval.
2. Options before action — present alternatives with trade-offs, let user choose.
3. Research before opinion — read code, context, memory before recommending.
4. Scope discipline — do exactly what was asked, no extras.
5. One gate at a time — separate approval for each decision point.
6. No auto-commit — do not commit, push, or create PRs unless explicitly asked.
7. Data aggregation — write findings to disk incrementally; never batch many reads in memory before writing.
8. Branch discipline — never commit directly to master/main. Create a feature branch first.

### Design Log Workflow (injected into IDEs)

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

See `templates/methodology-template.tpl` for the full template, structured design patterns, and review perspectives.

## Skills (Slash Commands)

| Skill | Command | Purpose |
|-------|---------|---------|
| `deep-interview` | `/mtg:deep-interview` | Reduce ambiguity in underspecified inputs; scaffolds a design log |
| `design` | `/mtg:design` | Create a new design log with full Q&A deep-dive |
| `plan` | `/mtg:plan` | Create an approved design log for bounded, known-scope tasks |
| `review` | `/mtg:review` | Review a design log from multiple perspectives |
| `implement` | `/mtg:implement` | Systematically implement an approved design log |
| `code-review` | `/mtg:code-review` | Review implementation against its design log |
| `status` | `/mtg:status` | Progress briefing on a design log |
| `commit` | `/mtg:commit` | Quality-gated commit workflow with pre-commit checks |
| `research` | `/mtg:research` | Harvest sources into files to survive context compaction |

Skill chains:

```
design → review → implement → code-review → commit
plan   →          implement → code-review → commit

deep-interview → design → review → implement → code-review → commit
deep-interview → plan   →          implement → code-review → commit
```

Use `/mtg:design` when the problem is uncertain or has multiple decisions to resolve. Use `/mtg:plan` when scope is clear and bounded. Use `/mtg:deep-interview` when the input is too fuzzy to start either.

## Repository Layout

```
ai-methodology/
  ai-stack.plugin.json     # plugin manifest for ai-stack
  instructions/
    rules.md               # agent rules injected into IDEs
  skills/
    deep-interview/SKILL.md  # /mtg:deep-interview
    design/SKILL.md          # /mtg:design
    plan/SKILL.md            # /mtg:plan
    review/SKILL.md          # /mtg:review
    implement/SKILL.md       # /mtg:implement
    code-review/SKILL.md     # /mtg:code-review
    status/SKILL.md          # /mtg:status
    commit/SKILL.md          # /mtg:commit
    research/SKILL.md        # /mtg:research
  templates/
    methodology-template.tpl  # design log template and review checklist
  scripts/
    post-install.sh        # copies template to stable path
  .ai/design-logs/             # decision history for this project
```

## Machine Layout After Install

```
~/.ai-stack/
  mtg/
    methodology-template.tpl  # copied by postInstall (agents read on demand)

~/.claude/
  CLAUDE.md                # <!-- mtg:begin --> ... <!-- mtg:end -->
  skills/mtg_deep_interview/  # all 9 skills namespaced with mtg_
  skills/mtg_review/
  ...

~/.cursor/skills/mtg_*/    # same skills
~/.agents/skills/mtg_*/    # same skills (Codex)
~/.codex/AGENTS.md         # <!-- mtg:begin --> ... <!-- mtg:end -->
```

## How It Works

- This is an **ai-stack plugin**. Run `ais install` to deploy.
- `instructions/rules.md` is injected as a managed block (`<!-- mtg:begin/end -->`) into `CLAUDE.md` and `AGENTS.md`.
- Skills are copied to each IDE's skills directory with `mtg_` prefix and `mtg:` frontmatter.
- `scripts/post-install.sh` copies the template to `~/.ai-stack/mtg/` so agents can read it from any project.
- For Cursor: instructions are copied to clipboard (no global rules file exists).
- Re-run `ais install` after editing to propagate changes.
