# Method Framework

This framework defines how to judge whether an academic Method section has enough logical and mathematical precision to draft or revise.

## Purpose

A Method section has six jobs:

1. Formulate the problem clearly, including model input and output.
2. Decide whether complex background or a baseline needs a separate preliminary section.
3. Tell the reader what the method receives and produces.
4. Explain why the method is decomposed into this order of modules.
5. Make every module and sub-module reproducible at formula, objective, rule, or algorithm level.
6. Maintain notation consistently so that formulas do not become ambiguous.

The section should not become a high-level system diagram with missing transformations. Its logic depends on precise chains from input to output.

## Required Structure

### 1. Problem Formulation

Purpose: define the paper's exact problem before explaining the solution.

Required logic:

- Clearly state what problem the paper solves.
- Define the model input.
- Define the model output.
- Introduce core objects, assumptions, and task setting needed by the Method section.
- Decide whether the formulation should be a standalone section or the first subsection of Method.

Beginner guidance:

- Default to writing a problem formulation.
- Use one strongly related top-tier paper as a structural reference when possible, while avoiding copied wording, copied notation, or unsupported assumptions.

Failure modes:

- The Method begins with modules before the task input and output are clear.
- The input/output objects are described verbally but never formalized.
- The formulation borrows notation from a reference paper without checking whether the assumptions match this paper.

### 2. Prerequisites

Purpose: ensure the method is grounded before formalization begins.

Required logic:

- Provide preliminary notes, experimental setup, proof sketch, system notes, or reference papers.
- Provide a whole-method overview.
- State which parts of reference papers are structural inspiration and which parts are directly adopted.

Failure modes:

- The method is formalized from vague memory only.
- Reference papers are named but their role is unclear.
- The overview names modules without explaining input, output, or order.

### 3. Preliminary / Background

Purpose: isolate complex inherited concepts or baseline processes so that the contribution-focused method subsections stay clear.

Required logic:

- Decide whether a separate preliminary/background section is needed.
- Create one when the method strongly depends on a specific baseline or complex concept.
- Explain the baseline or concept only to the level needed for the later contribution.
- Mark the boundary between inherited background and the paper's contribution.

Failure modes:

- Complex baseline details are mixed into the contribution, making novelty ambiguous.
- A separate preliminary section repeats generic textbook background that is not needed.
- The background section becomes longer than the contribution-oriented Method subsections.

### 4. Overview / Framework

Purpose: define the global task and the intended path from input to output.

Required logic:

- State the task input.
- State the final output.
- Name the major modules.
- Explain why these modules appear in this order.
- Identify the core idea that makes the decomposition necessary.
- Explain module dependencies before presenting details.
- Align module names with technical challenges and contributions from the Introduction when available.

Failure modes:

- The overview is a list of components rather than a transformation chain.
- The final output does not match the paper's claimed task.
- The module order is arbitrary.
- The overview does not prepare the reader for the module subsections.

### 5. Module Plans

Purpose: ensure each Method subsection is motivated, named, and structured before drafting.

Required logic for each module:

- Final module name and subsection title.
- The advanced technique signaled by the name, if any.
- The paper's innovation signaled by the name, if any.
- The technical challenge, design difficulty, or contribution it addresses.
- Design motivation: why the module is needed, what the naive/direct solution would be, and why that solution is insufficient.
- Basic idea: the high-level solution and why it addresses the motivation.
- Detailed steps: Step 1, Step 2, Step 3, and so on, mapped to sub-modules or transformations.

Naming guidance:

- Prefer names that reveal both a recognizable technical basis and the paper's innovation, such as a name combining an advanced technique with a novel qualifier.
- Avoid generic titles when the module has a specific mechanism or contribution.

Failure modes:

- A module subsection starts with formulas before explaining why the module is needed.
- The module title is generic and does not match the Introduction's technical contribution.
- The basic idea is missing, so the detailed steps feel arbitrary.
- Steps are listed but not connected to sub-modules or formula-level transformations.

### 6. First-Layer Chain

Purpose: make the whole method inspectable as a formula-level sequence.

Required pattern:

```text
Input -> Module 1 -> Intermediate State 1 -> Module 2 -> Intermediate State 2 -> ... -> Output
```

For every node:

- Name the object.
- Assign a symbol.
- Define type, shape, or domain.
- State whether it is input, intermediate state, or output.

For every module:

- State input symbols and output symbols.
- State the transformation performed.
- State the formula-level requirement.
- Explain why this output is needed by the next module.

Failure modes:

- A module has no clearly defined input or output.
- An intermediate state is only verbal and has no symbol or type.
- The chain has a hidden jump where one output cannot serve as the next input.

### 7. Second-Layer Chains

Purpose: make each major module reproducible rather than ornamental.

Required pattern for each module:

```text
Module Input -> Sub-module 1 -> Intermediate State 1 -> Sub-module 2 -> Intermediate State 2 -> ... -> Module Output
```

For every sub-module:

- Start from the user's plain-language description.
- Restate the exact input-to-output transformation.
- Check whether the logic actually produces the claimed output.
- Add formula, objective, algorithmic rule, or pseudocode-level operation.
- Verify that output type and shape match the next sub-module input.

Failure modes:

- The assistant invents formulas before the user explains the mechanism.
- A sub-module is a label, such as "feature extraction," with no operation.
- A sub-module output is not consumed by any later step.
- The second-layer chain contradicts the first-layer module input or output.

### 8. Formula-Level Specification

Purpose: ensure the Method section is reproducible and mathematically precise.

Required logic:

- Every central transformation has a formula, objective, decision rule, algorithmic step, or explicitly justified non-formula operation.
- All formula variables are introduced before use.
- Assumptions are stated next to the transformation that needs them.
- Shapes and domains are consistent across transformations.

Failure modes:

- The method uses mathematical symbols without definitions.
- The formula produces an object with the wrong shape.
- A loss, score, or constraint is introduced without explaining how it is optimized or used.
- Important choices are hidden as "we process" or "we obtain."

### 9. Mathematical Symbol Table

Purpose: prevent ambiguity caused by notation reuse.

Required table:

| Symbol | Meaning | Type/Shape/Domain | First Defined In | Reused Elsewhere | Status |
|---|---|---|---|---|---|

Required logic:

- Every formula-level object appears in the table.
- One symbol has one meaning within its declared scope.
- Reuse across modules preserves meaning, type, shape, and domain.
- Conflicts are marked and resolved before drafting.

Failure modes:

- The same symbol means dataset size in one module and number of agents in another.
- The same symbol changes shape after a transformation without being renamed or indexed.
- A formula contains variables absent from the table.
- The assistant silently renames symbols without user confirmation.

## Completeness Rubric

Use this rubric for each section:

| Score | Meaning |
|---|---|
| 0 | Missing. |
| 1 | Present but vague, verbal, or not connected to adjacent transformations. |
| 2 | Clear but still missing formula precision, assumptions, or notation checks. |
| 3 | Specific, formula-level, logically connected, and ready for drafting. |

A Method section is ready for drafting only when problem formulation, prerequisites, preliminary/background decision, overview/framework, module plans, both chain layers, sub-module mechanisms, and the symbol table are complete enough to support a precise draft.
