# Artifact Cleanup Workflow

Read docs/rules.md. Keep useful outcomes and dependencies; remove eligible working bulk within authority.

## Target

`/mtg cleanup [design-number | research-path | run-path | all]`

- Explicit arguments win. Otherwise resolve the project/target from conversation, then read its existing
  records and references. Ask only for a missing selection.
- Omission never implies `all`; project-wide intent must be explicit or established by context. `all`
  inventories the current project's `.ai`, not other projects.
- Show the resolved project, target and actual action paths before execution. External references are
  dependencies; acting there needs explicitly included scope.

## Plan and authority

1. Inventory the scoped filesystem directly, including ignored files, without traversing symlinks. Read
   relevant design results, research INDEX/results and run summaries; inspect actual readers, live
   owners/jobs and preservation instructions.
2. Group material as **keep / compact-or-sanitize / remove / unknown**. Cover research, orchestration and
   other MTG captures, exports, logs, caches, outputs and archives whose ownership/use is established.
   Retain unrelated, active, shared, user-authored and uncertain material.
3. Show a short plan: retained outputs and consumers, proposed changes/removals, research closure if
   applicable, and approximate byte effect when cheaply available (otherwise unknown). Archiving/quarantine
   alone does not reduce bytes.
4. Reuse covering scoped approval, including charter retention authority. Otherwise ask once for this
   concrete plan: "Apply this cleanup? [Y/n]". No per-file gates. Selection or a generic finish request
   alone grants no blanket deletion authority.
5. If postponed, record `deferred` with scope/reason in the existing work record where writable. Report it
   without repeating the offer on unchanged state.

## Execute and recover

- Use an existing design §6, research INDEX/result or run STATE/result for the scoped outcome. Legacy
  records need no modern-file retrofit; if no reliable retained record is available, retain the affected
  group and report the limit.
- Under the approved plan, persist `partial` with scope and retained/pending groups **before the first
  cleanup mutation**. If this write fails, do not start mutations.
- Preserve deliverables/assets, consequential outcomes, decisions, lessons, reusable tools and selected
  necessary evidence. Condense other attempts into useful findings/reasons; reproducing every experiment is
  not required.
- Consolidate retained findings before removing their sources. Superseded scratch needs
  owner/purpose/reference and live/shared dependency checks. Sanitized evidence or changed retained
  outputs/inputs need actual affected read/display/resume or selected replay checks, preserving necessary
  fields, provenance, coverage and unresolved findings. Reuse valid evidence; do not replay unchanged
  consumers for every group.
- Verify each dependency-complete retained group before removing its originals. Failed/unknown checks retain
  originals and stop dependent actions; independent authorized groups may continue. Recheck changed inputs
  and live/shared ownership before removal.
- Before regular removal, check resolved paths and parent directories against approved canonical scope.
  Never traverse symlinked directories. Unlink a symlink entry only when explicitly authorized; leave its
  target untouched. Outside paths require separately included authority.
- Checkpoint actual completed, pending and failed groups after each group, before further mutations using
  that record. A checkpoint-write failure stops those mutations; durable `partial` remains. Report
  unsuccessful removals and actual remaining paths.
- On interruption/resume, inspect actual files and recorded progress; revalidate changed/unverified groups.
  Preserve unverified sources. Completed deletion has no promised rollback; no blanket backup or separate
  journal.
- Finish with retained outputs, actual scoped byte reduction (or unknown) and outstanding reasons/actions.
  Mark `complete` only after final checks/accounting with no unfinished groups in the claimed scope;
  otherwise `partial`. Keeping everything deliberately can complete with zero reduction.
- Honor project ignore/tracking policy; do not change ignores, force-add records or require commits.

## Lifecycle and offers

- Offer at explicit design finish/abandonment or confirmed post-merge finish. `implemented`, declining the
  next command, or a finished run with remaining parent work does not close a design. Keep existing design
  statuses and review/commit steps.
- Parent finish normally offers referenced research closure and cleanup together. Other active consumers or
  independent ongoing uses keep research open. Standalone synthesis offers close/compact or continuation;
  record `open`/`closed` in its existing INDEX/result, with next use or retained findings/evidence.
- Settled milestones or large capture/export batches can compact authorized superseded scratch.
  Pause/handoff consolidates state and retains restart dependencies. No timer, TTL, age-based expiry,
  relationship registry or prerequisite whole-project audit.
- Prepare the concrete plan before its sole approval prompt; reuse existing authority when it covers
  execution. Preserve a workflow's existing next-step prompt and show cleanup as a briefing line. Only
  explicit finish/no existing next action substitutes cleanup's gate. Do not re-prompt unchanged deferrals.

## Recorded status

Use one `[Cleanup: complete | partial | deferred]` in the existing work record, with assessed scope and
retained/outstanding summary. Missing or invalidated completion means **not assessed**. The flag is the last
recorded scoped result, not proof that current payloads are unchanged or the folder is empty. Status reads
summaries; it does not repeat dependency checks or recursively scan payload sizes, hashes or mtimes.

## Material writers

Before actual new working material or material changes to retained artifacts/dependencies in an assessed
scope, attempt to invalidate its existing `complete` flag (remove it and note reassessment needed). Research
uses INDEX/result, orchestration its assigned STATE writer before material-writing dispatch, implementation
the known design §6/run result; use owned records and existing references.

If invalidation fails, warn and continue authorized normal work; include the known stale-result limit in the
current report/handoff where possible. No fallback ledger. New work without a prior result already starts
not assessed; keep existing partial/deferred reasons visible. Ordinary summary/approval/review notes and
unrelated work do not invalidate the retained set. Other workflows use this rule only when actually
producing scoped material; routed probes use their actual writer. This best-effort rule never relaxes
cleanup's reliable-record/deletion checkpoints.
