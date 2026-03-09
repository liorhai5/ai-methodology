# ai-methodology

A design-first AI development methodology, enforced across IDEs.

You edit the methodology and identity here. Running `init.sh` propagates hard-gate rules into your IDE and copies full docs to a stable machine path for agents to read on demand.

## Quick Start

```bash
# Clone the repo
git clone <repo-url> ~/Projects/ai-methodology
cd ~/Projects/ai-methodology

# Inject into Claude Code (writes ~/.claude/CLAUDE.md)
./init.sh --ide claude

# Inject into Cursor (copies rules to clipboard)
./init.sh --ide cursor
# Then paste into: Cursor > Settings > Rules > User Rules
```

After init, every new AI session in both IDEs will enforce the methodology gates automatically.

## The Methodology

Every non-trivial change follows a design-first pattern:

1. **Research** — understand the problem, check existing context
2. **Design** — write a design log with Socratic Q&A
3. **Approve** — human reviews and explicitly approves the design
4. **Implement** — code the approved design (no scope creep)
5. **Verify** — test against criteria from the design
6. **Record** — append results to the design log

### Mandatory Gates (injected into IDEs)

These five rules are enforced in every AI session:

1. Read before write — check `design-logs/` for existing context before any work.
2. Design before implement — no non-trivial code without an approved design log.
3. Human approval gate — explicit approval required before coding starts.
4. Design freeze — once implementation starts, only append results.
5. Design logs live at `design-logs/NNN-semantic-name.md` in each project root.

### Design Logs

The design log is the primary unit of work. One markdown file carries a feature from idea to completion.

- **Location:** `design-logs/NNN-semantic-name.md` (at project root of any project)
- **Status lifecycle:** `draft` → `approved` → `implemented` (or `abandoned`)
- **Sections:** Problem Statement → Q&A → Design → Verification → Results
- **Key rule:** design is frozen once coding starts — only append to Results

See `methodology.md` for the full template, structured design patterns, and review perspectives.

## Repository Layout

```
ai-methodology/
  soul.md              # identity, preferences, operating context
  methodology.md       # full workflow rules and design log template
  init.sh              # propagates rules to IDEs
  templates/
    claude.md.tpl      # hard-gate template for Claude
    cursor.txt.tpl     # hard-gate template for Cursor
  design-logs/         # decision history for this project
  README.md
```

## Machine Layout After Init

```
~/.ai-methodology/
  soul.md              # copy from repo (agents read on demand)
  methodology.md       # copy from repo (agents read on demand)

~/.claude/CLAUDE.md    # short hard-gate rules (written by init)
Cursor User Rules      # short hard-gate rules (pasted manually)
```

## Init Options

```bash
./init.sh --ide <claude|cursor>   # required: target IDE
./init.sh --ide claude --dry-run  # preview without writing
./init.sh --ide claude --no-backup # skip backup before write
```

## How It Works

- `soul.md` and `methodology.md` are the source of truth. Edit them here.
- `init.sh` copies both files to `~/.ai-methodology/` so agents can read them from any project.
- For Claude: init writes a short rules file to `~/.claude/CLAUDE.md`.
- For Cursor: init copies short rules to clipboard for pasting into Settings > Rules > User Rules (Cursor stores user rules in the cloud, not on disk).
- IDE globals contain only the 5 mandatory gates + references to `~/.ai-methodology/` for full docs.
- Re-run init after editing `soul.md` or `methodology.md` to propagate changes.
