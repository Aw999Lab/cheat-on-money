---
name: money-retro
description: 自动复盘。对比预期 vs 实际 → 自动判定继续/止损。止损后自动路由 money-find。触发词："复盘"/"总结一下"/"实际赚了多少"。
argument-hint: "[机会名称]"
allowed-tools: Bash(*), Read, Write, Edit, Glob, Skill
---

# /money-retro — 自动复盘 + 自动决策

## ⛔ 最高铁律

**复盘完禁止等用户决策。必须立即执行判定结果。**
- 止损 → 立即 `Skill("money-find")`
- 继续 → 给下一阶段目标 + 立即执行
- 不准问"你想继续吗"

## 自动判定规则

| 情况 | 自动决策 |
|------|---------|
| 投入 > 预期 2 倍仍 0 收入 | → 止损，标 `dropped`，路由 money-find |
| 触发止损线 | → 立即 `dropped`，路由 money-find |
| 有收入但 < 预期 50% | → 标 `running`，调整建议 |
| 超预期 | → 标 `running`，建议加码 |
| 出现反诈红线 | → `dropped` + 高危 |

## 流程

### Step 1 — 取预期
读 `.money-state.json` 的 `active.prediction`

### Step 2 — 取实际
从 retro_log 和 active 提取实际投入/收入/时间

### Step 3 — 对齐 + 自动判定
对比，套规则，一句话告知

### Step 4 — 落盘 + 回流 + ⛔ 强制路由
- `retro_log[]` 追加
- 更新机会 status
- 写入 `lessons.md`（对我有效/亲历坑）
- **立即执行判定结果**：
  - 止损 → `Skill("money-find")`
  - 继续 → 给目标 + 执行

**不问感受。判完直接行动。**
