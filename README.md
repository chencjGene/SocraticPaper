# SocraticPaper

SocraticPaper is a skill-first writing system for scientific papers. It is designed for researchers who do not want a passive writing assistant that only gives generic advice, but an active reasoning partner that can inspect the logic behind a paper section, challenge weak links, ask targeted follow-up questions, and keep iterating until the argument is coherent enough to write.

The project is inspired by the skill-oriented structure of [Awesome Scientific Skills](https://github.com/InternScience/Awesome-Scientific-Skills), but focuses on one narrower problem: building Socratic, section-specific skills for paper writing.

## Problem

Many AI writing tools help with wording, polishing, outlining, or template-based drafting. Those tools are useful, but they are often static. They may tell a researcher what an abstract, introduction, or discussion should contain, yet they usually do not maintain a rigorous model of the paper's underlying argument.

SocraticPaper starts from a different assumption: good scientific writing is not only a language-generation problem. It is a logic-construction problem.

A paper section should make a set of claims, connect those claims to evidence, identify why the claims matter, and avoid overclaiming beyond the available data. If that logic is missing, vague, circular, or unsupported, the system should not simply rewrite the paragraph. It should ask.

## Goal

SocraticPaper aims to build a collection of paper-writing skills that behave like Socratic reviewers. Each skill focuses on one part of a manuscript, such as the abstract, introduction, related work, methods, results, discussion, limitations, or response to reviewers.

The core loop is:

1. Extract the current logical structure from the user's draft or notes.
2. Check whether the logic satisfies the expectations of that paper section.
3. Identify missing premises, unsupported claims, unclear novelty, weak causal links, or mismatched evidence.
4. Ask targeted questions instead of silently filling gaps.
5. Evaluate the user's answer and decide whether it resolves the logical issue.
6. Continue asking until the section is logically stable enough to draft or revise.

The system should not pretend that a paper is sound because the prose is fluent. It should make the reasoning visible.

## What Makes It Different

| Feature | What it means |
|---|---|
| Socratic by default | The assistant asks when the logic is incomplete instead of inventing missing arguments. |
| Section-specific skills | Each manuscript section has its own standards, checks, and question strategy. |
| Logic before prose | The system validates claims, evidence, novelty, scope, and contribution before polishing language. |
| Iterative reasoning loop | A skill can repeatedly challenge, absorb, and re-check the user's answers. |
| Researcher-in-the-loop | The user remains responsible for scientific judgment; the skill helps expose what must be decided. |
| Skill-first architecture | The project is organized as reusable agent skills rather than one monolithic prompt. |

## Skill Architecture

Each skill should be a small, focused reasoning module with a clear manuscript target.

```text
skills/
  abstract/
    SKILL.md
    rubric.md
    question_bank.md
    examples.md
  introduction/
    SKILL.md
    rubric.md
    question_bank.md
    examples.md
  discussion/
    SKILL.md
    rubric.md
    question_bank.md
    examples.md
```

Every section skill should define:

| Component | Purpose |
|---|---|
| Section contract | What this paper section must accomplish. |
| Logic schema | The expected structure of claims, evidence, gap, novelty, and contribution. |
| Validation rules | How the skill detects weak or missing reasoning. |
| Question policy | How the skill asks precise follow-up questions. |
| Satisfaction criteria | When the skill can stop asking and proceed to drafting or revision. |
| Failure modes | Common problems such as vague novelty, unsupported claims, or result-conclusion mismatch. |

## Example: Abstract Skill

The abstract skill should not begin by writing an abstract. It should first test whether the abstract has a defensible logic.

An abstract usually needs:

1. Background: what problem space the paper belongs to.
2. Gap: what remains unknown, unresolved, inefficient, or poorly explained.
3. Objective: what the paper tries to establish or solve.
4. Method: what approach was used.
5. Result: what was found.
6. Contribution: why the result matters.
7. Scope: what the paper does not claim.

The skill should ask questions such as:

- What is the exact research gap, and who currently feels this gap?
- Is the objective a response to that gap, or merely a description of the method?
- Which result directly supports the main claim?
- Does the contribution follow from the result, or does it overreach?
- What must be excluded from the abstract to avoid claiming too much?

Only after those questions are answered should the skill produce or revise the abstract.

## Planned Skill Categories

| Status | Skill | Purpose |
|---|---|---|
| Planned | `abstract` | Build a concise problem-gap-method-result-contribution chain. |
| Planned | `introduction` | Clarify motivation, literature gap, research question, and paper contribution. |
| Planned | `related-work` | Position the paper against prior work without turning into a list summary. |
| Planned | `methods` | Check whether methods are reproducible, justified, and aligned with the question. |
| Planned | `results` | Separate observation, analysis, and interpretation. |
| Planned | `discussion` | Connect findings to implications while avoiding overclaiming. |
| Planned | `limitations` | Make limitations specific, honest, and useful rather than ceremonial. |
| Planned | `review-response` | Turn reviewer comments into structured revisions and evidence-backed replies. |

## Interaction Pattern

A typical session should feel like this:

```text
User: Here are my notes for the abstract.

SocraticPaper:
I see a proposed method and a claimed contribution, but the gap is still implicit.
Before writing, I need to know: what existing approach fails, and why does that failure matter?

User: Existing tools can summarize papers, but they do not test whether the argument is logically sound.

SocraticPaper:
That is closer. Is your contribution a new writing interface, a logic-checking framework, or a set of section-specific skills?

User: A set of section-specific skills with an iterative logic-checking loop.

SocraticPaper:
Good. Now the abstract can claim a skill-based Socratic writing system, not a general writing assistant.
```

## Design Principles

- Ask before inventing.
- Validate reasoning before improving style.
- Prefer precise questions over broad advice.
- Keep each skill small enough to inspect and improve.
- Make stopping conditions explicit.
- Treat paper writing as an argument-building process.
- Preserve the researcher's agency and domain judgment.

## Roadmap

- [x] Create the repository and initial project description.
- [ ] Define the shared Socratic reasoning loop.
- [ ] Implement the first `abstract` skill.
- [ ] Add rubrics and question banks for each manuscript section.
- [ ] Add examples showing weak logic, follow-up questions, and improved outputs.
- [ ] Add tests or evaluation traces for whether a skill asks the right question.
- [ ] Expand to introduction, discussion, limitations, and reviewer response.

## Repository Status

This repository is at the concept and architecture stage. The first milestone is to turn the abstract workflow into a concrete skill that can be reused, tested, and improved.

## License

License to be decided.
