# Contributing

This repository is a methodology, so it is held to its own standard: the
workflow described in the README is the one a change to it should follow.

## What lives where

- `SKILL.md` — the entry point. It routes `/mtg <command>` to a command file
  and should stay a router, not grow logic of its own.
- `commands/<name>.md` — one file per command. Self-contained: an agent reads
  exactly one of these plus `docs/rules.md`.
- `docs/rules.md` — the operating rules. This file is injected verbatim into
  users' `CLAUDE.md` / `AGENTS.md` / `GEMINI.md` by `scripts/install-rules.sh`,
  so treat every line as something that ships into other people's sessions.
- `docs/methodology-template.tpl` — the design log template.

## Adding or changing a command

1. Add `commands/<name>.md` and register it in the `SKILL.md` table **and** the
   `argument-hint` frontmatter. All three must agree or the command is
   undiscoverable.
2. Update the README's usage list and, if the command joins an existing
   sequence, the Command Chains section.
3. Write for an agent, not a human reader: state what to read, what to produce,
   and what gate to stop at. Prefer an explicit refusal over a vague nudge.

## Changing the rules

`docs/rules.md` is the highest-blast-radius file here — it is appended into
global agent configuration on every install. A change to it alters how agents
behave in unrelated projects. Say in the pull request why the new rule cannot
live in a command file instead.

## Verifying

`scripts/install-rules.sh` edits files in `$HOME`. Test it against a throwaway
home rather than your own:

```sh
FAKE=$(mktemp -d)
mkdir -p "$FAKE/.claude" && printf '# rules\n' > "$FAKE/.claude/CLAUDE.md"
HOME="$FAKE" ./scripts/install-rules.sh            # install
HOME="$FAKE" ./scripts/install-rules.sh            # again — must not duplicate
HOME="$FAKE" ./scripts/install-rules.sh --remove   # must leave the file as found
```

The script must be idempotent and must restore the original file exactly. It
targets macOS and Linux, so avoid non-portable shell — `sed -i` in particular
takes an argument on BSD and refuses one on GNU.

## Pull requests

One concern per pull request. Say what changed and how you verified it.
