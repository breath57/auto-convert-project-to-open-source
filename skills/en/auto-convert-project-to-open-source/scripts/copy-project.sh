#!/usr/bin/env bash
# 复制项目到工作目录（排除 .git）
# 用法: ./copy-project.sh [源目录] [目标目录名后缀]
set -euo pipefail

SRC_DIR="${1:-.}"
SUFFIX="${2:-auto-convert-open-source}"
PROJECT_NAME=$(basename "$(cd "$SRC_DIR" && pwd)")
TARGET_DIR="$(cd "$SRC_DIR" && pwd)/${PROJECT_NAME}-${SUFFIX}"

if [ -d "$TARGET_DIR" ]; then
    echo "⚠️  目标目录已存在: $TARGET_DIR"
    echo "如需覆盖请先手动删除。"
    exit 1
fi

echo "📦 正在复制项目..."
echo "   源: $(cd "$SRC_DIR" && pwd)"
echo "   目标: $TARGET_DIR"

rsync -a --exclude='.git' "$SRC_DIR/" "$TARGET_DIR/"

SRC_COUNT=$(find "$SRC_DIR" -not -path '*/.git/*' -not -path '*/.git' -type f | wc -l)
DST_COUNT=$(find "$TARGET_DIR" -type f | wc -l)

echo ""
echo "✅ 复制完成"
echo "   源文件数: $SRC_COUNT"
echo "   副本文件数: $DST_COUNT"
echo "   目标目录: $TARGET_DIR"
