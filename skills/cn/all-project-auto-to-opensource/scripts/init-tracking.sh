#!/usr/bin/env bash
# 初始化追踪文件（.process.json + .checklist.json）
# 用法: ./init-tracking.sh <项目目录> [目标级别 L1|L2|L3]
set -euo pipefail

TARGET="${1:?用法: ./init-tracking.sh <项目目录> [L1|L2|L3]}"
LEVEL="${2:-L2}"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

if [ ! -d "$TARGET" ]; then
    echo "❌ 目录不存在: $TARGET"
    exit 1
fi

PROJECT_NAME=$(basename "$TARGET")

# 创建 .process.json
cat > "$TARGET/.process.json" <<EOF
{
  "status": "in-progress",
  "project_name": "$PROJECT_NAME",
  "target_level": "$LEVEL",
  "started_at": "$TIMESTAMP",
  "completed_at": null,
  "current_phase": 5,
  "current_step": "5.1",
  "total_steps": 0,
  "completed_steps": 0,
  "phases": [],
  "anti_drift_log": []
}
EOF

# 创建 .checklist.json
cat > "$TARGET/.checklist.json" <<EOF
{
  "status": "pending",
  "checked_at": null,
  "items": [
    {"category": "安全", "check": "代码中无 API 密钥或令牌", "passed": null},
    {"category": "安全", "check": "无硬编码内部 URL", "passed": null},
    {"category": "安全", "check": ".gitignore 覆盖所有敏感文件", "passed": null},
    {"category": "License", "check": "LICENSE 文件存在", "passed": null},
    {"category": "文档", "check": "README.md 完整且准确", "passed": null},
    {"category": "构建", "check": "项目可从干净克隆构建", "passed": null},
    {"category": "测试", "check": "测试套件通过", "passed": null},
    {"category": "测试", "check": "关键模块有测试覆盖", "passed": null},
    {"category": "瘦身", "check": "无内部专用代码残留", "passed": null},
    {"category": "瘦身", "check": "无冗余/过时文件残留", "passed": null},
    {"category": "瘦身", "check": "无冗余/过时测试用例", "passed": null},
    {"category": "gitignore", "check": ".gitignore 覆盖所有生成文件", "passed": null},
    {"category": "结构", "check": "无空目录", "passed": null},
    {"category": "依赖", "check": "无未使用的依赖", "passed": null},
    {"category": "CI", "check": "CI 配置有效", "passed": null}
  ]
}
EOF

echo "✅ 追踪文件已创建:"
echo "   $TARGET/.process.json"
echo "   $TARGET/.checklist.json"
echo "   目标级别: $LEVEL"
