# Orchestrate Workflow

Deliver a design log or topic through aligned subagents. Own the goal, decisions, integration and user conversation; choose execution details.

Read docs/rules.md, including **Run charter**. Resolve this skill's root for role/template paths.

## Start / resume

- **Root:** find the project containing `.ai/design-logs/` (cwd, parents, immediate children); use absolute paths. Run: `.ai/runs/<NNN>-<slug>/`.
- **Resume:** STATE first → relevant charter/contracts/tools/lessons → confirm volatile prerequisites/live ownership → current Next. Avoid raw-history replay.
- **Authority:** `templates/charter.md` records goal, acceptance, Allowed, Forbidden and Reserved. Cite conversation/artifact approvals; reformatting needs no new approval. Ask only for missing consequential authority: "Approve these additions? [Y/n/edit]". Silence is not approval.
- **Discover:** memory/docs/code → cheap proof in the intended environment → smallest missing adapter. Smoke prerequisites for the next action. Discover effective capacity, dispatch, permissions, context settings and job/output interfaces at the actual run root; record working bindings once. Change settings only within authority.

## Execution

| Keyword | Action |
|---|---|
| Align | Brief outcomes against the parent goal/acceptance, decisive uncertainty, settled interfaces and proven tools. Propagate steering; revise/stop stale work. |
| Delegate | Coherent outcomes: diagnosis → implementation → author checks can share one owner. Root may inspect/probe/execute bounded work while remaining available to coordinate. |
| Own | Assign files, worktrees/branches, browser sessions, previews, jobs, outputs and shared-record writers. Serialize overlaps or isolate and integrate. Never switch the user's main checkout. |
| Parallelize | Dispatch compatible independent work within discovered capacity. Cheap proof before risky dependent/expensive fan-out. Capacity is a ceiling, not a target. |
| Context | Fresh focused context for distinct outcomes/reviewers; reuse related corrections. Reset/handoff at natural boundaries. Relevant contracts/pointers, not the full transcript. |
| Brief | Use `templates/brief.md` and `roles/{researcher,worker,evaluator}.md`. Installed `orch-*` or supported generic dispatch must carry the same contract; missing wrappers do not require installation. |
| Wait | Prefer events; bounded same-job recovery/backoff when needed. No file watchers or unbounded polling loops. Retain accepted ID, owner, output/log and continuation. Timeout ≠ resubmit. Reconcile host completion with remaining jobs. |
| Reassess | Repeated hypothesis failure → new discriminating evidence/approach. Task IDs do not reset history. Avoid repeated valid checks and tooling work without acceptance progress. |
| Continue | After each return/checkpoint, dispatch remaining useful work. Idle agents or successful launches do not establish finished deliverables. |

Persist useful findings incrementally. Return concise outcome, evidence and continuation using `templates/result.md`; link detail.

## Verify

- **Checkpoint:** author checks first; independent verification at coherent deliverable/integration boundaries, proportionate to risk. Submit stable versions, inputs and output conditions; no evaluator per small operation.
- **Coverage:** representative actual end-to-end output early; relevant known-failure/negative control for critical checkers where appropriate. Technical success, quality and goal fulfillment may need different evidence. Unknown ≠ pass.
- **Review:** suitable methods within approved criteria; record coverage/limits and challenge consequential claims. New requirements are recommendations; existing correctness failures need ordinary in-scope correction.
- **Reuse:** relevant code, dependencies, inputs and execution conditions must remain valid. Contrary evidence invalidates affected claims; recheck affected coverage/integration after corrections.
- **Done:** direct evidence covers approved acceptance plus retained record. Distinguish source, target availability, actual output and goal acceptance where relevant. Author confidence or passing subsets cannot close the goal.

## Progress / attention

**Delivered · verified · uncertain · current · next · needs you.** Link inspectable artifacts; explain consequential decisions. Ground timing. Report milestones, blockers, approach/forecast changes; keep long work visible without narrating every task. Show useful samples before bookkeeping finishes.

**Ask:** missing intent/access/authority, Reserved decision, actual limit, or no credible authorized next step. Try relevant discovery first. State action, evidence, recommendation, what it unblocks and when needed; separate now/later/optional. Continue independent authorized work. No routine approval/veto suffix.

**Gates:** answer downstream prompts from Allowed; record consequential decisions under the charter. Never grant Forbidden/unlisted authority or lower acceptance. Honor steering without reverting unrelated work.

## Usage

- **Local:** focused context, coherent tasks, relevant lookup, valid evidence reuse, events and compaction. Honor model/quality preferences; select model/effort only when delegated and supported. No compulsory ledger, task quota or token census. Real approaching limits → resumable handoff, not dropped checks.
- **External, only when relevant:** reuse spending authorization; ask before unauthorized paid work. Orchestrator owns allowance/allocations, including accepted/in-flight commitments before dispatch. Workers execute allocations/report usage; further spend returns to you. Use existing gateway controls/aggregate telemetry; expose uncertainty preventing a cap being honored. No invented ceiling, unlimited permission or accounting infrastructure.

## State / knowledge

- **Current:** `templates/state.md` → readable goal/coverage, artifact, next, live owners/jobs, decisions/blockers and knowledge/evidence pointers. Rewrite at material transitions, before compaction/handoff. Resume instructions must agree; remove superseded live directions.
- **Tools:** canonical maintained project docs; run-specific adapters local. Purpose/limits · entry point · sanctioned access method (no secrets) · prerequisites/I/O · proven invocation/environment/version/date · recovery. Load relevant entries; refresh mutable facts.
- **Lessons:** situation → hypothesis/test → observation → choice/reason → evidence/applicability. Keep useful failures and unresolved findings. Workers propose; one assigned writer integrates canonical records.

## Compact / close

Under recorded retention authority, compact completed/superseded work at useful checkpoints and close:

- **Keep:** outcome/coverage, consequential decisions/experiments, canonical knowledge pointers, deliverables, selected success/failure proof, required inputs/baselines, retained-artifact/discarded-category index.
- **Remove:** authorized run-owned scratch, duplicates and obsolete outputs after useful claims/provenance are retained. Trace consumers; protect active/shared/user-authored assets, tools, baselines and restart dependencies. Uncertain → keep. Verify retained entry points/checks/links; hashes alone are not proof. Archiving everything is not compaction. Legacy/shared cleanup needs separate scope.
- **Place:** run-specific records in the run folder; reusable knowledge in existing project docs. `.ai/archive/` for selected closed history spanning designs; no parallel tracking hierarchy.
- **Finish:** verify whole-goal acceptance; final STATE and design §6 outcomes/evidence/limits/knowledge pointers. Remove only still-owned temporary permission changes. Remove run-created worktrees without force unless kept; dirty/untracked worktrees and branches stay.
- **Handoff:** current intent/coverage, live IDs/owners and next action. Never promise execution while idle. Report open items; resolve further review from existing authority, otherwise offer `/mtg code-review <NNN>` when relevant.

## Host bindings

Shared policy above; bind to actual capabilities.

| Host | Binding |
|---|---|
| Claude Code / Cursor | Optional `~/.claude/agents/` wrappers; supported read-only research. Inspect effective context settings; global changes affect other sessions. Claude background notifications require reconciliation with live state. Narrow local permissions where needed. |
| Codex | Optional `~/.codex/agents/` wrappers; supported agents/event waits or generic roles. Discover effective capacity/context at the run root; a settings file alone does not prove runtime behavior. |
| Other | Supported agents/jobs with absolute role/brief paths; missing capabilities → authorized alternative or explicit resumable gap. |
