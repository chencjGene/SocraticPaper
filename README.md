# SocraticPaper

SocraticPaper is a small collection of Agent Skills for writing scientific papers through Socratic reasoning. Instead of polishing text first, the skills check whether a manuscript section has a defensible logic chain, then ask focused questions until it is ready to draft or revise.

Inspired by [scientific-research-skills](https://github.com/jxtse/scientific-research-skills), this repository is organized for both human researchers and AI agents.

## For Human

Use this repo when you want an AI writing partner to challenge the reasoning behind a paper section, not just rewrite sentences.

Current skills:

| Skill | Purpose | Main file it maintains |
|---|---|---|
| `introduction` | Builds and checks the logic of a paper Introduction. | `introduction.md` |
| `related-work` | Builds a scoped related-work corpus, taxonomy, and comparison logic. | `related-work.md` |

The user keeps final scientific judgment. The skills only help expose missing premises, weak claims, unsupported novelty, or transitions that do not yet hold.

## For AI

The current repository follows the actual skill layout below. Each skill is a self-contained folder under `skills/`, with a required `SKILL.md`, optional UI metadata in `agents/`, detailed section logic in `references/`, and deterministic helpers in `scripts/`.

```text
skills/
  introduction/
    SKILL.md
    agents/openai.yaml
    references/introduction-framework.md
    scripts/check-introduction-memory.ps1
  related-work/
    SKILL.md
    agents/openai.yaml
    references/related-work-framework.md
    scripts/check-related-work-memory.ps1
```

### Introduction Skill

When a user invokes the `introduction` skill:

1. Locate `introduction.md` in the workspace root; create it if missing.
2. Read `introduction.md` and `skills/introduction/references/introduction-framework.md`.
3. Extract the current Introduction logic into the required framework sections.
4. Find the single most important missing or weak logical piece.
5. Ask one focused question.
6. After the user answers, update `introduction.md` without deleting their original content.
7. Repeat until the logic is complete enough for rough drafting or revision.

The Introduction skill asks one important question at a time around:

- background and concrete problem
- existing methods and their limitations
- core idea
- technical challenges
- method components
- summary contributions
- transition sentences

Optional structural check:

```powershell
powershell -ExecutionPolicy Bypass -File skills\introduction\scripts\check-introduction-memory.ps1 introduction.md
```

### Related-Work Skill

When a user invokes the `related-work` skill:

1. Locate `related-work.md` in the workspace root; create it if missing.
2. Read `related-work.md` and `skills/related-work/references/related-work-framework.md`.
3. Require a scoped literature corpus before building comparisons.
4. Organize prior work with a two-layer n+m taxonomy.
5. Ask targeted comparison questions until the logic is specific enough to draft or revise.

Optional structural check:

```powershell
powershell -ExecutionPolicy Bypass -File skills\related-work\scripts\check-related-work-memory.ps1 related-work.md
```

Do not draft polished prose before the logic passes unless the user explicitly asks for a rough draft. Mark uncertain claims as `Needs verification` instead of turning them into confident statements.

## Planned Skill Categories

| Status | Skill | Purpose |
|---|---|---|
| Planned | `abstract` | Build a concise problem-gap-method-result-contribution chain. |
| Initial implementation | `introduction` | Maintain `introduction.md`, check Introduction logic, ask targeted questions, and update the memory after each answer. |
| Initial implementation | `related-work` | Maintain `related-work.md`, require a scoped corpus, organize prior work with a two-layer n+m taxonomy, and ask targeted comparison questions. |
| Planned | `methods` | Check whether methods are reproducible, justified, and aligned with the question. |
| Planned | `results` | Separate observation, analysis, and interpretation. |
| Planned | `discussion` | Connect findings to implications while avoiding overclaiming. |
| Planned | `limitations` | Make limitations specific, honest, and useful rather than ceremonial. |
| Planned | `review-response` | Turn reviewer comments into structured revisions and evidence-backed replies. |

## Usage

Invoke a skill directly, such as `socratic-introduction` or `socratic-related-work`. The model can start from basic questions or inspect existing material first, then ask targeted follow-up questions based on what is missing, unclear, or logically weak.

Skill working memory is saved at the repository root, such as `introduction.md` or `related-work.md`, so later sessions can continue from the existing state.

## Roadmap

- [x] Create the repository and initial project description.
- [x] Define the shared Socratic reasoning loop.
- [x] Implement the first `introduction` skill with an `introduction.md` memory file.
- [x] Implement the first `related-work` skill with corpus, taxonomy, and comparison checks.
- [ ] Implement the first `abstract` skill.
- [ ] Add rubrics and question banks for each manuscript section.
- [ ] Add examples showing weak logic, follow-up questions, and improved outputs.
- [ ] Add tests or evaluation traces for whether a skill asks the right question.
- [ ] Expand to methods, results, discussion, limitations, and reviewer response.

## Repository Status

This repository is at the concept and architecture stage. The first milestones are turning the abstract workflow into concrete skills that can be reused, tested, and improved.

## License

本项目采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 协议开源。
