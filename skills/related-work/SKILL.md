---
name: related-work
description: Socratic related-work workflow for maintaining and improving a `related-work.md` thinking-memory file. Use when the user invokes related work writing, asks to classify prior work, wants comparison against existing methods, or needs iterative questions before drafting a Related Work section.
---

# Related Work

Use this skill to run an iterative Socratic workflow for a paper Related Work section.

## Required Files

At the start of every invocation:

1. Locate `related-work.md` in the current workspace root.
2. If it does not exist, create it from the template structure in this skill.
3. Read the full `related-work.md` file before giving advice.
4. Read `references/related-work-framework.md` before judging completeness.

Treat `related-work.md` as the shared thinking memory between the user and the agent. It should contain the paper context, full related-work corpus, two-layer taxonomy, comparison logic, unresolved questions, user answers, and revision state.

## Persistence Contract

All durable state for this skill must live in `related-work.md`.

- At the start of each invocation, read `related-work.md` first and continue from its current content.
- During the session, every user-provided paper, answer, classification decision, comparison decision, draft note, and unresolved issue must be written back into `related-work.md`.
- Do not rely on chat history as the source of truth after the current turn. If information matters for the next run, persist it in `related-work.md`.
- If the user provides related-work papers in the chat instead of editing the file directly, parse the chat content and add it to `## Related Work Corpus` before continuing.
- If the user corrects or rejects an assistant-proposed taxonomy or comparison, update `related-work.md` to reflect the accepted decision and keep the rejected proposal only if it helps explain an open question.

## Memory Template

Create `related-work.md` with this structure if it is missing:

```markdown
# Related Work Memory

## Paper Context

## Related Work Corpus

## Two-Level Taxonomy

## N-Level Comparisons

## Closely Related Work

## Confirmed Logic

## Open Questions

## Draft Notes
```

## Non-Negotiable Prerequisite

This skill works only after the user has provided all known relevant related work, or at least a clearly scoped corpus that they want to use for this section.

If `## Related Work Corpus` in `related-work.md` contains no papers, do not draft the section. Tell the user they can either write the papers into `related-work.md` directly or paste them in the chat, in which case you will add them to `related-work.md` for persistence. Request a list with citation key, title, venue/year if available, and one abstract-level sentence about each work.

If the corpus is incomplete, or only described as "some papers," do not draft the section. Ask the user whether the current corpus is complete enough for this section. If they provide more papers in the chat, add them to `related-work.md`.

If the user is still collecting literature, help them define what counts as "related" and ask them to return with the corpus. Do not invent missing papers.

## Core Loop

Follow this loop exactly:

1. Load the current memory from `related-work.md`.
2. Extract the Related Work logic into the framework sections:
   - Paper context
   - Related work corpus
   - Two-level taxonomy
   - N-level comparisons
   - Closely related work
   - Confirmed logic
   - Open questions
3. Check whether the corpus is sufficient to support a Related Work section.
4. Check whether the taxonomy follows a two-level `n+m` structure:
   - The first layer `n` should usually contain 2 to 3 major families.
   - Each first-layer family should usually contain 2 to 3 second-layer subfamilies.
5. Check whether comparison against the paper's method is performed mainly at the first-layer `n` level.
6. Identify the single most important missing or weak logical piece.
7. Ask the user one focused question.
8. When the user answers, update the matching section of `related-work.md`.
9. If the user answer includes papers, add them to `## Related Work Corpus` before doing taxonomy or comparison work.
10. Re-run the check and repeat until the Related Work logic is complete enough to draft or revise prose.

Do not write a polished Related Work section before the corpus, two-layer taxonomy, and first-layer comparison logic pass the framework check unless the user explicitly asks for a rough draft.

## Assistant-Proposed Taxonomy And Comparison

You may propose a candidate `n+m` taxonomy and candidate comparison points when the user has provided enough papers but has not organized them yet.

When proposing, label it clearly as a proposal and ask the user to confirm or correct it. Do not silently treat your proposed taxonomy as final.

Good proposal format:

```markdown
Candidate first-layer families:
1. Family A: ...
2. Family B: ...
3. Family C: ...

For Family A, possible second-layer subfamilies:
- A1: ...
- A2: ...

Candidate comparison at the first-layer level:
- Compared with Family A, our method differs because ...
- Compared with Family B, our method is better suited for ... because ...
```

After the user responds, update `## Two-Level Taxonomy`, `## N-Level Comparisons`, and `## Confirmed Logic`.

## Memory Update Rules

When updating `related-work.md`:

- Preserve existing user-provided content.
- Persist every substantive change before using it as a basis for later reasoning.
- Add new answers under the most relevant section.
- Add pasted paper lists to `## Related Work Corpus`, normalizing each item into citation/title/year/abstract-level description when possible.
- Keep each work description at the abstract-level unless the work is extremely close to the user's paper.
- Record unresolved issues under `## Open Questions`.
- Record accepted taxonomy and comparison decisions under `## Confirmed Logic`.
- Mark weak, inferred, or unverified classifications as `Needs verification`.
- Do not make prior work sound worse than it is. Use fair language that acknowledges what each family does well before identifying the gap.

Use concise Markdown. Do not hide uncertainty by rewriting it as a confident claim.

## Question Policy

Ask one question at a time unless the user explicitly asks for a full checklist.

Prefer questions that force a classification or comparison decision:

- `related-work.md` does not contain any papers yet. Do you want to write them into the file, or paste them here so I can add them?
- Have you provided all related works that should be covered in this section?
- Which 2 to 3 major families best organize these works?
- For this family, what are the 2 to 3 meaningful subfamilies?
- Which papers belong to each subfamily, and why?
- At the first-layer family level, what mechanism do these works generally lack for your problem?
- Where is your method better, not merely different?
- Is this difference a core innovation, a scope difference, an efficiency difference, an assumption difference, or an evaluation setting difference?
- Is any work close enough to deserve a separate paragraph and direct contrast?

Avoid generic advice such as "summarize the literature better." Ask for the missing classification, corpus, or comparison premise.

## Stop Conditions

The skill may proceed to drafting or revision when:

- The related-work corpus is present and scoped.
- Every important work is assigned to the taxonomy or explicitly excluded with a reason.
- The taxonomy has a two-layer `n+m` form, usually 2 to 3 first-layer families and 2 to 3 second-layer subfamilies where relevant.
- Each first-layer family has a fair abstract-level summary.
- The paper is compared against prior work mainly at the first-layer level.
- The comparison explains where the paper is better suited, not only how it is different.
- Extremely close work has a direct contrast paragraph plan.
- No central classification or comparison claim is marked `Needs verification`.

If these conditions are not met, keep asking.

## Optional Deterministic Check

For a quick structural check, run:

```powershell
powershell -ExecutionPolicy Bypass -File skills\related-work\scripts\check-related-work-memory.ps1 related-work.md
```

Use the script output as a helper only. The final judgment must still follow `references/related-work-framework.md`.
