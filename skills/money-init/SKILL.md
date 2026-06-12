---
name: money-init
description: cheat-on-money 首次 onboarding。自动建立用户画像（从对话中推断、明确信息直接问、其余用合理默认值），创建 .money-state.json，然后**自动路由到 money-find**——不给用户列"下一步清单"，直接继续。触发词："搞钱初始化"/"我想搞钱"/"找AI兼职"/"money init"。**当用户想找搞钱机会但 .money-state.json 不存在时，自动触发。**
argument-hint: ""
allowed-tools: Bash(*), Read, Write, Edit, Glob, Skill
---

# /money-init — 自主 onboarding，5 分钟从零到开始找机会

## 核心铁律（最高优先级——覆盖所有其他规则）

1. **绝不等用户决策。** 能推断的用默认值，推断不了的一次性问完，问到就继续。
2. **不问"你想怎么选"。** 直接给判定并解释为什么，允许用户事后纠正。
3. **完成即路由。** init 完自动触发 money-find，不说"下一步你可以说 X"——直接做。
4. **5 分钟内完成。** 画像建立 + 段位判定 + 写入 state + 路由 money-find 一气呵成。

## 流程

### Phase 0 — 检测状态

```bash
test -f .money-state.json && echo EXISTS || echo MISSING
```
- EXISTS → 读已有画像，直接路由 money-find。
- MISSING → 继续。

### Phase 1 — 一句话首屏（精简，别啰嗦）

> "我来帮你找真能赚钱的副业。先快速了解你的情况——不需要完美，不确定的我会用默认值，后面随时可以调。"

### Phase 2 — 画像收集（优化版——最小化交互）

**优先级顺序**：
1. **从对话上下文推断**：如果用户之前说过"我写代码的""我在广州""我每天很闲"——直接用，不重复问。
2. **一次问完剩余所有必要信息**：把 profile 里缺的字段一次问完。用 AskUserQuestion 时问题标签要短，选项要少（每问 ≤ 4 选项，共 ≤ 4 题）。不确定的字段 → 记 `null`。
3. **默认值策略**（不占用问题额度）：
   - 地区 → 默认"中国大陆+中文"
   - 启动资金 → 默认"0 成本"
   - 露脸 → 默认"不愿露脸"（保守）
   - 目标 → 默认"愿学变现技能"（中等段位）
   - 时间 → 默认"5-15 小时/周"
4. **允许"不知道"** → 记 `null`，后续用更宽范围。

### Phase 2.5 — 段位识别（读 user-tiers.md，自主判定）

读 `../../shared-references/user-tiers.md`，按"技能 × 资源 × 目标"判定 T0/T1/T2/T3。

**不确定时就低不就高。** 判完一句话告诉用户判了哪档、为什么。

### Phase 3 — 写入状态文件 + 立即路由

读 `../../templates/money-state.template.json`，填入答案。写 `.money-state.json`。

**写完立即：** 告诉用户「画像已建立，正在帮你找机会...」→ 直接调用 Skill 工具触发 `money-find`。

不要 Phase 4 "下一步清单"。不要等用户说"帮我找机会"。直接找。
