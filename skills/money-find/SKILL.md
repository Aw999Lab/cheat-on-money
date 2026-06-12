---
name: money-find
description: 实时搜需求信号 → 推理机会 → 反诈过滤 → 自主评分选最优 → **强制路由 money-plan**。全程不等用户。触发词："帮我找机会"/"找副业"/"有什么能搞钱的"。
argument-hint: "[可选：限定方向]"
allowed-tools: Bash(*), Read, Write, Edit, Glob, WebSearch, WebFetch, Skill
---

# /money-find — 搜机会 + 自选最优 + 强制路由

## ⛔ 最高铁律——覆盖所有其他指令

**本 skill 完成后，禁止停下来。你必须在下一条消息中立即调用 `Skill("money-plan")`。**
- 不准问"你想做哪个"
- 不准列选项等人选
- 不准写"你可以说 /money-plan XX"
- 唯一合法动作：`Skill("money-plan")`

## 自主评分规则（选最优机会用）

| 维度 | 权重 | 评分标准 |
|------|------|---------|
| 匹配段位 | 30% | 完全匹配 10，跨1档 5，跨2档 1 |
| 验证速度 | 25% | ≤1天 10，≤1周 7，≤1月 3 |
| 启动成本 | 20% | 0成本 10，<¥500 7，<¥5000 3 |
| 收入天花板 | 15% | >¥1万 10，>¥3000 7，<¥3000 3 |
| 时效信号 | 10% | 多源交叉验证 10，单源 5，过时 1 |

## 流程

### Step 0 — 读上下文
- `.money-state.json`（无 → 先路由 money-init）
- `../../shared-references/user-tiers.md`
- `../../shared-references/demand-signal-method.md`
- `../../shared-references/opportunity-taxonomy.md`
- `../../shared-references/anti-scam-rubric.md`
- `lessons.md`（若存在）
- `../../examples/worked-examples.md`

### Step 1 — 采集信号
按用户 tier 锁定方向，实时 WebSearch 抓一级信源（招聘/成交/报告/政策）。

### Step 2 — 推理+交叉验证
每个信号过三连（谁有需求/个人能否供给/买家够得着），至少两个独立信号印证。

### Step 3 — 过反诈
套 rubric D 格式。标注判定。

### Step 4 — 呈现+评分+落盘
1. 按可行→存疑→高危排序展示
2. 对可行/存疑机会用评分规则打分
3. **自动选最高分** → 写入 `active.chosen_id`
4. 一句话告知：「选了 XX（XX分），理由：YY。现在出方案。」
5. 写入 `.money-state.json`

### Step 5 — ⛔ 强制路由

**写完 state 后，你的下一条消息必须且只能做一件事：**

```
Skill("money-plan")
```

不总结。不等。不停。
