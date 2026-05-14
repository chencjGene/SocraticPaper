---
name: introduction
description: Socratic paper-introduction workflow for maintaining and improving an `introduction.md` thinking-memory file. Use when the user invokes introduction writing, asks to revise an Introduction section, wants logic checking for an academic Introduction, or wants iterative questions that update the stored Introduction reasoning after each answer.
---

# Introduction

Use this skill to run an iterative Socratic workflow for a paper Introduction.

## Required Files

At the start of every invocation:

1. Locate `introduction.md` in the current workspace root.
2. If it does not exist, create it from the template structure in this skill.
3. Read the full `introduction.md` file before giving advice.
4. Read `references/introduction-framework.md` before judging completeness.

Treat `introduction.md` as the shared thinking memory between the user and the agent. It should contain the current paper context, extracted logic, unresolved questions, user answers, and revision state.

## PDF Input Check

If the user provides a PDF, extract or read its text before judging the Introduction. If a companion text file extracted from the same PDF is available, prefer using it as the readable source while treating the PDF as the original document.

Check the PDF content against every relevant requirement in this skill and in `references/introduction-framework.md`, including the background/problem chain, existing-method limitations, core idea, technical challenges, method mapping, contributions, and transitions.

If the PDF does not satisfy a requirement, list the issue explicitly for the user under a warning or reminder section. Each warning should name the missing or weak requirement, briefly explain what evidence was found or not found in the PDF, and state what the user should add, revise, or verify. Do not silently assume that missing PDF content exists elsewhere unless it is present in `introduction.md`.

## Core Loop

Follow this loop exactly:

1. Load the current memory from `introduction.md`.
2. Extract the Introduction logic into the framework sections:
   - Background & problem
   - Existing methods & limitations
   - Our core idea
   - Technical challenges
   - Our method
   - Summary contributions
   - Transition sentences
3. Check the memory against `references/introduction-framework.md`.
4. Identify the single most important missing or weak logical piece.
5. Ask the user one focused question.
6. When the user answers, update the matching section of `introduction.md`.
7. Re-run the check and repeat until the Introduction logic is complete enough to draft or revise prose.

Do not write a polished Introduction before the logic passes the framework check unless the user explicitly asks for a rough draft.

When the user asks for an outline, do not only list section contents. For each module, explicitly state what the module must prove, how it follows from the previous module, what transition point carries the reader into the next module, and which later method component or contribution it prepares. Introduction logic depends on the causal chain between modules, not only on local paragraph content.

## Memory Update Rules

When updating `introduction.md`:

- Preserve existing user-provided content.
- Add new answers under the most relevant section.
- Record unresolved issues under `## Open Questions`.
- Record key decisions under `## Confirmed Logic`.
- Mark weak or inferred content as `Needs verification`.
- Keep transition sentences visible, because the reference framework treats them as important links between paragraphs.
- Record user preferences about writing and interaction style under `## Confirmed Logic` or `## Revision State` when they affect later drafting.

Use concise Markdown. Do not hide uncertainty by rewriting it as a confident claim.

If the user proposes a claim, structure, or wording that appears logically weak, too broad, unsupported, or inconsistent with the current memory, raise the concern directly and briefly before accepting it. Offer a safer formulation or ask the minimum question needed to resolve the issue. Do not silently encode a questionable claim as settled logic.

## Question Policy

Ask one question at a time unless the user explicitly asks for a full checklist.

Prefer questions that force a logical decision:

- What exact problem makes the background important?
- Which existing method family fails, and why?
- What type of limitation is being addressed: scope, assumption, data, cost, robustness, interpretability, or evaluation?
- What is the core idea in one sentence?
- Why is the core idea non-trivial?
- Which technical challenge maps to which part of the method?
- Which contribution is a task, a method, a dataset, a theory result, or an empirical finding?

Avoid generic advice such as "make it clearer" or "add more detail." Ask for the missing premise.

Do not over-question. Once the central Introduction chain is coherent enough to draft, stop asking for fine-grained details such as dataset names, exact baseline lists, minor metric values, citation formatting, or implementation minutiae unless they are essential to the Introduction's main claim. Mark these as later polish items instead of blocking drafting.

Prefer stopping at the level of detail needed for a strong Introduction:

- The research area and concrete problem are clear.
- The limitation of existing methods motivates the core idea.
- The core idea is stated in one or two sentences.
- The technical challenges are few, real, and mapped to method components.
- The method has enough structure to explain how it addresses the challenges.
- Contributions include only claims the paper can support at Introduction level.

## Stop Conditions

The skill may proceed to drafting or revision when:

- Each required framework section has content.
- Existing-method limitations directly motivate the core idea.
- Each technical challenge has a corresponding method component.
- Contributions are specific and not duplicated.
- Transition sentences explain why each paragraph follows from the previous one.
- No central claim is marked `Needs verification`.

When these conditions are met, state clearly that the Introduction logic is ready for rough drafting or revision, and stop the Socratic questioning loop. Do not continue asking increasingly detailed questions just because more information could be useful later.

If these conditions are not met, keep asking for the single most important missing premise. If only non-central details remain, do not block drafting; record them as later polish items.

## Drafting Policy

When drafting a completed Introduction from the memory or from a user-provided prompt:

- Use the confirmed outline order unless the user explicitly asks to reorganize.
- Preserve user-specified English terms exactly when the user asks for exact wording.
- Keep the core idea concise; if requested, merge it with the technical-challenge paragraph.
- Use challenge labels only when the user wants them, and make each challenge map to a method component.
- Put summary contributions in a clear contribution list when requested.
- Avoid inventing unsupported numbers, dataset names, baseline names, citation keys, or implementation details.
- If the user's provided drafting prompt is too rigid, ambiguous, or mismatched to the current outline, briefly optimize it first, then generate using the optimized version.

## Optional Deterministic Check

For a quick structural check, run:

```powershell
powershell -ExecutionPolicy Bypass -File skills\introduction\scripts\check-introduction-memory.ps1 introduction.md
```

Use the script output as a helper only. The final judgment must still follow `references/introduction-framework.md`.
