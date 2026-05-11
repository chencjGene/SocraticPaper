# Introduction Framework

This framework is derived from the provided Feishu reference page. It defines how to judge whether an academic Introduction has enough logic to draft or revise.

## Required Structure

### 1. Background & Problem

Purpose: introduce the research background, explain why the problem matters, and lead into the paper's key considerations.

Required logic:

- Name the broader research area.
- State why the area matters in real applications or research.
- Identify the concrete problem that makes the paper necessary.
- End with a transition into the limitation or consideration that the paper will address.

Failure modes:

- The background is too broad and does not create pressure for the paper.
- The problem is only a topic label, not a real obstacle.
- The paragraph does not prepare the reader for the next paragraph.

### 2. Existing Methods & Their Limitations

Purpose: quickly tell the reader what class of problem the paper wants to solve and why existing approaches are insufficient.

Required logic:

- Group existing methods into meaningful families.
- Explain what problem they were designed to solve.
- Identify the limitation that matters for this paper.
- Make the limitation specific enough to motivate the core idea.

Reference pattern:

- Existing methods may solve cost or efficiency problems.
- However, they may model data distribution and focus on single-sample deviation.
- For anomalies defined by rules across multiple samples, this is insufficient.

Failure modes:

- Listing methods without explaining the limitation.
- Attacking all prior work too broadly.
- Giving a limitation that does not motivate the proposed idea.

### 3. Our Core Idea

Purpose: state the paper's central insight. This is often the most important part of the Introduction and may be merged with the method paragraph when appropriate.

Required logic:

- State the core idea in one sentence.
- Make clear how it responds to the limitation above.
- Avoid describing only implementation details.

Reference pattern:

- Mine anomaly-detection ideas from regulations.
- Use those ideas to guide the tabular anomaly detection process.

Failure modes:

- The core idea is just a system name.
- The core idea repeats the problem.
- The core idea is indistinguishable from existing methods.

### 4. Technical Challenges

Purpose: explain why the problem cannot be solved by a trivial method and show deep understanding of the pain points.

Required logic:

- Identify real technical obstacles.
- Avoid fake difficulty or ceremonial challenges.
- Make each challenge map to a later method component.

Reference pattern:

- Challenge 1, rule conversion: how to convert natural-language rules into executable detection ideas and retrieve anomalies from table data.
- Challenge 2, anomaly verification: not every generated detection idea is correct, so there must be a mechanism to verify whether detected cases are true anomalies.

Failure modes:

- Challenges are vague, such as "it is hard" or "data is complex."
- Challenges do not connect to the method.
- Challenges are actually evaluation goals, not technical obstacles.

### 5. Our Method

Purpose: explain how the paper solves the technical challenges.

Required logic:

- Name the proposed task, framework, model, or method.
- Map method components to the stated challenges.
- If there is a dataset, benchmark, theory result, or system module, state its role.

Reference pattern:

- Propose a new task: regulation-guided tabular anomaly detection.
- Provide datasets for evaluation.
- Use a multi-agent system to convert rules into SQL queries for Challenge 1.
- Use a distribution-analysis verification module for Challenge 2.
- Optionally formulate the process as a Budgeted Maximum Coverage problem with theoretical guarantees.

Failure modes:

- Method components appear before the challenges they solve.
- The method does not address all challenges.
- The paragraph becomes too detailed for an Introduction.

### 6. Summary Contributions

Purpose: summarize the concrete contributions of the paper.

Required logic:

- Separate contributions into distinct items.
- Make each contribution specific.
- Avoid repeating the same contribution with different wording.
- Include task, method, dataset, theoretical, and empirical contributions only when they are actually present.

Reference pattern:

- Propose a new regulation-guided tabular anomaly detection paradigm.
- Design an anomaly data verification method.
- Show significant advantages on multiple datasets and real scenarios.

Failure modes:

- Contributions are vague, such as "we improve performance."
- Contributions overclaim beyond the evidence.
- Contributions do not match earlier method or result sections.

## Transition Sentences

The reference emphasizes that transition sentences are important. In outlines, mark the sentence in each paragraph that carries the reader from the previous logic step to the next one.

Each paragraph should answer:

- Why does this paragraph follow from the previous one?
- What logical pressure does it create for the next paragraph?
- What exact phrase marks the transition?

If a paragraph has no transition sentence, ask the user to provide one before polishing.

## Completeness Rubric

Use this rubric for each section:

| Score | Meaning |
|---|---|
| 0 | Missing. |
| 1 | Present but vague, generic, or not connected to the next section. |
| 2 | Clear but still missing specificity, evidence, or transition. |
| 3 | Specific, logically connected, and ready for drafting. |

An Introduction is ready for drafting only when all required sections score at least 2 and the central chain from limitation to core idea to challenge to method is coherent.
