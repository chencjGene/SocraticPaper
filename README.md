# SocraticPaper

SocraticPaper is a small collection of Agent Skills for writing scientific papers through Socratic reasoning. Instead of polishing text first, the skills check whether a manuscript section has a defensible logic chain, then ask focused questions until it is ready to draft or revise.

Inspired by [scientific-research-skills](https://github.com/jxtse/scientific-research-skills), this repository is organized for both human researchers and AI agents.

## For Human

Use this repo when you want an AI writing partner to challenge the reasoning behind a paper section, not just rewrite sentences.

Current skill:

| Skill | Purpose | Main file it maintains |
|---|---|---|
| `introduction` | Builds and checks the logic of a paper Introduction. | `introduction.md` |

The Introduction skill asks one important question at a time around:

- background and concrete problem
- existing methods and their limitations
- core idea
- technical challenges
- method components
- summary contributions
- transition sentences

The user keeps final scientific judgment. The skill only helps expose missing premises, weak claims, unsupported novelty, or transitions that do not yet hold.

## For AI

When a user invokes the `introduction` skill:

1. Locate `introduction.md` in the workspace root; create it if missing.
2. Read `introduction.md` and `skills/introduction/references/introduction-framework.md`.
3. Extract the current Introduction logic into the required framework sections.
4. Find the single most important missing or weak logical piece.
5. Ask one focused question.
6. After the user answers, update `introduction.md` without deleting their original content.
7. Repeat until the logic is complete enough for rough drafting or revision.

Do not draft polished prose before the logic passes unless the user explicitly asks for a rough draft. Mark uncertain claims as `Needs verification` instead of turning them into confident statements.

Optional structural check:

```powershell
powershell -ExecutionPolicy Bypass -File skills\introduction\scripts\check-introduction-memory.ps1 introduction.md
```

## Structure

```text
skills/
  introduction/
    SKILL.md
    agents/openai.yaml
    references/introduction-framework.md
    scripts/check-introduction-memory.ps1
```

## Status

Implemented:

- `introduction`

Planned:

- `abstract`
- `related-work`
- `methods`
- `results`
- `discussion`
- `limitations`
- `review-response`

## License

License to be decided.
