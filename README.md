# cheat-on-money —— AI 时代靠谱兼职发现 + 反诈验证 skill

帮你在 AI 时代找到**真能用**的兼职/副业。核心不是"列一堆项目"，而是四件别人不做的事：

1. **需求信号反推**，不搜"教你赚钱"的帖子（那是卖课钓粉的污染信源）——看行业报告/招聘/采购数据等利益中立信号，推理出个人能供给的机会，并用多个独立信号交叉验证
2. **实时检索 + 时效核查**，不靠模型记忆；来源超 24 个月默认失效（平台规则天天变）
3. **反诈 rubric**，每个机会过硬红线，宁可错杀
4. **个性化 + 可验证**，按你的画像匹配，每个机会都给"小成本先验证能不能收到第一笔钱"的路径

> 哲学同 cheat-on-content：可信度靠**机制**，不靠内容质量。

## 🚀 核心设计：AI 自主决策，不等用户

**区别于其他工具的关键差异**：这套 skill 不会给你列一堆选项然后问你"你想选哪个"。它自己决策、自己执行、自己路由到下一步。

```
用户说"我想搞钱"
  → money-init  自动建画像 → 自动路由
  → money-find  自动搜机会 → 自动选最优 → 自动路由
  → money-plan  自动出方案 → 自动执行第一步
  → money-retro 自动复盘 → 自动决定继续/换方向
```

用户只需要说一次"我想搞钱"，后续全部自动推进。不满意可以说"换一个"，但不需要在每一步做选择题。

## 子 skill

| 命令 | 作用 | 自主程度 |
|------|------|---------|
| `money-init` | 建画像 + 自动路由 money-find | 🤖 自动推断 + 一次性收集 |
| `money-find` | 搜机会 + **自动选最优** + 自动路由 money-plan | 🤖 全自动决策 |
| `money-verify` | 验证机会 + **自动判定** + 可行则路由 money-plan | 🤖 全自动决策 |
| `money-plan` | 出方案 + **自动执行第一步** | 🤖 能代劳就代劳 |
| `money-retro` | 复盘 + **自动判定继续/止损** | 🤖 全自动决策 |
| `money-status` | 看板 + **自动路由下一步** | 🤖 全自动决策 |

## 自主决策评分规则（money-find 用）

当搜出多个机会时，AI 按以下权重自动选择最优：

| 维度 | 权重 | 评分标准 |
|------|------|---------|
| 匹配段位 | 30% | 与用户 tier 完全匹配 10 分，跨 1 档 5 分 |
| 验证速度 | 25% | 验证第一步 ≤ 1 天 10 分，≤ 1 周 7 分 |
| 启动成本 | 20% | 0 成本 10 分，< ¥500 7 分 |
| 收入天花板 | 15% | 月入 > ¥1 万 10 分，> ¥3000 7 分 |
| 时效信号强度 | 10% | 多源交叉验证 10 分，单一来源 5 分 |

## 共享文档（机制所在）

- `shared-references/demand-signal-method.md` —— **需求信号反推法**
- `shared-references/anti-scam-rubric.md` —— 反诈判定标准 + 时效核查
- `shared-references/user-tiers.md` —— **用户段位 T0–T3**
- `shared-references/opportunity-taxonomy.md` —— 机会分类框架
- `examples/worked-examples.md` —— 真实跑出来的范本
- `templates/money-state.template.json` —— 状态文件模板

## 数据 adapter

- `adapters/xianyu/` —— 闲鱼成交侧
- `adapters/boss/` —— BOSS直聘招聘侧

## 校准环

`money-plan` 写预期 → 执行 → `money-retro` 对账 → 经验回流 `lessons.md` → `money-find`/`money-verify` 下次自动读取。

## 安装

### Claude Code

```bash
cd "$(dirname "$0")" 2>/dev/null
ROOT="$(pwd)"
for d in skills/*/; do
  name="$(basename "$d")"
  ln -sf "$ROOT/$d" "$HOME/.claude/skills/$name"
done
```

或直接运行 `./install.sh`。

### Codex

```bash
./install-codex.sh
```

## 重要声明

本工具提供的是**判断框架与实时检索辅助**，不构成投资/就业建议。最终决策与风险由用户自行承担。
凡涉及"先交钱、刷单、过账、出借账户"的，一律是骗局或违法，立刻远离。
