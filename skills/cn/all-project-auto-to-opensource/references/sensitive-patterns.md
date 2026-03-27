# 敏感信息扫描模式

全面的秘密、凭证和内部引用检测模式。
在 Phase 1.3 分析阶段使用 `grep -rniE` 配合这些模式进行扫描。

## 目录
- [API 密钥 & 令牌](#api-密钥--令牌)
- [密码 & 凭证](#密码--凭证)
- [连接字符串](#连接字符串)
- [内部 URL & IP](#内部-url--ip)
- [硬编码路径](#硬编码路径)
- [证书 & 密钥](#证书--密钥)
- [云服务商密钥](#云服务商密钥)
- [敏感文件](#敏感文件)

---

## API 密钥 & 令牌

### 变量名模式
```
(api[_-]?key|api[_-]?secret|access[_-]?token|auth[_-]?token|bearer|secret[_-]?key|private[_-]?key|client[_-]?secret)\s*[=:]\s*['\"][^'\"]{8,}
```

### 高熵字符串检测
查找包含混合大小写、数字和符号的 20+ 字符的字符串赋值：
```
[=:]\s*['\"][A-Za-z0-9+/=_-]{20,}['\"]
```

### 常见令牌前缀
```
(sk-[a-zA-Z0-9]{20,}|ghp_[a-zA-Z0-9]{36}|gho_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9_]{22,}|xox[bposa]-[a-zA-Z0-9-]{10,}|ya29\.[a-zA-Z0-9_-]{50,})
```

## 密码 & 凭证

```
(password|passwd|pwd|pass)\s*[=:]\s*['\"][^'\"]{3,}
(DB_PASSWORD|DATABASE_PASSWORD|MYSQL_PASSWORD|POSTGRES_PASSWORD|REDIS_PASSWORD)\s*[=:]
```

## 连接字符串

```
(mongodb(\+srv)?://|postgres(ql)?://|mysql://|redis://|amqp://|smtp://)[^\s'\"]+
(jdbc:|odbc:)[^\s'\"]+
```

## 内部 URL & IP

```
https?://(localhost|127\.0\.0\.1|0\.0\.0\.0|10\.\d+\.\d+\.\d+|172\.(1[6-9]|2\d|3[01])\.\d+\.\d+|192\.168\.\d+\.\d+)[:/]
https?://[a-z0-9-]+\.(internal|local|corp|intra|dev|staging)\b
```

## 硬编码路径

```
(/home/[a-z][a-z0-9_-]+/|/Users/[A-Za-z][A-Za-z0-9 _-]+/|C:\\Users\\[A-Za-z])
```

## 证书 & 密钥

### 需标记的文件扩展名
```
\.(pem|key|p12|pfx|jks|keystore|cer|crt|der)$
```

### 源码中的 PEM 内容
```
-----BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
```

## 云服务商密钥

### AWS
```
(AKIA[0-9A-Z]{16})
(aws_access_key_id|aws_secret_access_key)\s*[=:]
```

### Azure
```
(AccountKey|SharedAccessKey)=[a-zA-Z0-9+/=]{40,}
```

### GCP
```
"type"\s*:\s*"service_account"
```

## 敏感文件

几乎可以确定包含秘密的文件 —— 标记为需要立即审查：

```
.env
.env.local
.env.production
.env.*.local
*.pem
*.key
*.p12
id_rsa*
id_ed25519*
.htpasswd
credentials.json
service-account*.json
secrets.yaml
secrets.yml
vault.yml
```

**⚠️ .gitignore 保护判断**：
- 如果上述文件已在 `.gitignore` 中 → 标注"已保护，无需删除"
- 如果不在 `.gitignore` 中 → 标注"高优先级 - 需要处理"

## 扫描命令

一键运行所有关键模式检查的快捷命令：

```bash
# 代码中的秘密
grep -rniE '(api[_-]?key|secret|token|password|passwd)\s*[=:]\s*['\''"][^'\''"]{8,}' --include='*.py' --include='*.js' --include='*.ts' --include='*.go' --include='*.java' --include='*.rb' --include='*.yaml' --include='*.yml' --include='*.json' --include='*.toml' --include='*.cfg' --include='*.ini' --include='*.conf' .

# 敏感文件
find . -name '.env' -o -name '.env.*' -o -name '*.pem' -o -name '*.key' -o -name 'id_rsa*' -o -name 'credentials.json' -o -name 'secrets.*' 2>/dev/null

# 内部路径
grep -rn '/home/\|/Users/\|C:\\Users' --include='*.py' --include='*.js' --include='*.ts' --include='*.yaml' --include='*.yml' --include='*.json' --include='*.toml' --include='*.md' .

# 私有 IP
grep -rniE '(10\.\d+\.\d+\.\d+|172\.(1[6-9]|2[0-9]|3[01])\.\d+\.\d+|192\.168\.\d+\.\d+)' --include='*.py' --include='*.js' --include='*.yaml' --include='*.yml' --include='*.json' --include='*.toml' .
```

## 误报指导

需要注意的常见误报情况：
- 开发配置文件中的 `localhost`（本来就是模板）
- Base64 编码的测试固定数据（不是真正的秘密）
- 示例/占位符值如 `YOUR_API_KEY`、`changeme`、`xxx`
- 描述如何配置凭证的文档
- 使用模拟凭证的测试文件

**拿不准时，标记给用户审查，而不是忽略。**
