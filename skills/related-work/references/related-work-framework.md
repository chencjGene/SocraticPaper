# Related Work Framework

This framework is derived from the repository's Socratic writing principles and the provided Feishu reference page. It defines how to judge whether an academic Related Work section has enough logic to draft or revise.

## Purpose

A Related Work section has two jobs:

1. Convince reviewers that the paper covers the relevant prior work.
2. Convince reviewers that the proposed method is meaningfully different from, and better suited than, existing work for the target problem.

The section should not become a list of paper summaries. Its logic depends on classification and comparison.

## Required Structure

### 1. Paper Context

Purpose: define what the user's paper does so that prior work can be compared against it.

Required logic:

- State the paper's task, method, object of study, or problem setting.
- State the paper's core innovation or advantage.
- Name the exact axis on which prior work will be compared.

Failure modes:

- The user's own method is unclear, so comparison becomes vague.
- The axis of comparison changes from paragraph to paragraph.
- The section describes prior work without explaining relevance to this paper.

### 2. Related Work Corpus

Purpose: ensure the skill works from a known body of literature persisted in `related-work.md` rather than inventing missing background.

Required logic:

- List all related works that the user wants this section to cover in `## Related Work Corpus`.
- For each work, include citation key or author/year, title if available, and one abstract-level description.
- Mark whether each work is central, supporting, peripheral, or excluded.
- If papers are provided in chat, they must be copied into `related-work.md` before taxonomy or drafting continues.

Failure modes:

- The corpus is missing from `related-work.md`.
- Only a few examples are provided without a claim that the list is complete enough.
- The assistant uses papers from chat history without persisting them to `related-work.md`.
- The assistant fills gaps by inventing papers or unsupported claims.

If `related-work.md` contains no papers, ask the user to either write them into the file or paste them in the chat so the assistant can write them into the file.

### 3. Two-Level Taxonomy

Purpose: show a deep organizing view of prior work.

Required logic:

- Use a two-layer `n+m` structure.
- The first layer `n` should usually contain 2 to 3 major families.
- Each first-layer family should usually contain 2 to 3 second-layer subfamilies where the family is broad enough.
- Each paper should be placed in one category, or its cross-category role should be explained.
- The classification criterion should be explicit, such as method mechanism, data assumption, supervision signal, task setting, or knowledge source.

Failure modes:

- Papers are listed chronologically with no classification.
- There is only one flat list of papers.
- There are too many categories, making the field look fragmented rather than understood.
- The category names are superficial labels and do not reveal the author's view of the field.

### 4. N-Level Comparisons

Purpose: explain the important difference between existing method families and the user's method.

Required logic:

- Compare mainly at the first-layer `n` level.
- For each first-layer family, first acknowledge what it achieves.
- Then identify the specific mechanism, assumption, scope, evidence, or capability it lacks for the user's problem.
- Explain where the user's method is better suited, not only different.
- Keep the comparison fair and technically precise.

Failure modes:

- Comparing against all prior work as one vague block.
- Comparing at the second-layer `m` level so the section becomes too detailed.
- Saying "different" without explaining whether the difference improves fit, capability, robustness, efficiency, interpretability, or evaluation.
- Underestimating prior work or misrepresenting what it can do.

### 5. Closely Related Work

Purpose: give direct contrast for work that is very close to the user's paper.

Required logic:

- Identify any work that may appear almost equivalent to the user's method.
- Give it a separate paragraph plan if needed.
- Explain both similarity and difference.
- State why the user's method is better suited for the target problem.

Failure modes:

- Hiding the closest work inside a broad category.
- Overclaiming novelty by ignoring a close baseline.
- Discussing implementation details before making the conceptual distinction clear.

## Sentence-Level Rule

For ordinary works inside a category, one sentence per work is usually enough. That sentence should be writable from the abstract alone.

If a sentence requires details from the method section of the cited paper, it is probably too detailed for a normal category summary. Reserve detailed method-level discussion for extremely close work that requires direct contrast.

## Comparison Language Rule

Use fair language:

- Prior work can be pioneering, effective, promising, influential, or well suited to its original setting.
- The gap should be framed as a specific missing mechanism, assumption mismatch, scope limitation, or problem-setting mismatch.
- The user's method should be described as better suited for a stated need, not simply superior in every way.

## Completeness Rubric

Use this rubric for each section:

| Score | Meaning |
|---|---|
| 0 | Missing. |
| 1 | Present but vague, generic, or not connected to the user's paper. |
| 2 | Clear but still missing specificity, corpus coverage, or comparison precision. |
| 3 | Specific, fair, logically connected, and ready for drafting. |

A Related Work section is ready for drafting only when the corpus is scoped, the two-layer `n+m` taxonomy is accepted, first-layer comparisons are clear, and close work has been handled directly.
