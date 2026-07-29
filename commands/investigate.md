# Investigate Workflow

Read docs/methodology-template.tpl for the template structure.

A systematic **debugging entry point**. It produces a **root-cause finding**, not a design log — escalating *into* a design log only when the root cause is a design flaw, otherwise promoting to a direct fix. Both promotions are user-approved.

**Iron Law:** *"NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST. Fixing symptoms creates whack-a-mole debugging… Find the root cause, then fix it."*

**Red-capable loop:** reproduce an observable failure, form one testable root
cause hypothesis, confirm it, then consider a fix. A loop that cannot expose a
failure cannot validate the fix.

This command **reuses** existing mtg machinery rather than reinventing it: `implement`'s Phase-4 Verify mechanics, `implement`'s Phase-3 scope-check, and the >5-file blast-radius / public-contract Hard Gates already in `code-review`.

## Input

- A bug report, failing test, stack trace, or symptom description after the command name, or from conversation context.

## Workflow

**Phase 1: Root-cause investigation**

- Collect symptoms (one question at a time if the report is thin).
- Read the code path from symptom → cause.
- Check recent changes: `git log -- <files>` — *"a regression means the root cause is in the diff."*
- Reproduce deterministically.
- Note recurring bugs in the area **if visible from `git log`** (architectural smell — this is a git observation, not a memory lookup).
- **Output a specific, testable claim before any edit:** `Root cause hypothesis: …`

**Phase 2: Scope-lock (prose)**

- After the hypothesis, declare the narrowest dir containing the affected files as the locked scope.
- Edits outside it → **STOP-and-ask** (reuses `implement` Phase-3 scope-check).
- If the bug genuinely spans the repo, skip the lock and note why. *No hook (respects the hooks-deferred non-goal).*

**Phase 3: Pattern analysis**

Match the symptom against the known-pattern table:

| Pattern | Signature | Where to look |
|---|---|---|
| Race condition | intermittent, timing-dependent, "works when I add a log" | shared mutable state, async ordering, missing await/lock |
| Nil-propagation | NPE / undefined far from origin | optional chains, unchecked returns, default-less `.get()` |
| State corruption | wrong value with no error | mutation aliasing, stale copies, out-of-order writes |
| Integration failure | works in isolation, fails wired up | contract mismatch, serialization, version skew |
| Config drift | "works on my machine" | env vars, feature flags, defaults differing by environment |
| Stale cache | old value after a change | TTL, invalidation gaps, memoization keys |

**Phase 4: Hypothesis testing (3-strike)**

- Confirm the hypothesis with a temporary log/assertion **before writing any fix.**
- **If 3 hypotheses fail → STOP** → AskUserQuestion:
  - **A)** continue with a new named hypothesis
  - **B)** escalate for human review
  - **C)** add logging and wait
- *Red flags:* "quick fix for now" (there is no for-now) · proposing a fix before tracing data flow = guessing · each fix reveals a new problem = wrong layer.

**Phase 5: Classify & promote**

At confirmed root cause, classify via existing tripwires:

- **Localized** (≤5 files, no contract/design change) → recommend **promote to fix**: smallest root-cause fix + a regression test that **fails-without / passes-with**; run the full suite.
- **Design flaw** (public-contract change / >5 files) → recommend **escalate**: open a design log with the root-cause analysis as §1 Problem Statement, hand to `/mtg design`.

Either way, present the **DEBUG REPORT** and gate on user approval of the promotion:

```
DEBUG REPORT
- Symptom         — <observed failure>
- Root cause      — <confirmed cause>
- Hypotheses tried — <list, incl. failed ones>
- Fix             — <the change, or "escalate to design log">
- Regression test — <test that fails-without / passes-with>
- Verification    — <reproduce + suite result>
```

**Phase 6: Verify** (reuse `implement` Phase-4)

- Reproduce the original scenario — **not optional.**
- Run the full suite.
- Confirm the regression test is meaningful (fails without the fix, passes with it).

## Output (no new file type)

- **Fix path** → DEBUG REPORT inline (feeds the commit message).
- **Escalation path** → DEBUG REPORT seeds the new design log's §1 Problem Statement.

## Next Step

When a localized fix is approved and verified:
  Prompt: "Run `/mtg commit`? [Y/n]"
  If Y → invoke `/mtg commit`. If n → end.

When escalated to a design log:
  Prompt: "Run `/mtg design` with the root-cause analysis as §1? [Y/n]"
  If Y → invoke `/mtg design`. If n → end.
