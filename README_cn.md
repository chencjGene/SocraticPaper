# SocraticPaper

SocraticPaper 是一个以 skill 为核心的科研论文写作系统。它面向那些不想要被动写作助手的研究者：这个系统不会只给出泛泛的建议，而是作为一个主动的推理伙伴，检查论文某一部分背后的逻辑，挑战薄弱环节，提出有针对性的追问，并持续迭代，直到论证足够连贯，可以进入写作。


## 目标

SocraticPaper 旨在构建一组像苏格拉底式审稿人一样工作的论文写作 skills。每个 skill 聚焦于论文的一个部分，例如摘要、引言、相关工作、方法、结果、讨论、局限性，或审稿回复。

核心循环如下：

1. 从用户的草稿或笔记中提取当前的逻辑结构。
2. 检查该逻辑是否符合对应论文部分的要求。
3. 识别缺失的前提、缺乏支撑的主张、不清楚的创新点、薄弱的因果链条，或不匹配的证据。
4. 提出有针对性的问题，而不是默默替用户填补空缺。
5. 评估用户的回答，并判断它是否解决了对应的逻辑问题。
6. 持续追问，直到该部分在逻辑上足够稳定，可以进行起草或修改。

这个系统不应该因为文字流畅就假装论文是可靠的。它应该让推理过程变得可见。

## 有何不同

| 特性 | 含义 |
|---|---|
| 默认苏格拉底式 | 当逻辑不完整时，助手会提问，而不是编造缺失的论证。 |
| 面向论文章节的 skills | 每个论文章节都有自己的标准、检查方式和提问策略。 |
| 先逻辑，后文字 | 系统会先验证主张、证据、创新性、范围和贡献，再润色语言。 |
| 迭代式推理循环 | 一个 skill 可以反复挑战、吸收并重新检查用户的回答。 |
| 研究者参与判断 | 用户仍然负责科学判断；skill 帮助暴露哪些问题必须被决定。 |
| Skill-first 架构 | 项目被组织为可复用的 agent skills，而不是一个单体 prompt。 |

## Skill 架构

当前仓库遵循下面的实际 skill 布局。每个 skill 都是 `skills/` 下的一个自包含文件夹，其中包含必需的 `SKILL.md`、可选的 `agents/` UI 元数据、`references/` 中的详细章节逻辑，以及 `scripts/` 中的确定性辅助脚本。

```text
skills/
  introduction/
    SKILL.md
    agents/
    references/
    scripts/
```

Introduction skill 的工作记忆位于项目根目录：

```text
xx.md
```

## 计划中的 Skill 类别

| 状态 | Skill | 用途 |
|---|---|---|
| 计划中 | `abstract` | 构建简洁的问题-空白-方法-结果-贡献链条。 |
| 初始实现 | `introduction` | 维护 `introduction.md`，检查 Introduction 的逻辑，提出有针对性的问题，并在每次回答后更新记忆。 |
| 计划中 | `related-work` | 将论文放到既有工作的语境中，而不是变成文献清单式总结。 |
| 计划中 | `methods` | 检查方法是否可复现、有充分理由，并且与研究问题一致。 |
| 计划中 | `results` | 区分观察、分析和解释。 |
| 计划中 | `discussion` | 将发现连接到其意义，同时避免过度声称。 |
| 计划中 | `limitations` | 让局限性具体、诚实且有用，而不是流于形式。 |
| 计划中 | `review-response` | 将审稿意见转化为结构化修改和有证据支撑的回复。 |

## 使用方式（以 Introduction 为例）

`socratic-introduction` skill 有两种常见使用方式。

第一种，直接唤起 `socratic-introduction`。大模型会从基本问题开始提问，引导用户梳理 Introduction 部分的逻辑。

第二种，唤起 `socratic-introduction`，并将目前已有的内容放入。大模型会先检查当前材料，然后根据缺失、不清楚或逻辑薄弱的地方提出有针对性的追问。

所有内容都会以 `introduction.md` 的形式保存。下次唤起 `socratic-introduction` 时，可以从已有的 `introduction.md` 文件接着继续。

## 路线图

- [x] 创建仓库和初始项目描述。
- [x] 定义共享的苏格拉底式推理循环。
- [x] 实现第一个 `introduction` skill，并使用 `introduction.md` 作为记忆文件。
- [ ] 实现第一个 `abstract` skill。
- [ ] 为每个论文章节添加 rubrics 和问题库。
- [ ] 添加示例，展示薄弱逻辑、追问和改进后的输出。
- [ ] 添加测试或评估轨迹，用于判断 skill 是否提出了正确的问题。
- [ ] 扩展到 introduction、discussion、limitations 和 reviewer response。

## 仓库状态

本仓库目前处于概念和架构阶段。第一个里程碑是将 abstract 工作流转化为一个可以复用、测试和改进的具体 skill。

## License

本项目采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 协议开源。
