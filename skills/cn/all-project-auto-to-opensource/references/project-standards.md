# 开源项目标准

开源项目结构、README 格式和文档的标准与模板，按语言生态系统分类。

## 目录
- [通用结构](#通用结构)
- [README 模板](#readme-模板)
- [各语言约定](#各语言约定)
- [GitHub 社区文件](#github-社区文件)
- [CI/CD 模板](#cicd-模板)

---

## 通用结构

每个开源项目的根目录应包含以下内容：

```
project-root/
├── LICENSE                  # 必须 — 开源许可证
├── README.md                # 必须 — 项目概览和使用说明
├── .gitignore               # 必须 — 忽略生成/敏感文件
├── CONTRIBUTING.md          # L2+ — 如何贡献
├── CHANGELOG.md             # L2+ — 版本历史
├── CODE_OF_CONDUCT.md       # L2+ — 社区行为准则
├── SECURITY.md              # L3 — 漏洞上报
├── .github/                 # GitHub 专用
│   ├── workflows/           # CI/CD
│   ├── ISSUE_TEMPLATE/      # Issue 模板
│   └── PULL_REQUEST_TEMPLATE.md
├── src/ 或 lib/             # 源代码
├── tests/                   # 测试套件
├── docs/                    # 文档（L3）
└── examples/                # 使用示例（L3）
```

---

## README 模板

### L1 — 基础 README

```markdown
# 项目名称

一句话描述这个项目做什么。

## 安装

​```bash
pip install project-name  # 或相应的安装命令
​```

## 快速开始

​```python
# 最简使用示例
​```

## 许可证

MIT 许可证 — 详见 [LICENSE](LICENSE)。
```

### L2 — 标准 README

```markdown
# 项目名称

一句话描述。

> 可选：更详细的段落，说明这个项目解决什么问题。

## 功能特性

- 特性 1
- 特性 2
- 特性 3

## 安装

### 前置条件
- Python 3.11+（或相应要求）

### 安装
​```bash
pip install project-name
​```

### 从源码安装
​```bash
git clone https://github.com/user/project.git
cd project
pip install -e .
​```

## 快速开始

​```python
# 完整的可运行示例
​```

## 使用说明

### 基本用法
...

### 高级用法
...

## 配置

描述配置选项。

## 开发

​```bash
git clone https://github.com/user/project.git
cd project
pip install -e ".[dev]"
pytest
​```

## 贡献

参见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 许可证

MIT — 详见 [LICENSE](LICENSE)。
```

### L3 — 专业 README

包含 L2 的所有内容，加上：

```markdown
<!-- 徽章行 -->
[![CI](https://github.com/user/project/actions/workflows/ci.yml/badge.svg)](...)
[![PyPI](https://img.shields.io/pypi/v/project-name)](...)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](...)
[![codecov](https://codecov.io/gh/user/project/branch/main/graph/badge.svg)](...)

# 项目名称

...

## 文档

完整文档请访问 [文档站点或 docs/ 文件夹链接]。

## 架构

简要架构概览或链接到 docs/architecture.md。

## 路线图

- [ ] 计划中的功能 1
- [ ] 计划中的功能 2

## 致谢

感谢依赖项、灵感来源、贡献者。
```

---

## 各语言约定

### Python
```
project-root/
├── pyproject.toml           # 项目元数据 + 依赖（优于 setup.py）
├── src/
│   └── package_name/
│       ├── __init__.py
│       ├── core.py
│       └── ...
├── tests/
│   ├── __init__.py
│   ├── test_core.py
│   └── ...
├── docs/
├── examples/
├── .python-version          # 可选
└── uv.lock / requirements.txt
```

关键约定：
- 使用 `src/` 布局防止导入混淆
- 包名使用下划线，项目名使用连字符
- `pyproject.toml` 是标准（PEP 621）
- 对于有类型的包，包含 `py.typed` 标记

### Node.js / TypeScript
```
project-root/
├── package.json
├── tsconfig.json             # 如果是 TypeScript
├── src/
│   └── index.ts
├── dist/                     # 构建输出（gitignored）
├── tests/ 或 __tests__/
├── .npmignore 或 package.json 中的 files 字段
└── node_modules/             # Gitignored
```

### Rust
```
project-root/
├── Cargo.toml
├── Cargo.lock                # 二进制文件包含，库则 gitignore
├── src/
│   ├── lib.rs 或 main.rs
│   └── ...
├── tests/
├── benches/
└── examples/
```

### Go
```
project-root/
├── go.mod
├── go.sum
├── cmd/                      # 入口点
│   └── app-name/
│       └── main.go
├── internal/                 # 私有包
├── pkg/                      # 公共包
└── *_test.go                 # 测试与源码同目录
```

---

## GitHub 社区文件

### CONTRIBUTING.md 模板

```markdown
# 为 项目名称 做贡献

感谢您对贡献的兴趣！

## 开发环境设置

1. Fork 本仓库
2. 克隆你的 Fork
3. 安装依赖：`...`
4. 创建分支：`git checkout -b feature/your-feature`

## 修改代码

- 为新功能编写测试
- 遵循现有代码风格
- 保持提交集中且原子化

## 提交修改

1. 推送到你的 Fork
2. 创建 Pull Request
3. 描述你做了什么以及为什么
4. 关联相关 Issue

## 报告 Bug

创建一个 Issue，包含：
- 复现步骤
- 预期行为
- 实际行为
- 环境信息

## 行为准则

本项目遵循 [贡献者公约](CODE_OF_CONDUCT.md)。
```

### Issue 模板

创建 `.github/ISSUE_TEMPLATE/bug_report.md`：
```markdown
---
name: Bug 报告
about: 报告一个 Bug
labels: bug
---

**描述 Bug**
清晰描述 Bug 的情况。

**复现步骤**
复现步骤：
1. ...

**预期行为**
应该发生什么。

**环境信息**
- 操作系统：
- 版本：
```

创建 `.github/ISSUE_TEMPLATE/feature_request.md`：
```markdown
---
name: 功能请求
about: 建议一个新功能
labels: enhancement
---

**问题描述**
这个功能解决什么问题？

**建议方案**
它应该如何工作？

**替代方案**
你考虑过的其他方法。
```

---

## CI/CD 模板

### Python（GitHub Actions）

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.11", "3.12", "3.13"]
    steps:
      - uses: actions/checkout@v4
      - name: 安装 uv
        uses: astral-sh/setup-uv@v4
      - name: 设置 Python ${{ matrix.python-version }}
        run: uv python install ${{ matrix.python-version }}
      - name: 安装依赖
        run: uv sync --all-extras --dev
      - name: Lint 检查
        run: uv run ruff check .
      - name: 类型检查
        run: uv run mypy src/
      - name: 运行测试
        run: uv run pytest tests/ -v --tb=short
```

### Node.js（GitHub Actions）

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18, 20, 22]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm ci
      - run: npm run lint
      - run: npm test
```

### Rust（GitHub Actions）

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: dtolnay/rust-toolchain@stable
      - run: cargo fmt --check
      - run: cargo clippy -- -D warnings
      - run: cargo test
```
