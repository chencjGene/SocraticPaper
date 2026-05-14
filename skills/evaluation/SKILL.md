---
name: evaluation
description: Socratic paper-evaluation workflow for maintaining and improving an `evaluation.md` thinking-memory file. Use when the user invokes Evaluation, Results, Experiments, ablation, main-results checking, dataset/baseline/metric coverage checking, or wants to judge whether experimental evidence is complete and convincing.
---

# Evaluation

Use this skill to run an iterative Socratic workflow for a paper Evaluation or Experiments section.

This skill is not mainly a prose-polishing tool. Its job is to check whether the experimental evidence is complete enough to support the paper's claims: whether datasets are missing, baselines are complete, metrics are appropriate, improvements are large enough to matter, and ablation or evaluation studies support the core method choices.

## Required Files

At the start of every invocation:

1. Locate `evaluation.md` in the current workspace root.
2. If it does not exist, create it from the template structure in this skill.
3. Read the full `evaluation.md` file before giving advice.
4. Read `references/evaluation-framework.md` before judging completeness.
5. Check whether `related-work.md` exists in the workspace root.
6. If `related-work.md` exists, read it and use `## Related Work Corpus`, `## Two-Level Taxonomy`, `## N-Level Comparisons`, and `## Closely Related Work` to check dataset, baseline, and metric coverage.
7. If `related-work.md` is missing or contains no usable related-work corpus, stop and ask the user to provide related work first.

Treat `evaluation.md` as the shared thinking memory between the user and the agent. It should contain experimental settings, related-work-derived coverage checks, main results, improvement analysis, ablation or evaluation studies, unresolved questions, user answers, and revision state.

## PDF Input Check

If the user provides a PDF, extract or read its text before judging the Evaluation section. If a companion text file extracted from the same PDF is available, prefer using it as the readable source while treating the PDF as the original document.

Check the PDF content against every relevant requirement in this skill and in `references/evaluation-framework.md`, including related-work prerequisite, dataset coverage, baseline coverage, metric coverage, implementation details, main-results table, improvement analysis, ablation or evaluation studies, and optional case or field evidence when relevant.

If the PDF does not satisfy a requirement, list the issue explicitly for the user under a warning or reminder section. Each warning should name the missing or weak requirement, briefly explain what evidence was found or not found in the PDF, and state what the user should add, revise, or verify. Do not silently assume that missing PDF content exists elsewhere unless it is present in `evaluation.md` or the related-work prerequisite file.

## Persistence Contract

All durable state for this skill must live in `evaluation.md`.

- At the start of each invocation, read `evaluation.md` first and continue from its current content.
- During the session, every user-provided dataset, baseline, metric, implementation detail, table, link, experimental result, ablation result, correction, and unresolved issue must be written back into `evaluation.md`.
- Do not rely on chat history as the source of truth after the current turn. If information matters for the next run, persist it in `evaluation.md`.
- If the user provides experimental tables or links in chat instead of editing the file directly, summarize and add them to the appropriate section of `evaluation.md` before continuing.
- If the user corrects or rejects an assistant-proposed missing baseline, dataset, metric, or interpretation of improvement size, update `evaluation.md` to reflect the accepted decision and keep the rejected proposal only if it explains an open question.
- Do not provide a substantive experimental critique or next-step plan based only on chat memory. First make the relevant information durable in `evaluation.md`, then reason from the file.

## Memory Template

Create `evaluation.md` with this structure if it is missing:

```markdown
# Evaluation Memory

## Paper Context

## Related-Work Prerequisite

## Experimental Settings

### Datasets

### Baselines

### Evaluation Metrics

### Implementation Details

## Coverage Check Against Related Work

### Dataset Coverage

### Baseline Coverage

### Metric Coverage

## Main Results

### Result Table Or Link

### Per-Dataset Results

### Average Improvement

### Comparison With Existing Improvement Scale

## Ablation / Evaluation Study

## Case Study

## Field Experiment

## Logic Checks

## Confirmed Logic

## Open Questions

## Draft Notes
```

## Non-Negotiable Prerequisite

This skill works only after the user has provided a related-work corpus in `related-work.md`.

If `related-work.md` does not exist, do not continue to build or judge the Evaluation section. Tell the user that the Evaluation skill must know the related work first so it can check whether important datasets, baselines, and metrics are missing.

If `related-work.md` exists but `## Related Work Corpus` contains no papers, do not continue to build or judge the Evaluation section. Ask the user to provide the related-work corpus through the Related Work skill or paste the relevant papers so they can be persisted in `related-work.md`.

If the related-work corpus is present but incomplete, ask the user whether the current corpus is complete enough to use as the basis for experimental coverage. Do not invent missing papers.

## Required Experimental Inputs

Before judging main results, require:

1. Datasets.
2. Baselines.
3. Evaluation metrics.
4. Implementation details sufficient to make the comparison credible.

If any of these are missing from `evaluation.md` or the user's latest input, ask for the missing item first. Do not move on to main-result interpretation before the basic experimental setting is known.

When the required inputs are present, compare them against `related-work.md`:

- Check whether major dataset types from prior work are represented or explicitly excluded.
- Check whether the closest and strongest prior works are included as baselines or explicitly justified as unavailable, incomparable, or out of scope.
- Check whether metrics match the task goal and are comparable with prior work.
- Check whether any related-work family needs a specific baseline or metric to make the paper's advantage credible.

If coverage appears incomplete, ask whether the user needs to add a specific dataset, baseline, or metric. Phrase this as a focused question, not a broad warning.

## Core Loop

Follow this loop exactly:

1. Load the current memory from `evaluation.md`.
2. Check the non-negotiable `related-work.md` prerequisite.
3. Read `related-work.md` and extract the related-work corpus, taxonomy, close work, and comparison axes.
4. Extract the Evaluation logic into the framework sections:
   - Paper context
   - Experimental settings
   - Coverage check against related work
   - Main results
   - Improvement analysis
   - Ablation or evaluation study
   - Optional case study
   - Optional field experiment
5. Check whether datasets, baselines, metrics, and implementation details are present.
6. If any required setting is missing, ask for the single most important missing setting and persist the answer before continuing.
7. Compare datasets, baselines, and metrics against the related-work corpus and close work.
8. If coverage appears incomplete, ask whether to add or justify the missing dataset, baseline, or metric.
9. Ask the user to provide the main-results table or a link to it if it is missing.
10. After receiving main results, persist the table or link in `evaluation.md`.
11. Compute or estimate per-dataset and average improvements for the user's method against the strongest comparable baselines where possible.
12. Compare the user's improvement size with the improvement scale among existing baselines.
13. If the user's gain is much smaller than the typical gap among prior methods, warn that the improvement may not be convincing enough and ask what additional evidence, dataset, metric, or analysis can support the claim.
14. Check whether ablation or evaluation study evidence is present.
15. If ablation/evaluation study evidence is missing, ask the user to provide it or explain why it is not needed.
16. Identify the single most important missing or weak experimental-evidence piece.
17. Ask one focused question.
18. When the user answers, update the matching section of `evaluation.md`.
19. Re-run the check and repeat until the Evaluation evidence is complete enough to draft or revise prose.

Do not write a polished Evaluation section before experimental settings, related-work coverage, main results, improvement analysis, and ablation/evaluation study checks pass unless the user explicitly asks for a rough draft.

## Main Results Policy

The main-results table is the center of this section. It may be pasted directly, summarized manually, or provided as a link.

When the table is available:

- Identify each dataset, metric, baseline, and the user's method.
- For metrics where higher is better, compute improvement as `our score - best comparable baseline score` and, when useful, relative improvement as `(our score - baseline score) / baseline score`.
- For metrics where lower is better, compute improvement as `best comparable baseline score - our score` and, when useful, relative improvement as `(baseline score - our score) / baseline score`.
- State whether the improvement is consistent across datasets or concentrated in one setting.
- Compare the improvement size with the spread among prior baselines.
- Flag suspicious or weak cases, such as improvement only on one dataset, no gain on the closest metric, or large gains without ablation support.

Use careful language. A small gain may still be meaningful if the metric is saturated, the dataset is hard, the method is simpler, or the result is statistically stable. A large gain may still need verification if the setup differs from prior work.

## Improvement Adequacy Rule

When comparing improvement size, reason against the scale of existing differences.

Examples:

- If existing baselines usually differ by several points and the user's method improves by only 0.1 point, warn that the result may not be persuasive unless supported by statistical tests, efficiency gains, robustness, or a stronger qualitative case.
- If the improvement is small but consistent across many datasets and metrics, ask whether the user has variance, significance, or repeated-run results.
- If the improvement is large only on one dataset, ask whether that dataset is central to the paper's claim or whether additional evidence is needed.
- If the user's method underperforms a close baseline on an important metric, ask whether the paper's claim should be narrowed or whether another experiment is missing.

Do not reduce the judgment to a fixed threshold. The standard depends on the task, metric scale, prior-work spread, and paper claim.

## Ablation / Evaluation Study Policy

Require ablation or evaluation studies that directly test the method's core design choices.

At minimum, check whether the user has evidence for:

- Removing or replacing each core module.
- Testing the central innovation, not only minor hyperparameters.
- Showing whether the performance gain comes from the claimed mechanism.
- Robustness or sensitivity analysis when the method depends on prompts, retrieval, thresholds, budgets, sampling, or model choices.

If no ablation or evaluation study is provided, ask for it before drafting. If the user says ablation is impossible, ask for a defensible alternative such as component replacement, diagnostic analysis, user study, case study, error analysis, or field experiment.

## Optional Study Policy

Case Study is optional but encouraged when it can show something the main table cannot:

- A case where the user's method succeeds and baselines fail.
- A case tied to the core innovation.
- A case that demonstrates interpretability, reasoning quality, robustness, or real-world usefulness.

Field Experiment is optional. Use it when the paper has a real deployment or realistic scenario that materially strengthens the claim.

Do not block drafting only because optional case study or field experiment evidence is absent. Record them as open opportunities unless the paper's claim depends on them.

## Memory Update Rules

When updating `evaluation.md`:

- Preserve existing user-provided content.
- Persist all user-provided chat content that affects Evaluation before using it for reasoning.
- Add dataset names, task settings, splits, and source notes under `### Datasets`.
- Add baseline names, citation links, implementation source, and fairness notes under `### Baselines`.
- Add metric definitions, direction, and why each metric matters under `### Evaluation Metrics`.
- Add training, inference, model, prompt, hardware, split, repeat-run, and parameter notes under `### Implementation Details`.
- Add missing or excluded datasets, baselines, and metrics under `## Coverage Check Against Related Work`.
- Add main-results tables or links under `### Result Table Or Link`.
- Add computed or estimated gains under `### Average Improvement`.
- Add adequacy judgments under `### Comparison With Existing Improvement Scale`.
- Add ablation, sensitivity, robustness, diagnostic, user-study, case-study, or field evidence under the matching section.
- Record unresolved issues under `## Open Questions`.
- Record accepted coverage and result-interpretation decisions under `## Confirmed Logic`.
- Mark weak, inferred, or unverified result interpretations as `Needs verification`.

Use concise Markdown. Do not hide uncertainty by rewriting it as a confident experimental conclusion.

## Question Policy

Ask one question at a time unless the user explicitly asks for a full checklist.

Prefer questions that force an experimental decision:

- `related-work.md` is missing. Can you first provide the related-work corpus so I can check datasets, baselines, and metrics against it?
- Which datasets are used, and what task or split does each represent?
- Which baselines are included, and do they cover the closest papers in `related-work.md`?
- Are any baselines from the related-work corpus intentionally excluded? If so, why?
- Which metrics are used, and for each metric is higher or lower better?
- Can you provide the main-results table or a link to it?
- For this dataset and metric, should the strongest baseline be `<baseline>` or another method?
- The average gain appears small relative to prior baseline gaps. Do you have significance tests, repeated runs, efficiency gains, robustness evidence, or another metric that supports the claim?
- Which core module or design choice should the ablation study test first?
- Do you have an ablation/evaluation study for the central innovation, or should we mark it as missing?

Avoid generic advice such as "add more experiments." Ask for the missing dataset, baseline, metric, table, improvement evidence, or ablation decision.

## Stop Conditions

The skill may proceed to drafting or revision when:

- `related-work.md` exists and contains a usable related-work corpus.
- Datasets are present and coverage against related work is checked.
- Baselines are present and coverage against close/strong related work is checked.
- Evaluation metrics are present, direction-aware, and appropriate for the claims.
- Implementation details are sufficient to make comparisons credible.
- The main-results table or link is present.
- Per-dataset and average improvements are analyzed against strongest comparable baselines.
- Improvement size is judged against the spread among prior methods.
- Ablation or evaluation study evidence exists, or a justified alternative is recorded.
- Any missing optional case study or field experiment is recorded as optional rather than silently ignored.
- No central experimental claim is marked `Needs verification`.

If these conditions are met, state clearly that the Evaluation evidence is ready for rough drafting or revision, and stop the Socratic questioning loop.

## Drafting Policy

When drafting a completed Evaluation section:

- Use this default structure unless the venue or user requires another order:
  1. Experimental Settings: datasets, baselines, metrics, implementation details.
  2. Main Results: the central table and concise observations.
  3. Ablation / Evaluation Study: evidence that the core design choices matter.
  4. Case Study if available.
  5. Field Experiment if available and relevant.
- Make the main table and figures carry the argument.
- Explain result observations before interpretations.
- Avoid overclaiming from tiny, inconsistent, or unverified gains.
- Do not invent missing numbers, baselines, datasets, statistical tests, or implementation details.
- If an important baseline, dataset, metric, or ablation is missing, either keep it as an explicit limitation/open issue or ask the user before drafting a confident claim.

## Optional Deterministic Check

For a quick structural check, run:

```powershell
powershell -ExecutionPolicy Bypass -File skills\evaluation\scripts\check-evaluation-memory.ps1 evaluation.md
```

Use the script output as a helper only. The final judgment must still follow `references/evaluation-framework.md`.
