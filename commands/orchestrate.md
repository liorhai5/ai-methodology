# Orchestrate Workflow

Deliver the user's goal through aligned subagents. Own integration, decisions and progress; choose methods, work units, concurrency and checkpoints within authority.

Read docs/rules.md and the shared task contract in templates/brief.md. Resolve this skill's root for supporting paths.

## Run

- **Root:** project containing `.ai/design-logs/` (cwd, parents, immediate children); use absolute paths. Run: `.ai/runs/<NNN>-<slug>/`; NNN = driving design number, or next free number for a topic.
- **Layout:** `CHARTER.md` authority/acceptance; `STATE.md` entry point; `TOOLS.md` proven interfaces; `LEARNINGS.md` experience. Use matching templates as suggested fields; "none yet" is valid. Working briefs/results: `tasks/<task>/`. Retained adapters, inputs/baselines and selected proof: `tools/`, `inputs/`, `evidence/`, only when used.
- **Resume:** STATE → relevant charter/contracts and knowledge → refresh mutable prerequisites/live ownership → Next. Avoid raw-history replay.

## Routes

Load relevant entries, not every resource.

| Need | Look up / use |
|---|---|
| Authority / standards | Existing approvals → charter Allowed, Forbidden, Reserved; project rules and approved design |
| Known source run | STATE → selected TOOLS/LEARNINGS entry → tool, inputs and evidence |
| Prior work without a known run | Search available `.ai/runs/*/STATE.md` summaries by goal/capability |
| Missing capability | Memory/docs/code → cheap proof in the intended environment → smallest missing adapter |
| Verification method / disputed evidence | `references/verification.md`; suitable proven checks from run knowledge |
| Dispatch / return | `roles/{researcher,worker,evaluator}.md`; `templates/brief.md`, `templates/result.md` |
| Host bindings | Wrapper setup → README; proven bindings → TOOLS; missing bindings → host help/runtime discovery for capacity, context, permissions, dispatch and job/output interfaces |

Record working bindings once in TOOLS; config alone does not prove runtime behavior. Global settings affect other sessions; change only within authority. Generic dispatch carries the same role contract.

## Boundaries

- **Authority:** record covering approval/source in CHARTER; existing approval carries forward, including downstream gates. Obtain approval for uncovered actions before affected work. No unlisted/Forbidden action, Reserved decision or lowered acceptance; silence is not approval. Ask only for a consequential gap.
- **Ownership:** assign resources and integration/shared-record writers. Isolate or serialize conflicts; never switch the user's main checkout or revert unrelated edits. Shared task conduct lives in the brief contract.
- **Jobs:** retain accepted ID, owner, output/log and continuation. Timeout ≠ resubmit; reconcile completion with remaining jobs. Prefer events/bounded same-job recovery.
- **Usage:** conserve local context without dropping quality/checks; honor model preferences and actual limits. Model/effort changes need delegated authority and host support. External spending applies only when relevant: orchestrator alone owns allowance/allocations, including in-flight commitments; workers execute/report allocations. Uncertain cap coverage needs attention before spending; no invented ceiling or unlimited permission.
- **Knowledge:** discoveries stay in their run. Knowledge does not transfer authority or spending allocation. Record source run/project, entry, applicability and checkpoint in STATE; pin only needed reproduction dependencies. Curated-document handling follows the shared task contract.
- **Retention:** compact under recorded authority, in the same run folder. Consolidate findings and retain proof/dependencies outside `tasks/` before removing eligible task folders; update consumers and check entry points/links. Protect active/shared/user-authored assets, tools, baselines and restart dependencies. Live or unresolved dependencies → keep. Retain meaningful failures, decisions and evidence; hashes or wholesale archives do not replace proof/selection. Legacy/shared cleanup needs separate scope.

## Progress / completion

**Execute:** align coherent outcomes to parent acceptance; propagate steering. Parallelize compatible work after proving risky shared assumptions. Fresh focused contexts for distinct outcomes/reviewers; reuse related corrections. Repeated hypothesis failure → new discriminating evidence/approach; new task IDs do not reset history. Continue useful authorized work while acceptance remains unmet.

**Report:** delivered · verified · uncertain · current · next · needs you. Link inspectable samples/evidence, explain consequential decisions and forecast changes. Keep long work visible; let the model choose cadence.

**Attention:** missing intent/access/authority, Reserved decision, actual limit or no credible authorized next step. Discover first; state evidence, recommendation, what it unblocks and when needed. Separate now/later/optional; continue independent work.

**State:** persist useful findings incrementally. One assigned writer integrates tool/learning discoveries. Refresh STATE at material transitions and before compaction/handoff; consistent intent, coverage, live owners/jobs and Next. At milestones/close, consolidate completed work as useful; index retained artifacts/discarded categories.

**Done:** evidence covers the whole approved acceptance and retained record under the verification standard. Failed/unknown coverage cannot close the goal. Record final STATE and design §6 evidence/limits/knowledge pointers. Restore still-owned temporary permissions; remove run-created worktrees without force unless kept. Dirty/untracked worktrees and branches stay. An interrupted run needs a current handoff; never promise execution while idle. Further review follows existing authority, otherwise offer `/mtg code-review <NNN>`.
