#!/usr/bin/env bash
# 扫描项目中的敏感信息
# 用法: ./scan-secrets.sh [目标目录]
set -euo pipefail

TARGET="${1:-.}"
INCLUDE_OPTS='--include=*.py --include=*.js --include=*.ts --include=*.go --include=*.java --include=*.rb --include=*.yaml --include=*.yml --include=*.json --include=*.toml --include=*.cfg --include=*.ini --include=*.conf --include=*.md --include=*.sh --include=*.env*'

echo "🔍 敏感信息扫描: $TARGET"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "=== 1. 代码中的密钥/令牌 ==="
grep -rniE "(api[_-]?key|secret|token|password|passwd)\s*[=:]\s*['\"][^'\"]{8,}" $INCLUDE_OPTS "$TARGET" 2>/dev/null | grep -v '.venv' | grep -v 'node_modules' | grep -v '__pycache__' || echo "  (无)"
echo ""

echo "=== 2. 常见令牌前缀 ==="
grep -rniE "(sk-[a-zA-Z0-9]{20,}|ghp_[a-zA-Z0-9]{36}|gho_[a-zA-Z0-9]{36}|github_pat_)" $INCLUDE_OPTS "$TARGET" 2>/dev/null | grep -v '.venv' || echo "  (无)"
echo ""

echo "=== 3. 敏感文件 ==="
find "$TARGET" \( -name '.env' -o -name '.env.*' -o -name '*.pem' -o -name '*.key' -o -name 'id_rsa*' -o -name 'id_ed25519*' -o -name 'credentials.json' -o -name 'secrets.*' -o -name '.htpasswd' -o -name 'service-account*.json' -o -name 'vault.yml' \) -not -path '*/.git/*' -not -path '*/.venv/*' 2>/dev/null || echo "  (无)"
echo ""

echo "=== 4. 硬编码用户路径 ==="
grep -rn '/home/\|/Users/\|C:\\Users' $INCLUDE_OPTS "$TARGET" 2>/dev/null | grep -v '.venv' | grep -v 'node_modules' || echo "  (无)"
echo ""

echo "=== 5. 内部/私有 IP ==="
grep -rniE '(10\.[0-9]+\.[0-9]+\.[0-9]+|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]+\.[0-9]+|192\.168\.[0-9]+\.[0-9]+)' $INCLUDE_OPTS "$TARGET" 2>/dev/null | grep -v '.venv' | grep -v 'node_modules' || echo "  (无)"
echo ""

echo "=== 6. 连接字符串 ==="
grep -rniE '(mongodb(\+srv)?://|postgres(ql)?://|mysql://|redis://|amqp://|smtp://)[^\s"'"'"']+' $INCLUDE_OPTS "$TARGET" 2>/dev/null | grep -v '.venv' || echo "  (无)"
echo ""

echo "=== 7. .gitignore 保护检查 ==="
if [ -f "$TARGET/.gitignore" ]; then
    echo "  .gitignore 存在，检查敏感文件是否被覆盖:"
    for pattern in ".env" "*.pem" "*.key" "id_rsa*" "credentials.json" "secrets.*"; do
        if grep -q "$pattern" "$TARGET/.gitignore" 2>/dev/null; then
            echo "    ✅ $pattern — 已被 .gitignore 保护"
        else
            echo "    ⚠️  $pattern — 未在 .gitignore 中"
        fi
    done
else
    echo "  ⚠️  .gitignore 不存在！"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "扫描完成。请审查以上结果。"
