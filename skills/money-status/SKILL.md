---
name: money-status
description: 状态看板。只读展示 + **自动路由下一步 + 立即执行**。触发词："搞钱状态"/"看板"/"我现在该做什么"。
argument-hint: ""
allowed-tools: Bash(*), Read, Glob, Skill
---

# /money-status — 看板 + 自动路由

## ⛔ 最高铁律

**展示完状态后禁止停止。必须根据状态自动路由并立即执行。**

## 流程

### Step 1 — 读状态
```bash
test -f .money-state.json && echo OK || echo MISSING
```
MISSING → `Skill("money-init")`

### Step 2 — 展示看板（精简）
- 画像 + 段位
- 经验摘要
- 候选机会（可行→存疑→高危）
- 执行中机会 + 进度
- 复盘摘要

### Step 3 — ⛔ 自动路由（展示完立即执行，不等）

| 状态 | 立即动作 |
|------|---------|
| 无候选 | `Skill("money-find")` |
| 有可行未选 | 自动选最高分 → `Skill("money-plan")` |
| 执行中 ≥14天 | `Skill("money-retro")` |
| 执行中 <14天 | 展示进度 + 本周目标 |
| 全部测完 | `Skill("money-find")` |

**展示+路由一气呵成。禁止在展示后停下来等人说下一步。**
