# Verification standard

Use when choosing/adapting checks or judging evidence. Methods and checkpoint grouping follow the claim, risk and dependencies.

| Keyword | Standard |
|---|---|
| Claim | Approved acceptance → observable result. Distinguish source, target availability, actual output, quality and fulfillment where they differ. |
| Reuse | Select relevant proven checks from TOOLS/referenced runs; inspect inputs, versions, prerequisites and limits. |
| Method | Direct evidence in the intended environment; representative end-to-end output early. Explain substitutes and unknowns. |
| Challenge | Challenge consequential uncertainty through an independent reviewer, observation, calculation or failure case as appropriate. Repeating the author's helper alone is insufficient; choose the method and checkpoint to match the claim and risk. |
| Discrimination | Relevant known failures/negative controls for critical checkers where appropriate. Accepting the motivating defect cannot establish correction. |
| Coverage | Verified/failed/unknown criteria with evidence/limits. Samples support sampled claims; passing subsets cannot establish whole-goal acceptance. |
| Validity | Reuse while relevant code, dependencies, inputs and conditions remain valid. Contrary evidence invalidates affected claims; corrections need affected coverage/integration rechecked. |

Existing correctness failures need in-scope correction; new requirements are recommendations. Preserve useful methods/lessons in run knowledge, linking evidence.

For relevant worked examples, consult verification-examples.md. Run-specific invocations, prerequisites and findings belong in the originating TOOLS.md/LEARNINGS.md.
