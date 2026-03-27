# Deep Pruning Scan Guide

> Goal: Keep only the open-source core, cut everything unnecessary. Spend enough time scanning each item thoroughly — no skimming.

---

## 1. File-Level Scan

Review every directory and file, classify into:

| Category | Description | Action |
|----------|-------------|--------|
| **Core** | Must-keep source code, configs, docs for open source | Keep |
| **Definite Remove** | Logs, caches, build artifacts, IDE configs, system files | Delete directly |
| **Suggest Remove** | Internal tool scripts, debug files, experimental code, personal notes | List reasoning, wait for user confirmation |
| **Uncertain** | Unknown purpose or unclear if referenced | Flag and ask user |

### Key Focus Areas
- **Internal tools/scripts**: Scripts only for internal workflows (deployment, internal CI, data migration, etc.)
- **Experimental/draft code**: Incomplete features, poc directories, scratch files
- **Output examples**: output/, result/, generated/ directories
- **Duplicate files**: Multiple versions of same functionality (v1/v2/backup)
- **Large data files**: Test datasets, sample files, database dumps
- **Documentation drafts**: Internal TODOs, research notes, meeting notes
- **Docker/deployment artifacts**: Configs only for internal deployment

---

## 2. Code-Logic-Level Scan

Go deep into the code to find logic that should be cleaned:

- **Unused modules/classes/functions**: Find never-called code through reference analysis
- **Internal-only logic**: Code paths serving only internal systems (internal API integration, internal auth)
- **Redundant implementations**: Multiple implementations of same functionality (historical legacy)
- **Over-wrapping**: Utility functions/classes called only once, can be inlined
- **Commented-out code blocks**: More than 5 lines of commented code
- **Deprecated feature flags**: Feature flag code no longer needed
- **Hardcoded internal business logic**: Code tightly coupled to internal systems

---

## 3. Test Case Scan

- **Redundant tests**: Duplicate test cases for same functionality
- **Outdated tests**: Tests for deleted/refactored features
- **Internal integration tests**: Tests depending on internal services/environments
- **Test helper files**: Oversized fixtures/mock data used only by tests
- **Flaky tests**: Unstable tests that pass intermittently

---

## 4. Pruning Report Template

After scanning, present to user:

```
┌─────────────────────────────────────────────┐
│ 📦 Deep Pruning Scan Report                  │
├─────────────────────────────────────────────┤
│                                             │
│ 📁 File Statistics:                          │
│   Total files: {total}                       │
│   Core (keep): {keep} ({keep_pct}%)          │
│   Suggest delete: {delete} ({del_pct}%)      │
│   Uncertain: {uncertain} ({unc_pct}%)        │
│                                             │
│ 🔴 Definite Remove (no confirmation needed): │
│   - logs/ (log directory, {n} files)         │
│   - __pycache__/ (cache)                     │
│   - ...                                     │
│                                             │
│ 🟡 Suggest Remove (please confirm):          │
│   - scripts/internal_deploy.sh              │
│     → Reason: Internal deploy script         │
│   - src/legacy/old_parser.py                │
│     → Reason: Replaced by new_parser.py      │
│   - tests/test_internal_api.py              │
│     → Reason: Tests internal API             │
│                                             │
│ 🟠 Uncertain (need your judgment):           │
│   - utils/data_migration.py                 │
│     → Question: Unclear if still in use      │
│                                             │
│ 🧹 Code Logic Cleanup Suggestions:           │
│   - src/auth.py: internal_sso_login()        │
│     Never called externally, suggest remove  │
│   - src/core.py L45-L82: Commented old impl  │
│                                             │
│ 🧪 Test Cleanup Suggestions:                 │
│   - tests/test_old_feature.py: Tests deleted │
│   - tests/test_integration.py: Needs intl svc│
└─────────────────────────────────────────────┘
```

**⏸️ Wait for user to confirm each "Suggest Remove" and "Uncertain" item before executing.**

---

## 5. Pruning Execution Checklist

Execute in three layers:

### 5.1 File-Level Pruning
- Delete all files/directories user confirmed for removal
- Delete definite-remove items (logs, caches, build artifacts, temp files)
- Delete internal tool scripts, experimental code, draft files
- Delete oversized non-essential data files
- Delete duplicate files (keep latest/best version)
- Update `.gitignore`
- **Note**: Do NOT delete files protected by .gitignore

### 5.2 Code-Logic Pruning
- Remove user-confirmed internal-only code paths
- Remove unreferenced modules/classes/functions
- Inline single-use redundant wrappers
- Clean up deprecated feature flags and associated code
- Remove code tightly coupled to internal systems (or replace with configurable interfaces)

### 5.3 Test Pruning
- Delete outdated tests for removed features
- Delete integration tests depending on internal services/environments
- Merge/simplify duplicate test cases
- Trim oversized test fixtures (replace with minimal necessary data)
- Keep all core functionality tests

**⚠️ Run tests immediately after each batch of file deletions.**
