# ai-methodology

A design-first AI development methodology, enforced across IDEs.

You edit the methodology here. Running `init.sh` propagates hard-gate rules into your IDE and copies methodology docs to a stable machine path for agents to read on demand.

## Quick Start

```bash
# Clone the repo
git clone <repo-url> ~/Projects/ai-methodology
cd ~/Projects/ai-methodology

# Inject into all supported IDEs at once
./init.sh --ide all

# Or inject into a specific IDE
./init.sh --ide claude   # writes managed block to ~/.claude/CLAUDE.md
./init.sh --ide codex    # writes managed block to ~/.codex/AGENTS.md
./init.sh --ide cursor   # copies rules to clipboard
# Then paste into: Cursor > Settings > Rules > User Rules
```

After init, every new AI session will enforce the methodology gates automatically.

## The Methodology

### Agent Operating Rules (injected into IDEs)

General behavior rules for all AI work:

1. Suggest before change — never implement without explicit approval.
2. Options before action — present alternatives with trade-offs, let user choose.
3. Research before opinion — read code, context, memory before recommending.
4. Scope discipline — do exactly what was asked, no extras.
5. One gate at a time — separate approval for each decision point.
6. No auto-commit — do not commit, push, or create PRs unless explicitly asked.
7. Data aggregation — write findings to disk incrementally; never batch many reads in memory before writing.

### Design Log Workflow (injected into IDEs)

Every non-trivial change follows: Research → Design → Approve → Implement → Verify → Record.

1. Read before write — check `design-logs/` for existing context before any work.
2. Design before implement — no non-trivial code without an approved design log.
3. Human approval gate — explicit approval required before coding starts.
4. Design freeze — once implementation starts, only append results.
5. Design logs live at `design-logs/NNN-semantic-name.md` in each project root.

### Design Logs

The design log is the primary unit of work. One markdown file carries a feature from idea to completion.

- **Location:** `design-logs/NNN-semantic-name.md` (at project root of any project)
- **Status lifecycle:** `draft` → `approved` → `implemented` (or `abandoned`)
- **Sections:** Problem Statement → Q&A → Design → Verification → Plan → Results
- **Key rule:** design is frozen once coding starts — only append to Results

See `methodology.md` for the full template, structured design patterns, and review perspectives.

## Repository Layout

```
ai-methodology/
  methodology.md       # full workflow rules and design log template
  init.sh              # propagates rules and skills to IDEs
  templates/
    methodology.md.tpl # shared hard-gate template (all IDEs)
  skills/
    design-log/          # /design-log slash command
    design-log-implement/# /design-log-implement slash command
    design-log-implementation-review/ # /design-log-implementation-review slash command
    design-log-review/   # /design-log-review slash command
    design-log-status/   # /design-log-status slash command
    research-log/        # /research-log slash command
  design-logs/         # decision history for this project
  README.md
```

## Machine Layout After Init

```
~/.ai-methodology/
  methodology.md       # copy from repo (agents read on demand)

~/.claude/CLAUDE.md    # methodology in managed block (written by init)
~/.codex/AGENTS.md     # methodology in managed block (written by init)
Cursor User Rules      # methodology text (pasted manually from clipboard)

~/.claude/skills/{design-log*,research-log}/SKILL.md   # methodology skills
~/.cursor/skills/{design-log*,research-log}/SKILL.md   # methodology skills
~/.agents/skills/{design-log*,research-log}/SKILL.md   # methodology skills (Codex)
```

## Managed Blocks

For file-based IDEs (Claude, Codex), init.sh uses managed blocks:

```markdown
<!-- ai-methodology:begin -->
(methodology content — owned by init.sh)
<!-- ai-methodology:end -->
```

- Content inside markers is replaced on each run.
- Content outside markers is preserved — safe for other tools or manual additions.
- First run on an existing file without markers prepends the block, preserving existing content.

## Skills (Slash Commands)

init.sh deploys methodology skills as `SKILL.md` files to each IDE's skills directory:

| Skill | Command | Purpose |
|-------|---------|---------|
| `design-log` | `/design-log` | Create a new design log from the template |
| `design-log-implement` | `/design-log-implement` | Systematically implement an approved design log |
| `design-log-implementation-review` | `/design-log-implementation-review` | Review implementation against its design log |
| `design-log-review` | `/design-log-review` | Review a design log from multiple perspectives |
| `design-log-status` | `/design-log-status` | Progress briefing on a design log |
| `research-log` | `/research-log` | Harvest sources into files to survive context compaction |

Skills are user-triggered (not auto-invoked). Target paths per IDE:

- Claude: `~/.claude/skills/<name>/SKILL.md`
- Cursor: `~/.cursor/skills/<name>/SKILL.md`
- Codex: `~/.agents/skills/<name>/SKILL.md`

## Init Options

```bash
./init.sh --ide <claude|cursor|codex|all>  # required: target IDE
./init.sh --ide claude --dry-run           # preview without writing
./init.sh --ide claude --no-backup         # skip backup before write
```

## How It Works

- `methodology.md` is the source of truth. Edit it here.
- `init.sh` copies it to `~/.ai-methodology/` so agents can read it from any project.
- For Claude: init writes a managed block to `~/.claude/CLAUDE.md`.
- For Codex: init writes a managed block to `~/.codex/AGENTS.md`.
- For Cursor: init copies rules to clipboard for pasting into Settings > Rules > User Rules.
- IDE globals contain the methodology gates + references to `~/.ai-methodology/` for full docs.
- Re-run init after editing `methodology.md` to propagate changes.
