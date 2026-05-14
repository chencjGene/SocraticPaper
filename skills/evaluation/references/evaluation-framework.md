# Evaluation Framework

This framework defines how to judge whether an academic Evaluation or Experiments section has enough evidence to draft or revise.

## Purpose

An Evaluation section has five jobs:

1. Show that the experimental setting is complete and fair.
2. Demonstrate the main result clearly through tables and figures.
3. Verify that datasets, baselines, and metrics cover the relevant prior work.
4. Judge whether the reported improvement is meaningful relative to the task and prior-work improvement scale.
5. Prove that the core method choices matter through ablation, diagnostic, robustness, user-study, case-study, or field evidence.

The section should not primarily optimize prose. Its logic depends on whether the evidence supports the paper's claims.

## Required Structure

### 1. Related-Work Prerequisite

Purpose: make sure experimental coverage is judged against the actual prior-work corpus.

Required logic:

- `related-work.md` exists in the workspace root.
- `related-work.md` contains a usable `## Related Work Corpus`.
- Close and strong prior works are visible enough to check baseline coverage.
- Taxonomy and comparison axes are used to understand which dataset or metric types matter.

Failure modes:

- The Evaluation section is judged without knowing the prior work.
- Missing baselines are invisible because `related-work.md` is absent or empty.
- The assistant invents papers, datasets, or baselines instead of asking for the corpus.

### 2. Experimental Settings

Purpose: define the experimental setup before interpreting results.

Required logic:

- Datasets are listed with task, scale or split when available, and reason for inclusion.
- Baselines include close, strong, and representative prior works.
- Evaluation metrics are named, direction-aware, and aligned with the paper's claim.
- Implementation details are sufficient for credible comparison.

Failure modes:

- A dataset is named but its role is unclear.
- Baselines omit the closest related work without explanation.
- Metrics are listed without saying whether higher or lower is better.
- Implementation details are too thin to know whether the comparison is fair.

### 3. Coverage Check Against Related Work

Purpose: prevent the paper from claiming superiority while missing obvious experimental evidence.

Required logic:

- Compare datasets against dataset types used in prior work.
- Compare baselines against the related-work corpus and closest papers.
- Compare metrics against task goals and prior-work reporting conventions.
- Record exclusions with reasons such as unavailable code, incompatible task setting, missing data, or out-of-scope assumptions.

Failure modes:

- Important related work is discussed but not evaluated against.
- A dataset family central to the claim is absent.
- The metric does not measure the claimed advantage.
- Exclusions are silently omitted rather than justified.

### 4. Main Results

Purpose: make the central empirical claim visible.

Required logic:

- A main-results table or link is present.
- Each dataset and metric can be mapped to the user's method and strongest comparable baselines.
- The observation is separated from interpretation.
- Result direction and best baseline are clear.

Failure modes:

- Main results are described verbally with no table or link.
- The best baseline is ambiguous.
- Improvements are reported only as "better" without magnitude.
- The table supports a narrower claim than the text makes.

### 5. Improvement Analysis

Purpose: judge whether the reported gain is persuasive.

Required logic:

- Per-dataset gains are computed or estimated where possible.
- Average gains are computed or estimated across comparable datasets and metrics.
- The user's gain is compared with the spread among prior methods.
- Small gains are supported by significance, repeated runs, metric saturation, efficiency, robustness, or practical value when relevant.

Failure modes:

- A 0.1-point gain is treated as strong even though prior methods differ by several points.
- A large gain appears on one dataset only but is generalized to all settings.
- Lower-is-better metrics are interpreted in the wrong direction.
- No distinction is made between absolute and relative improvement.

### 6. Ablation / Evaluation Study

Purpose: verify that the method works for the claimed reason.

Required logic:

- Core modules or design choices are tested by removal, replacement, sensitivity, or diagnostic analysis.
- The central innovation is tested, not only minor hyperparameters.
- The study explains where the main-result gain comes from.
- If standard ablation is impossible, an alternative is recorded and justified.

Failure modes:

- No ablation or evaluation study exists.
- Ablation tests a minor setting but not the central contribution.
- The method claims a mechanism but gives only end-to-end scores.
- The study result contradicts the claimed contribution and is ignored.

### 7. Optional Case Study

Purpose: show qualitative or scenario-level evidence that tables cannot fully capture.

Required logic:

- Cases are tied to the paper's core innovation.
- At least one case shows why the user's method succeeds where baselines struggle.
- The analysis avoids cherry-picking claims unless the selection rule is clear.

Failure modes:

- Case study is only decorative.
- Cases do not connect to the claimed advantage.
- The result is asserted without explaining what the reader should observe.

### 8. Optional Field Experiment

Purpose: show real-world effect when the paper has a deployment or realistic scenario.

Required logic:

- The setting, users or environment, and outcome are clear.
- The field evidence supports a claim that ordinary benchmark tables cannot show.
- Limitations of the field setting are stated.

Failure modes:

- A field experiment is implied but not described.
- The field setting is too anecdotal for the claim.
- The result is overgeneralized beyond the scenario.

## Completeness Rubric

Use this rubric for each section:

| Score | Meaning |
|---|---|
| 0 | Missing. |
| 1 | Present but vague, incomplete, or disconnected from claims. |
| 2 | Clear but still missing coverage, comparison scale, or justification. |
| 3 | Specific, coverage-aware, claim-aligned, and ready for drafting. |

An Evaluation section is ready for drafting only when related-work coverage is checked, experimental settings are complete, main results are available, improvement size is judged against comparable baselines, and ablation or equivalent evaluation evidence supports the core claims.
