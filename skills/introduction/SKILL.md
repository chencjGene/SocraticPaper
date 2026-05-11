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

## Memory Update Rules

When updating `introduction.md`:

- Preserve existing user-provided content.
- Add new answers under the most relevant section.
- Record unresolved issues under `## Open Questions`.
- Record key decisions under `## Confirmed Logic`.
- Mark weak or inferred content as `Needs verification`.
- Keep transition sentences visible, because the reference framework treats them as important links between paragraphs.

Use concise Markdown. Do not hide uncertainty by rewriting it as a confident claim.

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

## Stop Conditions

The skill may proceed to drafting or revision when:

- Each required framework section has content.
- Existing-method limitations directly motivate the core idea.
- Each technical challenge has a corresponding method component.
- Contributions are specific and not duplicated.
- Transition sentences explain why each paragraph follows from the previous one.
- No central claim is marked `Needs verification`.

If these conditions are not met, keep asking.

## Optional Deterministic Check

For a quick structural check, run:

```powershell
powershell -ExecutionPolicy Bypass -File skills\introduction\scripts\check-introduction-memory.ps1 introduction.md
```

Use the script output as a helper only. The final judgment must still follow `references/introduction-framework.md`.
