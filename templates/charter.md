# Charter — <NNN>-<slug>

[Status: draft | approved <YYYY-MM-DD> by <user>]
Design log: <path>   Project rules: <path to the project's rules file>

## Goal and done-when
- Goal: <one sentence>
- Done when: <evidence that someone other than the author checked: paths, scores, URLs>

## Allowed (no need to ask)
- Default: write inside this run folder; rewrite STATE.md; append results to the driving design log's §6 (Implementation Results).
- <e.g. branches and commits in own worktrees; PRs to feature branches; deploy previews>

## Forbidden (escalate, never do)
- <e.g. merge; production; other teams' code; messages to people>

## Caps
- AI spend: $<n> (estimate before any batch over $<m>)
- Time/token proxy: <e.g. ≤N subagent tasks, or stop at date>

## Reserved decisions (the user decides)
- <design topics the user keeps; everything else is the orchestrator's>

## Capabilities (preflight smoke-tests each)
| Capability | How to use it | Smoke test |
|---|---|---|
| <browser / login / CLI / MCP / eval> | <endpoint, profile, command; never the secret> | <one cheap call> |

## Parallel tasks and file ownership
| Task | Owns (paths) |
|---|---|
| <task> | <paths> |
Anything not listed runs serially.

## Temporary permission rules (removed at the end of the run)
- <exact command or path the host's permission system needs; no wildcards over shells>
