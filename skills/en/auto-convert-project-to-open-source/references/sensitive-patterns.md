# Sensitive Information Scan Patterns

Comprehensive detection patterns for secrets, credentials, and internal references.
Use `grep -rniE` with these patterns during Phase 1.3 analysis.

## Table of Contents
- [API Keys & Tokens](#api-keys--tokens)
- [Passwords & Credentials](#passwords--credentials)
- [Connection Strings](#connection-strings)
- [Internal URLs & IPs](#internal-urls--ips)
- [Hardcoded Paths](#hardcoded-paths)
- [Certificates & Keys](#certificates--keys)
- [Cloud Provider Keys](#cloud-provider-keys)
- [Sensitive Files](#sensitive-files)

---

## API Keys & Tokens

### Variable Name Patterns
```
(api[_-]?key|api[_-]?secret|access[_-]?token|auth[_-]?token|bearer|secret[_-]?key|private[_-]?key|client[_-]?secret)\s*[=:]\s*['\"][^'\"]{8,}
```

### High-Entropy String Detection
Look for 20+ character strings with mixed case, digits, and symbols:
```
[=:]\s*['\"][A-Za-z0-9+/=_-]{20,}['\"]
```

### Common Token Prefixes
```
(sk-[a-zA-Z0-9]{20,}|ghp_[a-zA-Z0-9]{36}|gho_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9_]{22,}|xox[bposa]-[a-zA-Z0-9-]{10,}|ya29\.[a-zA-Z0-9_-]{50,})
```

## Passwords & Credentials

```
(password|passwd|pwd|pass)\s*[=:]\s*['\"][^'\"]{3,}
(DB_PASSWORD|DATABASE_PASSWORD|MYSQL_PASSWORD|POSTGRES_PASSWORD|REDIS_PASSWORD)\s*[=:]
```

## Connection Strings

```
(mongodb(\+srv)?://|postgres(ql)?://|mysql://|redis://|amqp://|smtp://)[^\s'\"]+
(jdbc:|odbc:)[^\s'\"]+
```

## Internal URLs & IPs

```
https?://(localhost|127\.0\.0\.1|0\.0\.0\.0|10\.\d+\.\d+\.\d+|172\.(1[6-9]|2\d|3[01])\.\d+\.\d+|192\.168\.\d+\.\d+)[:/]
https?://[a-z0-9-]+\.(internal|local|corp|intra|dev|staging)\b
```

## Hardcoded Paths

```
(/home/[a-z][a-z0-9_-]+/|/Users/[A-Za-z][A-Za-z0-9 _-]+/|C:\\Users\\[A-Za-z])
```

## Certificates & Keys

### File Extensions to Flag
```
\.(pem|key|p12|pfx|jks|keystore|cer|crt|der)$
```

### PEM Content in Source Code
```
-----BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
```

## Cloud Provider Keys

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

## Sensitive Files

Files almost certainly containing secrets — flag for immediate review:

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

**⚠️ .gitignore Protection Check:**
- If above files are in `.gitignore` → Mark "protected, no deletion needed"
- If NOT in `.gitignore` → Mark "high priority - needs action"

## Scan Commands

Quick commands to run all key pattern checks:

```bash
# Secrets in code
grep -rniE '(api[_-]?key|secret|token|password|passwd)\s*[=:]\s*['\''"][^'\''"]{8,}' --include='*.py' --include='*.js' --include='*.ts' --include='*.go' --include='*.java' --include='*.rb' --include='*.yaml' --include='*.yml' --include='*.json' --include='*.toml' --include='*.cfg' --include='*.ini' --include='*.conf' .

# Sensitive files
find . -name '.env' -o -name '.env.*' -o -name '*.pem' -o -name '*.key' -o -name 'id_rsa*' -o -name 'credentials.json' -o -name 'secrets.*' 2>/dev/null

# Internal paths
grep -rn '/home/\|/Users/\|C:\\Users' --include='*.py' --include='*.js' --include='*.ts' --include='*.yaml' --include='*.yml' --include='*.json' --include='*.toml' --include='*.md' .

# Private IPs
grep -rniE '(10\.\d+\.\d+\.\d+|172\.(1[6-9]|2[0-9]|3[01])\.\d+\.\d+|192\.168\.\d+\.\d+)' --include='*.py' --include='*.js' --include='*.yaml' --include='*.yml' --include='*.json' --include='*.toml' .
```

## False Positive Guidance

Common false positive scenarios to watch for:
- `localhost` in dev config files (intended as template)
- Base64-encoded test fixtures (not real secrets)
- Example/placeholder values like `YOUR_API_KEY`, `changeme`, `xxx`
- Documentation describing how to configure credentials
- Test files using mock credentials

**When in doubt, flag for user review rather than ignoring.**
