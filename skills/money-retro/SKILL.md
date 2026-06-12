---
name: money-retro
description: 自动复盘。在执行节点自动触发（≥ 2 周 / 用户说"复盘"），对比实际 vs 预期，沉淀经验到 lessons.md，自动决策继续/调整/止损。不等用户总结。触发词："复盘"/"实际赚了多少"/"总结一下"。
argument-hint: "[机会名称]"
allowed-tools: Bash(*), Read, Write, Edit, Glob, Skill
---

# /money-retro — 自动复盘 + 自动决策

## 核心铁律

1. **自动触发。** 读到 state 里有机会在 running ≥ 14 天 → 主动建议复盘。用户说相关关键词 → 立即复盘。
2. **自动判断继续/止损。** 对比预期 vs 实际，AI 自己做判定。不要问用户"你想继续吗"。

## 自动决策规则

| 情况 | 自动决策 |
|------|---------|
| 投入 > 预期 2 倍仍 0 收入 | → 建议止损，自动将机会标为 `dropped` |
| 触发了止损线 | → 立即标 `dropped`，记录原因 |
| 有收入但低于预期 50% | → 标 `running`，给调整建议 |
| 超过预期 | → 标 `running`，建议加码 |
| 出现反诈红线 | → 立即标 `dropped` + 高危 |

## 流程

### Step 1 — 取出原始预期
读 `.money-state.json` 的 `active.prediction`。

### Step 2 — 获取实际数据
从 state 的 retro_log 和 active 字段提取：实际投入时间、实际收入、第一笔钱到账时间。
如果数据不够（用户没记录），用现有信息推断。

### Step 3 — 对齐 + 自动判定
对比预期 vs 实际，套上面的决策规则，一句话告知判定。

### Step 4 — 落盘 + 回流 lessons.md
- `retro_log[]` 追加记录
- 更新机会 status
- **写入 `lessons.md`**：对我有效 / 亲历坑
- 如果止损 → 自动触发 money-find 找下一个方向
- 如果继续 → 给下一阶段小目标

**不问"你觉得怎么样"。** 直接说「复盘结论：XX。我的建议是 YY。现在帮你 ZZ」。
