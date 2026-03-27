# Open Source Project Standards

Standards and templates for open source project structure, README format, and documentation, organized by language ecosystem.

## Table of Contents
- [Universal Structure](#universal-structure)
- [README Templates](#readme-templates)
- [Language-Specific Conventions](#language-specific-conventions)
- [GitHub Community Files](#github-community-files)
- [CI/CD Templates](#cicd-templates)

---

## Universal Structure

Every open source project root should contain:

```
project-root/
├── LICENSE                  # Required — Open source license
├── README.md                # Required — Project overview and usage
├── .gitignore               # Required — Ignore generated/sensitive files
├── CONTRIBUTING.md          # L2+ — How to contribute
├── CHANGELOG.md             # L2+ — Version history
├── CODE_OF_CONDUCT.md       # L2+ — Community code of conduct
├── SECURITY.md              # L3 — Vulnerability reporting
├── .github/                 # GitHub-specific
│   ├── workflows/           # CI/CD
│   ├── ISSUE_TEMPLATE/      # Issue templates
│   └── PULL_REQUEST_TEMPLATE.md
├── src/ or lib/             # Source code
├── tests/                   # Test suite
├── docs/                    # Documentation (L3)
└── examples/                # Usage examples (L3)
```

---

## README Templates

### L1 — Basic README

```markdown
# Project Name

One-line description of what this project does.

## Installation

​```bash
pip install project-name  # or appropriate install command
​```

## Quick Start

​```python
# Minimal usage example
​```

## License

MIT License — see [LICENSE](LICENSE).
```

### L2 — Standard README

```markdown
# Project Name

One-line description.

> Optional: More detailed paragraph about what problem this solves.

## Features

- Feature 1
- Feature 2
- Feature 3

## Installation

### Prerequisites
- Python 3.11+ (or appropriate requirements)

### Install
​```bash
pip install project-name
​```

### From Source
​```bash
git clone https://github.com/user/project.git
cd project
pip install -e .
​```

## Quick Start

​```python
# Complete runnable example
​```

## Usage

### Basic Usage
...

### Advanced Usage
...

## Configuration

Describe configuration options.

## Development

​```bash
git clone https://github.com/user/project.git
cd project
pip install -e ".[dev]"
pytest
​```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
```

### L3 — Professional README

Includes everything from L2, plus:

```markdown
<!-- Badge row -->
[![CI](https://github.com/user/project/actions/workflows/ci.yml/badge.svg)](...)
[![PyPI](https://img.shields.io/pypi/v/project-name)](...)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](...)
[![codecov](https://codecov.io/gh/user/project/branch/main/graph/badge.svg)](...)

# Project Name

...

## Documentation

Full documentation at [docs site or docs/ folder link].

## Architecture

Brief architecture overview or link to docs/architecture.md.

## Roadmap

- [ ] Planned feature 1
- [ ] Planned feature 2

## Acknowledgments

Thanks to dependencies, inspiration, contributors.
```

---

## Language-Specific Conventions

### Python
```
project-root/
├── pyproject.toml           # Project metadata + dependencies (preferred over setup.py)
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
├── .python-version          # Optional
└── uv.lock / requirements.txt
```

Key conventions:
- Use `src/` layout to prevent import confusion
- Package names use underscores, project names use hyphens
- `pyproject.toml` is the standard (PEP 621)
- Include `py.typed` marker for typed packages

### Node.js / TypeScript
```
project-root/
├── package.json
├── tsconfig.json             # If TypeScript
├── src/
│   └── index.ts
├── dist/                     # Build output (gitignored)
├── tests/ or __tests__/
├── .npmignore or files field in package.json
└── node_modules/             # Gitignored
```

### Rust
```
project-root/
├── Cargo.toml
├── Cargo.lock                # Include for binaries, gitignore for libraries
├── src/
│   ├── lib.rs or main.rs
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
├── cmd/                      # Entry points
│   └── app-name/
│       └── main.go
├── internal/                 # Private packages
├── pkg/                      # Public packages
└── *_test.go                 # Tests alongside source
```

---

## GitHub Community Files

### CONTRIBUTING.md Template

```markdown
# Contributing to Project Name

Thanks for your interest in contributing!

## Development Setup

1. Fork the repo
2. Clone your fork
3. Install dependencies: `...`
4. Create a branch: `git checkout -b feature/your-feature`

## Making Changes

- Write tests for new features
- Follow existing code style
- Keep commits focused and atomic

## Submitting Changes

1. Push to your fork
2. Create a Pull Request
3. Describe what you did and why
4. Link related issues

## Reporting Bugs

Create an issue with:
- Steps to reproduce
- Expected behavior
- Actual behavior
- Environment info

## Code of Conduct

This project follows the [Contributor Covenant](CODE_OF_CONDUCT.md).
```

### Issue Templates

Create `.github/ISSUE_TEMPLATE/bug_report.md`:
```markdown
---
name: Bug Report
about: Report a bug
labels: bug
---

**Describe the bug**
A clear description of the bug.

**Steps to reproduce**
Steps to reproduce:
1. ...

**Expected behavior**
What should happen.

**Environment**
- OS:
- Version:
```

Create `.github/ISSUE_TEMPLATE/feature_request.md`:
```markdown
---
name: Feature Request
about: Suggest a new feature
labels: enhancement
---

**Problem description**
What problem does this feature solve?

**Proposed solution**
How should it work?

**Alternatives considered**
Other approaches you've considered.
```

---

## CI/CD Templates

### Python (GitHub Actions)

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
      - name: Install uv
        uses: astral-sh/setup-uv@v4
      - name: Setup Python ${{ matrix.python-version }}
        run: uv python install ${{ matrix.python-version }}
      - name: Install dependencies
        run: uv sync --all-extras --dev
      - name: Lint
        run: uv run ruff check .
      - name: Type check
        run: uv run mypy src/
      - name: Run tests
        run: uv run pytest tests/ -v --tb=short
```

### Node.js (GitHub Actions)

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

### Rust (GitHub Actions)

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
