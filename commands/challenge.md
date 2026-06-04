# Challenge Workflow

Read docs/methodology-template.tpl for the template structure.

An **adversarial validator of a premise** — the upstream analogue of `code-review` (which validates an implementation). `challenge` pressure-tests whether the work *should be done at all*. It is invoked **after** enough context exists (a fleshed-out idea, a research log, or a design log), not as a mandatory front-door.

Single-purpose: `challenge` does **not** do cooperative gap-fill. Filling missing context (goals / prior-art / constraints / out-of-scope / success / blockers) lives in `/mtg design` Step 1–2 (Problem Statement).

## Input

- A design-log / research-log by NNN or path, or conversation context when no formal doc exists but context is sufficient.
- **Read the artifact first** — "read before you ask." Do not interrogate what the doc already answers.

## When to use this command

| Situation | Use |
|---|---|
| Premise/necessity is unexamined — "should we even build this?" | `/mtg challenge` (this command) |
| Re-question whether existing work still deserves to exist | `/mtg challenge` |
| Context is too thin to even state the problem | `/mtg design` Step 1–2 (gap-fill) |
| A formed design needs soundness review | `/mtg review` |

## Workflow

Copy this checklist and track progress:

```
Challenge Progress:
- [ ] Step 1: Read — load the artifact (or context); note what's already answered
- [ ] Step 2: Forcing questions — six adversarial questions, STOP after each
- [ ] Step 3: Verdict — premise holds, or recommend a change (User-Challenge brief)
- [ ] Step 4: Write back — refine source log or carry verdict in context
```

**Step 1: Read**

Load the target artifact fully. Identify what premise is being asserted and which forcing questions are already answered (smart-skip those).

**Step 2: Forcing questions** (re-anchored startup → internal-eng framing; keep the *forcing* mechanic)

Ask one at a time. **STOP after each** — one gate at a time.

1. **Demand Reality** — what's the strongest evidence someone would be genuinely upset if this disappeared? (not "interesting", not signups)
2. **Status Quo** — what are people doing right now to solve this, even badly? What does the workaround cost?
3. **Desperate Specificity** — name the actual human. "You can't email a category."
4. **Narrowest Wedge** — smallest version someone would adopt *this week*, not after the platform.
5. **Observation & Surprise** — have you watched someone use it unaided? What surprised you?
6. **Future-Fit** — in 3 years, does this become more essential or less?

**Control pattern:**
- STOP after each question; smart-skip ones already answered by the artifact.
- **Bounded escape hatch:** on user impatience, ask ≤2 more from the stage table, then proceed — **never a 3rd time** on a single point.

**Step 3: Verdict**

- If the premise holds → say so, note the strongest surviving evidence, and route forward (`/mtg design` or `/mtg plan`).
- If the conclusion is *the direction should change* → emit the **User-Challenge brief**:

  ```
  What the user said   — <the stated direction>
  What we recommend    — <the alternative>
  Why                  — <the reasoning>
  What context we might be missing — <gaps>
  If we're wrong, the cost is — <downside of pivoting>
  ```

  The user's original direction is the **default**; `challenge` must *argue* for change — **never auto-pivot.**

**Step 4: Write back**

- Source log exists → seed/refine §1 Problem Statement, add new open-Qs to §2 (marked `[draft]`), or (research log) add a "Premise Challenge" note to the INDEX.
- No source log → carry the verdict in conversation context. **No new file type.**

## Boundary vs `review` (no cannibalization)

| | `review` | `challenge` |
|---|---|---|
| Target | A formed design log | An idea / necessity / existing work |
| Question | Is the design **sound**? | **Should this exist?** Is it necessary? |
| Altitude | Solution-level | Premise-level |
| "Value" lens | complexity-vs-problem *inside a design* | whether the problem deserves solving at all |

Flow: `challenge (premise?) → design → review (design sound?)`. `challenge` is re-runnable against existing work to re-question necessity — which `review` has no equivalent for.

**Not adopted:** "design doc only, never code" hard gate (mtg already gates design→approve→implement); builder-mode riff/delight posture (out of scope for internal-eng).

## Next Step

When the premise holds:
  Prompt: "Run `/mtg design <topic>` (or `/mtg plan`)? [Y/n]"
  If Y → invoke the suggested command. If n → end.

When a pivot is recommended (User-Challenge brief emitted):
  Leave the decision with the user — do not auto-pivot. End after presenting the brief.
