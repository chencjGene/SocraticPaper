# SocraticPaper

SocraticPaper is a skill-first writing system for scientific papers. It is designed for researchers who do not want a passive writing assistant that only gives generic advice, but an active reasoning partner that can inspect the logic behind a paper section, challenge weak links, ask targeted follow-up questions, and keep iterating until the argument is coherent enough to write.


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

The current repository follows the actual skill layout below. Each skill is a self-contained folder under `skills/`, with a required `SKILL.md`, optional UI metadata in `agents/`, detailed section logic in `references/`, and deterministic helpers in `scripts/`.

```text
skills/
  introduction/
    SKILL.md
    agents/
    references/
    scripts/
```

The working memory for the Introduction skill lives at the project root:

```text
xx.md
```

## Planned Skill Categories

| Status | Skill | Purpose |
|---|---|---|
| Planned | `abstract` | Build a concise problem-gap-method-result-contribution chain. |
| Initial implementation | `introduction` | Maintain `introduction.md`, check Introduction logic, ask targeted questions, and update the memory after each answer. |
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

## Roadmap

- [x] Create the repository and initial project description.
- [x] Define the shared Socratic reasoning loop.
- [x] Implement the first `introduction` skill with an `introduction.md` memory file.
- [ ] Implement the first `abstract` skill.
- [ ] Add rubrics and question banks for each manuscript section.
- [ ] Add examples showing weak logic, follow-up questions, and improved outputs.
- [ ] Add tests or evaluation traces for whether a skill asks the right question.
- [ ] Expand to introduction, discussion, limitations, and reviewer response.

## Repository Status

This repository is at the concept and architecture stage. The first milestone is to turn the abstract workflow into a concrete skill that can be reused, tested, and improved.

## License

本项目采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 协议开源。
