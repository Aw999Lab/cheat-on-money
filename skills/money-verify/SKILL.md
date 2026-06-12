---
name: money-verify
description: 反诈验证。实时上网查 + rubric 打分。验证完**自动决策**——可行路由 money-plan，高危丢弃换下一个。不等用户判断。触发词："XX靠谱吗"/"验证机会"/"这个能信吗"。
argument-hint: "<机会名称>"
allowed-tools: Bash(*), Read, Write, Edit, Glob, WebSearch, WebFetch, Skill
---

# /money-verify — 自动验证 + 自动决策

## ⛔ 最高铁律

**验证完禁止等用户判断。必须立即执行决策动作。**
- 可行 → 立即 `Skill("money-plan")`
- 高危 → 自动丢弃 + 从候选池选下一个验证
- 存疑 → 标记 + 继续验证下一个

## 标准
`../../shared-references/anti-scam-rubric.md`

## 流程

### Step 1 — 还原本质
答："谁付钱？为什么付？付多少？"

### Step 2 — 过硬红线 A1–A6
命中 → 高危 ❌ → 自动淘汰 → 从候选池选下一个

### Step 3 — 过存疑信号 B1–B6

### Step 4 — 实时查证 + 时效核查
上网搜负面/口碑/实体。超 24 月默认失效。

### Step 5 — 输出 + 自动决策
按 rubric D 格式输出。然后：

| 判定 | 立即动作 |
|------|---------|
| ✅ 可行 | `Skill("money-plan")` |
| ⚠️ 存疑 | 标记 state，继续验证下一个 |
| ❌ 高危 | 丢弃，选下一个验证 |

落盘到 `.money-state.json` 的 `opportunities[]`。

**不问"你觉得呢"。判定完直接行动。**
