<!-- Shared task contract: read before execution; omit this comment when drafting briefs.
Authority: read this contract, your brief, charter and project rules. Existing approval carries forward; unresolved scope/access/authority goes to the orchestrator with a recommendation, not directly to the user.
Ownership: touch assigned resources only; respect shared writers and unrelated edits. Keep jobs and output locations traceable.
Evidence: write useful findings incrementally to result.md (templates/result.md); return concise outcome, evidence, uncertainty and continuation with linked detail.
Lifecycle: prefer events; bounded same-job recovery when needed. No file watchers or unbounded polling loops. Retain accepted IDs; never resubmit because a wait timed out. Report live jobs even if your turn ends.
Spend: only allocated paid work; report usage/uncertainty and request further allocation from the orchestrator. Omit spending fields when irrelevant.
Access: record sanctioned access methods, never secret values in briefs/results/logs/replies. New credential handling needs authority.
People: use names or they/them; do not infer pronouns.
-->
# Brief — T<nnn>-<role>-<slug>

Run: <absolute path>   Role: <absolute role path>
Authority: <charter section and approval source>   Project rules: <absolute path>

## Outcome / acceptance
<coherent outcome, parent goal/criteria, checkable done-when>

## Inputs / uncertainty
<relevant paths, versions, settled interfaces, tool/lesson pointers; decisive unknowns>

## Ownership / boundaries
<files, worktree/branch, sessions/jobs/outputs; integration owner; out of scope>

## Checks
<author checks or independent checkpoint; experiment expectation/falsifier when applicable>

## Allocation (paid work only; otherwise omit)
<orchestrator-authorized operation/batch and limit; report usage and remaining jobs>

## Return
Write result.md next to this brief using templates/result.md. Concise outcome, evidence/limits, continuation and orchestrator decisions; details linked.
