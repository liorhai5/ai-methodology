# Orchestrate Workflow

Drive one piece of work (a design log or topic) through delegated subagents with clean context. You are the **orchestrator**: the user's single conversational session. You decide, brief, synthesize and report; subagents do the multi-step work.

Read docs/rules.md, including the **Run charter** rule.

## Target

- **Resolve the project root first**: the directory that holds `.ai/design-logs/`. Search the current directory, then its parents, then its immediate children (the IDE may open a parent folder). Use absolute paths from then on.
- Use the design log number or topic given after the command name.
- The run directory is `.ai/runs/<NNN>-<slug>/` in the project root, where NNN is the driving design log (or the next free number for a topic). Create it if it is missing.
- If `STATE.md` exists there, read it first and resume from its **Next** line.

## Phase 1: Charter

1. If `CHARTER.md` is missing, draft it from the mtg skill's `templates/charter.md`, using the design log, the project's rules file, and the conversation.
2. Present it once, with the permission rules it would add shown as a diff. Prompt: "Approve this charter? [Y/n/edit]"
3. Once it is approved, the charter is the run's authorization (docs/rules.md, Run charter). Do not ask again for anything it allows.

## Phase 2: Preflight

1. For each capability in the charter, run one cheap smoke test (browser endpoint, logins, CLIs, MCP auth, eval or test commands). Record ✓/✗ in STATE.
2. Context limit: make sure the host compacts well before its maximum (target ≈250k tokens). If it doesn't already, ask the user to set it (see Host notes). Do not change settings yourself.
3. Add the charter's temporary permission rules to the project's local settings. They must be narrow: exact commands or paths only.
4. If anything is ✗ or missing, send **one** batched ask before starting. Never put credentials in files or briefs; a brief says how to obtain access, never the secret itself.

## Phase 3: Run

For each task:

1. **Delegate rule.** Anything needing more than ~3 tool calls (exploring, editing, running, evaluating) goes to a subagent. You only read briefs, replies and STATE. Every tool call you make costs your full, growing context.
2. **Brief.** Write `tasks/T<nnn>-<role>-<slug>/brief.md` from the mtg skill's `templates/brief.md`. Include absolute paths, the charter section the task runs under, a pre-registered expectation and falsifier for experiments, the done-when, and the cost cap.
3. **Spawn** the role with only the brief path:

   | Role | Installed agent | Hosts without the agents |
   |---|---|---|
   | researcher | the `orch-researcher` agent | "act as roles/researcher.md for brief <path>" |
   | worker | the `orch-worker` agent | "act as roles/worker.md for brief <path>" |
   | evaluator | the `orch-evaluator` agent | "act as roles/evaluator.md for brief <path>" |
   | explorer | the host's built-in read-only search agent | the same |

   The `orch-*` agents are installed from the skill's `agents/` folder (see README and Host notes). If they're missing, use the right-hand column, or ask the user to install them.

   Run subagents in the background. At most **2** run in parallel, and only tasks listed as parallel in the charter, each owning its listed files. Everything else runs serially.
4. **Long jobs** (more than ~2 minutes) run as background processes that write `tasks/<id>/status` (running/done/failed plus the log path) and check `.ai/runs/<run>/STOP` before each unit. If the host notifies you when a background process exits, wait for that; otherwise end the turn and say what to check. **Never poll.**
5. **Result.** The subagent writes `result.md` (the mtg skill's `templates/result.md`) and replies in ≤30 lines. Open `result.md` only when the reply isn't enough to decide.
6. **Done** is graded by evidence that someone other than the author checked. A worker's claim is not done until an evaluator (or a check named in the done-when) confirms it.
7. **STATE.** Rewrite `STATE.md` (the mtg skill's `templates/state.md`, ≤5 KB) after every result. Only you write it.
8. **Update the user** after every result:
   ```
   Done: <task> — <one-line result> (<evidence path>)
   Running: <task> (<ETA>) | none
   Needs you: <batched items, each with a recommendation and [Y/n]> | none
   Decided under charter: <decision> (§x) — veto? | none
   ```
   Optional: if the host supports push notifications, send one when "Needs you" is not empty.
9. End the turn when nothing is running, or when everything left waits on the user.

## Gates and authority

- **Gate prompts.** When an mtg command or a host action asks for confirmation (`[Y/n]`, `Proceed?`, `Approve?`, `Push…?`, `Create a PR?`), answer from the charter: **yes** if the action is in Allowed, **escalate** if it is Forbidden or unlisted. Never match on a prompt's exact wording.
- **Decisions.** Design and plan topics that are not in Reserved are yours. Record "decided by orchestrator under CHARTER §x" and your reasoning in the design log, and list them under "Decided under charter" in your next update.
- **Veto.** If the user vetoes a decision, work out what depends on it, revert it, and record the veto in the design log.

## Escalation (the only mid-run stops)

1. An action outside the charter, or a Reserved decision.
2. A cap is reached.
3. A clarification is needed (ambiguous goal, conflicting evidence).
4. Two tries without movement on the same hypothesis.

Batch escalations into "Needs you", update STATE, and keep any independent work running.

## Bans

- Watchers or monitors on files; `sleep` or polling loops.
- Cross-session messages; `/goal` check-ins (each is a full turn at your current context).
- More than 2 parallel subagents unless the user raises the limit in the charter.
- Doing multi-step tool work yourself.
- Append-only coordination logs. State lives in STATE.md; history lives in the design log and in results.

**Where files go:** each run's folder holds its live state and anything about that run alone. `.ai/archive/` holds only closed history that spans more than one design log. Don't add other folders to the `.ai/` root.

## End of run

1. The done-when is verified (step 6). Write the final STATE and append results to the design log's §6.
2. Remove the temporary permission rules, or list them for the user to keep. If the user changed the context limit for this run, remind them to restore it (see Host notes).
3. Remove the git worktrees this run's briefs created, unless the charter or the user keeps them. Use `git worktree remove` without force. A worktree with uncommitted or untracked work is never removed: list it for the user instead. Branches are kept.
4. Report the outcome, the evidence paths, and anything left open.

## Host notes

Host-specific details. The workflow above stays the same everywhere.

- **Claude Code**
  - Context limit: `/autocompact 250k`. It writes the **global** `~/.claude/settings.json`, so it also affects the user's other sessions; restore it with `/autocompact auto`. A per-project alternative is `"autoCompactWindow": 250000` in the project's `.claude/settings.local.json`.
  - Agents: `orch-*` in `~/.claude/agents/`; the explorer is the built-in `Explore` agent.
  - Background `Bash` and background subagents notify you when they exit.
  - Permission rules go in `.claude/settings.local.json`, e.g. `Bash(yarn test:*)`.
- **Cursor:** reads the `orch-*` agents from `~/.claude/agents/`.
- **Codex:** `orch-*` agents in `~/.codex/agents/`. The compaction setting is not verified here; ask the user rather than guess.
- **Other hosts** (e.g. Gemini): no wrappers. Use the "Hosts without the agents" column.

## Next Step

When the run completes:
  Prompt: "Run `/mtg code-review <NNN>`? [Y/n]"
  If Y → invoke `/mtg code-review <NNN>`.
  If n → end.
