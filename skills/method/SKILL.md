---
name: method
description: Socratic paper-method workflow for maintaining and improving a `method.md` thinking-memory file. Use when the user invokes Method or Methodology writing, asks to formalize a method, wants module/sub-module logic checking, or needs iterative questions before drafting a precise Method section.
---

# Method

Use this skill to run an iterative Socratic workflow for a paper Method section.

## Required Files

At the start of every invocation:

1. Locate `method.md` in the current workspace root.
2. If it does not exist, create it from the template structure in this skill.
3. Read the full `method.md` file before giving advice.
4. Read `references/method-framework.md` before judging completeness.
5. If `introduction.md` exists, read it as paper context for the method goal and claimed contributions.
6. If the user provides preliminary material, reference papers, formulas, or answers in chat, persist them into `method.md` before using them as settled context.

Treat `method.md` as the shared thinking memory between the user and the agent. It should contain problem formulation, preliminary/background decisions, prerequisites, method overview, two-layer chains, module plans, sub-module descriptions, formula-level definitions, the mathematical symbol table, unresolved questions, and revision state.

## PDF Input Check

If the user provides a PDF, extract or read its text before judging the Method section. If a companion text file extracted from the same PDF is available, prefer using it as the readable source while treating the PDF as the original document.

Check the PDF content against every relevant requirement in this skill and in `references/method-framework.md`, including problem formulation, input/output definitions, prerequisites, preliminary/background decision, method overview, first-layer and second-layer chains, module plans, sub-module descriptions, formula-level specifications, and mathematical symbol consistency.

If the PDF does not satisfy a requirement, list the issue explicitly for the user under a warning or reminder section. Each warning should name the missing or weak requirement, briefly explain what evidence was found or not found in the PDF, and state what the user should add, revise, or verify. Do not silently assume that missing PDF content exists elsewhere unless it is present in `method.md`.

## Persistence Contract

All durable state for this skill must live in `method.md`.

- At the start of each invocation, read `method.md` first and continue from its current content.
- During the session, every user-provided problem statement, input/output definition, preliminary note, reference paper, overview, module name, motivation, basic idea, step description, chain decision, sub-module description, formula, symbol definition, correction, draft note, and unresolved issue must be written back into `method.md`.
- Do not rely on chat history as the source of truth after the current turn. If information matters for the next run, persist it in `method.md`.
- If the user provides content in chat instead of editing the file directly, parse the chat content and add it to the appropriate section of `method.md` before continuing.
- If the user corrects or rejects an assistant-proposed problem formulation, background decision, module plan, chain, formula, or symbol, update `method.md` to reflect the accepted decision and keep the rejected proposal only if it helps explain an open question.
- Do not provide a substantive outline, critique, draft, or next-step plan based only on chat memory. First make the relevant information durable in `method.md`, then reason from the file.

## Memory Template

Create `method.md` with this structure if it is missing:

```markdown
# Method Memory

## Problem Formulation

### Problem Statement

### Model Input

### Model Output

### Formulation Notes

## Prerequisites

### Preliminary Material

### Reference Papers

## Preliminary / Background

### Background Decision

### Baseline Or Complex Concept

### Contribution Boundary

## Method Overview / Framework

### Major Modules

### Module Dependency Overview

## First-Layer Chain

## Module Plans

## Second-Layer Chains

## Sub-Module Descriptions

## Formula-Level Specifications

## Mathematical Symbol Table

| Symbol | Meaning | Type/Shape/Domain | First Defined In | Reused Elsewhere | Status |
|---|---|---|---|---|---|

## Logic Checks

## Confirmed Logic

## Open Questions

## Draft Notes
```

## Non-Negotiable Prerequisites

This skill works only after the user has provided:

1. A problem formulation, including the model input and output.
2. Preliminary material, or at least reference papers whose method structure can be used as grounding.
3. An overview of the entire proposed method.

If the problem formulation is missing, do not build the method outline or draft the section. Ask the user to provide the problem, model input, and model output. For beginners, default to creating a `Problem Formulation` section or subsection, and suggest grounding it in one strongly related top-tier paper without copying wording.

If preliminary material or reference papers and the method overview are both missing, do not build the method outline or draft the section. Ask the user to provide either preliminary notes or reference papers, plus a short overview of the method.

If preliminary material or reference papers are present but the method overview is missing, ask for the overview first. The overview should state the task input, final output, major modules, and the core reason the modules must appear in that order.

If the method overview exists but the preliminary/reference grounding is missing, ask the user to provide preliminary notes or 1 to 3 reference papers and explain which parts should be borrowed as structure rather than copied as claims.

## Section Skeleton Policy

Use the following Method-section skeleton as the default unless the user or target venue clearly requires another structure:

1. `Problem Formulation`: clearly introduce the problem, model input, and model output. If short, this may be the first subsection of `Method`.
2. `Preliminary` or `Background`: include only when there are many complex concepts or when the method strongly depends on a specific baseline that must be explained before the contribution can be understood.
3. `Overview` or `Framework`: summarize the whole method, list the major modules, and explain how modules depend on each other.
4. `Module 1`, `Module 2`, `Module 3`, or `Joint Optimization`: present each module as a named subsection whose title aligns with the Introduction's technical challenges and contributions.

When deciding whether to create a separate preliminary/background section, use this rule: if the proposed method strongly depends on one specific method, and that method is complex enough that its process must be described to explain the contribution, create a preliminary/background section. Otherwise, keep background compact and reserve space for the user's contribution.

## Core Loop

Follow this loop exactly:

1. Load the current memory from `method.md`.
2. Check the non-negotiable prerequisites.
3. Extract the problem formulation:
   - problem statement
   - model input
   - model output
   - whether it should be its own section or the first Method subsection
4. Decide whether a separate preliminary/background section is needed.
5. Extract the method overview/framework:
   - major modules
   - module dependencies
   - how module names align with technical contributions
6. Extract the first-layer method chain:
   - `Input -> Module 1 -> Intermediate State 1 -> Module 2 -> Intermediate State 2 -> ... -> Output`
7. For each module in the first-layer chain, create or update a module plan:
   - final subsection title
   - design motivation
   - basic idea
   - detailed steps
   - corresponding technical challenge or contribution
8. For each module in the first-layer chain, extract one second-layer chain:
   - `Module Input -> Sub-module 1 -> Intermediate State 1 -> Sub-module 2 -> Intermediate State 2 -> ... -> Module Output`
9. Check whether every node and edge in both layers can be expressed at formula-level precision.
10. For every sub-module in the second-layer chain, require the user to first provide a plain-language description of how it works.
11. Convert the user's plain-language sub-module description into a precise logical and mathematical specification.
12. If the plain-language description is too vague to formalize, ask for the exact formula needed for the specific transformation from that sub-module's input to output.
13. Update the mathematical symbol table.
14. Check whether any symbol is reused for multiple meanings, shapes, domains, or scopes.
15. Identify the single most important missing or weak logical piece.
16. Ask the user one focused question.
17. When the user answers, update the matching section of `method.md`.
18. Re-run the check and repeat until the Method logic is complete enough to draft or revise prose.

Do not write a polished Method section before problem formulation, prerequisites, overview/framework, module plans, both chain layers, formula-level specifications, and symbol consistency pass the framework check unless the user explicitly asks for a rough draft.

## Problem Formulation Policy

By default, require a `Problem Formulation` section or subsection.

It must clearly state:

- What problem the paper solves.
- The model input.
- The model output.
- Any important data structure, setting, assumption, or objective needed before Method details begin.

For beginners, recommend using one strongly related top-tier paper as a structural reference for the formulation, while avoiding copied wording, copied notation, or unsupported assumptions.

If the formulation is short, it may be merged as the first subsection under `Method`. If the task, notation, or input/output objects are complex, keep it as a separate section before the Method overview.

## Preliminary / Background Policy

Create a separate `Preliminary` or `Background` section only when it reduces confusion.

Use a separate section when:

- The method depends heavily on a specific baseline.
- The baseline or concept is complex enough that its process must be described before the contribution makes sense.
- Several definitions or concepts would otherwise interrupt the contribution-focused module sections.

Do not let preliminary material swallow the contribution. Its job is to explain the inherited concept or baseline, so that the later Method subsections can focus on what is new.

Record the decision under `## Preliminary / Background`, including whether the section is needed, what baseline or concept it covers, and where the contribution begins.

## Overview / Framework Policy

The overview/framework subsection must first organize the whole method before diving into details.

It must:

- Name the major modules.
- Explain the dependency between modules.
- State the first-layer chain in words and symbols.
- Make clear how each module corresponds to a technical challenge or contribution from the Introduction when that context exists.
- Prepare the reader for the later module subsections.

Do not treat the overview as a vague summary. It should be a map of the method's modules and their relationships.

## Module Plan Rules

Every module subsection must have a plan before drafting.

For each module, record:

- Final module name and subsection title.
- Which advanced technique the name signals, if any, such as `kernel graph network`.
- Which innovation the name signals, if any, such as `prior-aware bi-channel`.
- Which technical challenge, design difficulty, or contribution it corresponds to.
- Design motivation: why this module is needed, what the naive or direct solution would be, and why that direct solution is insufficient.
- Basic idea: the high-level solution, why it addresses the motivation, and what is borrowed or adapted from an advanced method.
- Detailed steps: Step 1, Step 2, Step 3, and so on, each mapped to a sub-module or transformation.

Module names should not be generic labels such as `Feature Module` if the method has a more specific technical identity. A strong module name should reveal both the main technique and the paper's innovation when possible.

## Chain Construction Rules

The Method outline must be built from two nested chains, not from a flat list of modules.

First-layer chain:

```text
Input -> Module 1 -> Intermediate State 1 -> Module 2 -> Intermediate State 2 -> ... -> Output
```

Second-layer chain for each module:

```text
Module Input -> Sub-module 1 -> Intermediate State 1 -> Sub-module 2 -> Intermediate State 2 -> ... -> Module Output
```

For every node in either chain, record:

- Name.
- Mathematical symbol.
- Type, shape, or domain.
- Whether it is input, intermediate state, module output, or final output.
- Where it is first introduced.

For every edge in either chain, record:

- Transformation name.
- Input symbols.
- Output symbols.
- Required assumptions.
- Formula, objective, algorithmic step, or decision rule.
- Why this transformation is necessary for the next step.

If a module or sub-module cannot name its exact input and output, treat it as incomplete and ask for that missing link before drafting.

## Sub-Module Description Policy

For each second-layer sub-module, the user must first give a plain-language description of how it works.

After receiving the description:

- Restate the sub-module as a transformation from specific input symbols to specific output symbols.
- Check whether the described operation logically produces the claimed output.
- Check whether the output type and shape match the next sub-module's input.
- Check whether assumptions are explicit.
- Check whether a formula, optimization objective, probabilistic model, algorithmic rule, or pseudocode step is needed.

If the description is hard to formalize, ask for a formula in a specific form:

```text
For sub-module <name>, please provide the formula that maps <input symbol and meaning> to <output symbol and meaning>.
```

Do not ask generically for "more math." Ask for the exact missing transformation.

## Mathematical Symbol Table Rules

Maintain `## Mathematical Symbol Table` every time `method.md` changes.

Every formula-level object must have one row:

| Symbol | Meaning | Type/Shape/Domain | First Defined In | Reused Elsewhere | Status |
|---|---|---|---|---|---|

Symbol rules:

- One symbol must not represent multiple meanings.
- One meaning should not be assigned multiple symbols unless there is a clear scope distinction.
- Reused symbols must keep the same type, shape, and domain.
- If a symbol changes meaning across modules, mark it as `Conflict` and ask the user to choose one meaning or rename one occurrence.
- Do not silently repair a conflict by renaming symbols without telling the user.
- Prefer conventional notation only when it does not conflict with already accepted notation.

Before every draft or outline update, explicitly check the symbol table for duplicated symbols, inconsistent shapes, missing definitions, and unintroduced variables in formulas.

## Memory Update Rules

When updating `method.md`:

- Preserve existing user-provided content.
- Persist all user-provided chat content that affects the Method before using it for reasoning.
- Add problem statement, input, and output under `## Problem Formulation`.
- Persist prerequisites before building chains.
- Add preliminary notes and reference papers under `## Prerequisites`.
- Add the preliminary/background decision under `## Preliminary / Background`.
- Add the overview and major module dependencies under `## Method Overview / Framework`.
- Add or revise the first-layer chain under `## First-Layer Chain`.
- Add module titles, motivations, basic ideas, and step plans under `## Module Plans`.
- Add or revise each module's second-layer chain under `## Second-Layer Chains`.
- Add user plain-language descriptions under `## Sub-Module Descriptions`.
- Add accepted formulas and algorithmic details under `## Formula-Level Specifications`.
- Keep the mathematical symbol table current.
- Record unresolved issues under `## Open Questions`.
- Record accepted chain, formula, and notation decisions under `## Confirmed Logic`.
- Mark weak, inferred, or unverified transformations as `Needs verification`.

Use concise Markdown. Do not hide uncertainty by rewriting it as a confident formula.

## Question Policy

Ask one question at a time unless the user explicitly asks for a full checklist.

Prefer questions that force a precise method decision:

- What preliminary notes or reference papers should ground this Method section?
- What is the problem formulation: problem, model input, and model output?
- Should the problem formulation be a standalone section, or the first Method subsection?
- Does the method depend on a complex baseline or concept that deserves a separate Preliminary/Background section?
- What is the whole-method overview: task input, final output, major modules, and why this order?
- What should this module be called so the title reflects both the advanced technique and your innovation?
- What design difficulty or technical challenge motivates this module?
- What is the naive/direct solution, and why is it insufficient?
- What is the module's basic idea?
- What are Step 1, Step 2, and Step 3 inside this module?
- What is the exact input and output of Module 1?
- What intermediate state does this module create for the next module?
- For this module, what are the sub-modules in order?
- For this sub-module, how does it transform its input into its output in plain language?
- Which formula maps this input symbol to this output symbol?
- What assumption must hold for this transformation to be valid?
- Does this symbol keep the same meaning and shape in every module?

Avoid generic advice such as "make the method clearer." Ask for the missing input, output, transformation, formula, assumption, or symbol decision.

## Stop Conditions

The skill may proceed to drafting or revision when:

- The problem formulation is present and includes model input and output.
- Preliminary material or reference papers are present.
- The preliminary/background decision is recorded.
- The whole-method overview is present.
- Major modules are named and their dependencies are clear.
- Every module has a title, design motivation, basic idea, and detailed step plan.
- The first-layer chain is complete from input to final output.
- Every first-layer module has a second-layer chain.
- Every sub-module has a user-provided plain-language description.
- Every sub-module has a formula-level specification, algorithmic rule, or explicitly justified non-formula operation.
- Every intermediate state has a symbol, meaning, type/shape/domain, and role in the next step.
- The mathematical symbol table has no conflicts, missing definitions, or unintroduced formula variables.
- No central transformation is marked `Needs verification`.

If these conditions are met, state clearly that the Method logic is ready for rough drafting or revision, and stop the Socratic questioning loop.

## Drafting Policy

When drafting a completed Method section:

- Start with `Problem Formulation`, either as a separate section or as the first Method subsection, according to the recorded decision.
- Include `Preliminary` or `Background` only if `method.md` records that it is needed.
- Use the accepted overview/framework to introduce major modules and their dependencies before detailed module subsections.
- Follow the accepted first-layer chain as the subsection order unless the user asks for another structure.
- Use module names from `## Module Plans`, keeping subsection titles aligned with the Introduction's technical contributions when available.
- For each module, explain design motivation first, then basic idea, then detailed steps.
- For each module, introduce its input and output before explaining sub-modules.
- Define each symbol before using it in formulas.
- Keep notation consistent with `## Mathematical Symbol Table`.
- State assumptions close to the transformation that depends on them.
- Use formulas for core transformations and concise prose for implementation details.
- Do not invent unsupported modules, losses, constraints, hyperparameters, datasets, or guarantees.
- If reference papers are used, borrow only structural inspiration unless the user confirms the same assumptions and formulas apply.

## Optional Deterministic Check

For a quick structural check, run:

```powershell
powershell -ExecutionPolicy Bypass -File skills\method\scripts\check-method-memory.ps1 method.md
```

Use the script output as a helper only. The final judgment must still follow `references/method-framework.md`.
