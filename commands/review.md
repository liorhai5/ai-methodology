# Design Review Workflow

Read docs/methodology-template.tpl for the review checklist.

## Target

- Use the design log number or path provided after the command name.
- If none provided, list design logs and ask which to review.

## Context Gathering

Before reviewing:
1. Read the target design log fully.
2. Scan `.ai/design-logs/` for related prior designs referenced or superseded.
3. Read relevant code, configs, or architecture touched by the design.

## Review Perspectives

Evaluate the design through each lens. For each, state **pass**, **concern**, or **fail** with specific notes.

**Feasibility**
- Are there gaps or unknowns that block implementation?
- Are all dependencies identified and available?
- Is the scope realistic given the current codebase?

**Risk**
- What failure modes exist? What's underspecified?
- What assumptions could break? What happens if they do?
- Are there security concerns? (auth gaps, trust boundaries, input handling, secrets exposure)
- Are there performance or data integrity concerns?

**Coherence**
- Do all decisions fit together without contradictions?
- Has scope drifted from the original problem statement?
- After all Q&A decisions, does the whole design still make sense?

**Architecture**
- Clean separation of concerns? No cross-cutting leaks?
- Are interfaces and boundaries well-defined?
- Is the dependency direction correct?

**Value**
- Is the complexity justified by the problem being solved?
- Could we achieve the same outcome with less?
- Is the user/system value clear and measurable?

**Alignment**
- Does it follow decisions from prior related design logs?
- Does it respect methodology gates (design freeze, approval flow)?
- Is it consistent with existing patterns in the codebase?

**Completeness**
- Are tests specified or implied for all new behavior?
- Are documentation updates identified where needed?
- Are migration or rollout steps covered if applicable?

## Verdict

Present findings as a table:

```
| Perspective  | Rating  | Notes |
|--------------|---------|-------|
| Feasibility  | pass    | ...   |
| Risk         | concern | ...   |
| Coherence    | pass    | ...   |
| Architecture | pass    | ...   |
| Value        | concern | ...   |
| Alignment    | pass    | ...   |
| Completeness | fail    | ...   |
```

Then recommend one of:
- **Ready for approval** — no concerns or fails
- **Address concerns** — list specific items to resolve
- **Needs rework** — fundamental issues found

## Update Design Log

After presenting the verdict, if there are concerns or fails:

1. **Present suggested changes** — show the user what you propose to add/reopen in §2 (Q&A):
   - New questions to add (as `[draft]`)
   - Existing questions to reopen (revert from `[decided]` to `[draft]`) with rationale
   - Suggest setting design log status back to `draft`
2. **User approval gate** — prompt: "Apply these updates to the design log? [Y/n/edit]"
   - If Y → apply changes to §2 and update status to `draft`
   - If edit → incorporate user modifications, then apply
   - If n → skip updates, leave design log unchanged

## Next Step

When the review passes (Ready for approval):
  Prompt: "Run `/mtg implement <NNN>`? [Y/n]"
  If Y → invoke `/mtg implement <NNN>`.
  If n → end.

When the review finds issues (Address concerns / Needs rework):
  After applying updates to the design log (or if user skipped updates):
  Prompt: "Run `/mtg design <NNN>` to address findings in §2? [Y/n]"
  If Y → invoke `/mtg design <NNN>`.
  If n → end.
