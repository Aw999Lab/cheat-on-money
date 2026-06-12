#!/usr/bin/env bash
# 把 cheat-on-money 的各子 skill 安装到 ~/.claude/skills/
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.claude/skills"
mkdir -p "$DEST"
for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"
  # 尝试软链，失败则复制（Windows 兼容）
  ln -sfn "$d" "$DEST/$name" 2>/dev/null || cp -rf "$d" "$DEST/$name"
  echo "installed: $name"
done
echo "完成。现在可以在 Claude Code 里说「我想搞钱」触发 money-init。"
