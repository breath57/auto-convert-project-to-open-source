# 🚀 all-project-auto-to-opensource

**Transform any private project into a production-ready open source project — automatically.**

[English](README.md) | [中文](README_CN.md)

---

> One AI skill. Any language. Any framework. From private repo to polished open source in minutes, not days.

## ✨ What Makes This Different

Most "open source checklist" tools give you a static list of things to check. This skill **actively does the work for you** through your AI coding assistant:

- 🔒 **Security-first** — Automatically scans and cleans secrets, API keys, internal URLs, hardcoded paths
- 🧹 **Deep pruning** — Doesn't just remove `.DS_Store`. Goes file-by-file, function-by-function to strip internal-only code
- 🤖 **8-phase guided workflow** — With 5 mandatory checkpoints where YOU make the decisions
- 🌍 **Language-agnostic** — Python, Node.js, Rust, Go, Java, Ruby... if it's code, it works
- 📊 **Never loses track** — Persistent progress bar + JSON tracking files prevent the AI from drifting
- ✅ **Test-driven** — Every change is verified. Tests must pass before moving on
- 📝 **README last** — Generates README from the *final* code, not from outdated assumptions

## 🎯 The Problem

Open-sourcing a private project is tedious and error-prone:

- Did I remove all hardcoded API keys? What about that one in the test fixture?
- Is there internal-only code hiding in a utility function somewhere?
- Does the README actually match the final state of the code?
- Did I forget the LICENSE file? CONTRIBUTING.md? .gitignore?

**This skill handles all of it** — systematically, thoroughly, with human checkpoints for every critical decision.

## 📦 Installation

```bash
npx skills add nicepkg/all-project-auto-to-opensource
```

Or manually clone to your `.agents/skills/` directory:

```bash
git clone https://github.com/nicepkg/all-project-auto-to-opensource.git .agents/skills/all-project-auto-to-opensource
```

## 🗂️ Choose Your Language

Skills are available in **English** and **Chinese**:

| Language | Path | Status |
|----------|------|--------|
| 🇬🇧 English | `skills/en/all-project-auto-to-opensource/` | ✅ Default |
| 🇨🇳 中文 | `skills/cn/all-project-auto-to-opensource/` | ✅ Available |

After installation, copy the version you need into your `.agents/skills/` directory.

## 🔄 How It Works

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  Phase 0-1   │────▶│  Phase 2-3   │────▶│  Phase 4-5   │────▶│  Phase 6-8   │
│  Analyze     │     │  Plan        │     │  Execute     │     │  Verify      │
│              │     │              │     │              │     │              │
│ • Copy proj  │     │ • Choose L1/ │     │ • Security   │     │ • Run tests  │
│ • Deep scan  │     │   L2/L3      │     │ • Pruning    │     │ • Final scan │
│ • Find       │     │ • Name repo  │     │ • Cleanup    │     │ • README     │
│   secrets    │     │ • Confirm    │     │ • Docs + CI  │     │ • Git init   │
│              │     │   plan       │     │              │     │              │
│   🛑 STOP    │     │   🛑 STOP    │     │   🛑 STOP    │     │   🛑 STOP    │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
```

### 3 Target Levels

| Level | What You Get | Best For |
|-------|-------------|----------|
| **L1 Basic** | Security cleanup + LICENSE + README + .gitignore | Quick release, internal tools |
| **L2 Standard** | L1 + code cleanup + tests + CI + CONTRIBUTING | Most projects |
| **L3 Professional** | L2 + API docs + architecture docs + examples + badges | Libraries, frameworks |

### 5 Mandatory Checkpoints

The AI **never** makes critical decisions for you. At each 🛑 STOP point, it presents findings and waits for your confirmation:

1. **Analysis Report** — Review what was found before proceeding
2. **Level & Name** — Choose target level and project name
3. **Refactor Plan** — Approve the detailed plan before execution
4. **Uncertain Items** — Decide what to keep/remove for unclear files
5. **Test Results** — Verify everything passes before README generation

## 📁 Skill Structure

```
skills/
├── en/                               # 🇬🇧 English version
│   └── all-project-auto-to-opensource/
│       ├── SKILL.md                  # Main skill document
│       ├── references/
│       │   ├── anti-drift.md         # Anti-forgetting mechanisms
│       │   ├── cleanup-checklist.md  # Detailed cleanup checklist
│       │   ├── deep-pruning.md       # Deep pruning guide
│       │   ├── project-standards.md  # Open source project standards
│       │   ├── sensitive-patterns.md # Sensitive info scan patterns
│       │   └── tracking-templates.md # Tracking file templates
│       └── scripts/
│           ├── copy-project.sh       # Copy project (exclude .git)
│           ├── scan-secrets.sh       # Scan for secrets
│           └── init-tracking.sh      # Init tracking files
└── cn/                               # 🇨🇳 Chinese version
    └── all-project-auto-to-opensource/
        ├── SKILL.md
        ├── references/
        └── scripts/
```

## 🚀 Quick Start

1. **Install the skill:**
   ```bash
   npx skills add nicepkg/all-project-auto-to-opensource
   ```

2. **Tell your AI assistant:**
   > "Open source this project" / "帮我把这个项目开源"

3. **Follow the guided workflow** — The AI will:
   - Copy your project (never modifies originals)
   - Deep-scan for secrets, internal code, dead code
   - Present findings and wait for your decisions
   - Execute the approved plan with continuous testing
   - Generate a polished README based on the final result

## 🛡️ Security Features

- **Multi-layer secret scanning** — API keys, tokens, passwords, connection strings, cloud provider keys, PEM certificates
- **Internal reference detection** — Corporate URLs, private IPs, hardcoded paths, employee names
- **.gitignore-aware** — Won't delete files already protected by .gitignore
- **Double verification** — Runs security scan again after all changes, before final review

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Add translations for more languages
- Improve reference documents
- Add more language-specific templates
- Submit issues and feature requests

## 📄 License

MIT License — see [LICENSE](LICENSE).

---

<p align="center">
  <b>Stop worrying about what you forgot to clean up. Let the skill handle it.</b>
</p>
