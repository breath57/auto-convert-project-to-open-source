---
name: auto-convert-project-to-open-source
description: >
  Auto-convert any internal/private project into a production-ready open source project.
  Triggers: "open source", "opensource", "prepare for open source", "make it open source".
  Supports any language, any framework, any project type.
---

# Auto-Convert Project to Open Source

## 📏 Response Format (Mandatory)

**Every single message you send MUST begin with the progress bar code block below. No exceptions, no skipping, no omissions.**

The progress bar is your memory anchor — outputting it forces you to recall "where am I?". Not outputting it leads to drift.

````
```
📊 Open-Source Progress [{project-name}] ─ Target Level: L?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Phase 0 ⬜ Project Copy
Phase 1 ⬜ Deep Analysis           ← STOP: Present report, wait for user
Phase 2 ⬜ Proposal & Confirmation ← STOP: Wait for user to choose level
Phase 3 ⬜ Refactor Plan           ← STOP: Wait for user to review plan
Phase 4 ⬜ Init Tracking
Phase 5 ⬜ Execute Refactor        ← STOP: Ask user about uncertainties
  ├─ 5.1 ⬜ Security Cleanup
  ├─ 5.2 ⬜ Deep Pruning
  ├─ 5.3 ⬜ Code Cleanup
  ├─ 5.4 ⬜ Structure Normalization
  ├─ 5.5 ⬜ Dependency Cleanup
  ├─ 5.6 ⬜ Documentation (excl. README)
  ├─ 5.7 ⬜ CI/CD
  ├─ 5.8 ⬜ Test Additions
  └─ 5.9 ⬜ Git Preparation
Phase 6 ⬜ Test & Verify           ← STOP: Report results, wait for user
Phase 7 ⬜ README & Final Review   ← STOP: Collect materials, discuss style
Phase 8 ⬜ Follow-up Actions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Progress: 0/25 (0%) | Current: Not started
```
````

Icons: ✅ Done | 🔄 In progress | ⬜ Not started | ⏭️ Skipped | ❌ Failed

Update each line's icon as work progresses. Mark current phase with `🔄`, current step with `← Current`.

---

## 📋 Core Rules

1. **Never modify the original project** — Always work on a copy
2. **5 STOP points must pause for user** — Never make decisions for the user
3. **Progress tracking** — Maintain `.process.json` and `.checklist.json` throughout
4. **Test-driven** — Must pass tests after every change
5. **.gitignore protection** — Files excluded by .gitignore don't need deletion
6. **Aggressive pruning** — Ask user about uncertain items, decisively remove confirmed ones

See [references/anti-drift.md](references/anti-drift.md) for anti-drift mechanisms.

---

## Phase 0: Project Copy

Run `bash scripts/copy-project.sh` to copy the project (excluding .git/). All subsequent operations happen only in the copy.

After Phase 0, your response must look like:

> ````
> ```
> 📊 Open-Source Progress [my-project] ─ Target Level: TBD
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> Phase 0 ✅ Project Copy
> Phase 1 🔄 Deep Analysis           ← Current
> ...remaining Phases as ⬜...
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> Progress: 1/25 (4%) | Current: Phase 1 Deep Analysis
> ```
>
> Project copied to `my-project-auto-convert-open-source/`, XX files total. Original project will not be modified.
>
> Starting deep analysis...
> ````

---

## Phase 1: Deep Analysis

### 1.1 Project Identification
Detect language/framework, build system, project type, existing docs, and tests.

### 1.2 File Inventory
Categorize files by type, flag large files (>1MB), build artifacts, logs, caches, temp files.

### 1.3 Sensitive Information Scan
Run `bash scripts/scan-secrets.sh $TARGET_DIR`, refer to [references/sensitive-patterns.md](references/sensitive-patterns.md) for detailed patterns.

**.gitignore protection rules:**
- Already in .gitignore → Mark "no deletion needed"
- Not in .gitignore → Flag "needs action"
- Hardcoded in code → Flag "must clean"

### 1.4 Code Quality Assessment
Dead code, duplication, naming, error handling, type annotations, dependency health.

### 1.5 Structure Assessment
Language convention compliance, source/test/docs separation, clear entry points.

### 1.6 Test Status Assessment
Run existing tests, record coverage, flag critical modules lacking tests.

### 1.7 Deep Pruning Scan
Follow [references/deep-pruning.md](references/deep-pruning.md) for thorough scanning:
- **File-level**: Review directory by directory, classify as core/definite-remove/suggest-remove/uncertain
- **Code-logic-level**: Unreferenced code, internal-only logic, redundant implementations, commented code blocks
- **Test-level**: Redundant tests, outdated tests, internal integration tests

### 🚫 STOP-1: After Phase 1, you MUST stop

**After completing 1.1-1.7, this message ends here. Wait for user reply.**

Your response must look like:

> ````
> ```
> 📊 Open-Source Progress [my-project] ─ Target Level: TBD
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> Phase 0 ✅ Project Copy
> Phase 1 ✅ Deep Analysis           ← Just completed, awaiting confirmation
> Phase 2 ⬜ Proposal & Confirmation
> ...remaining as ⬜...
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> Progress: 2/25 (8%) | Awaiting user confirmation of analysis report
> ```
>
> ## Analysis Report
>
> **Project Overview:** Python project using uv for dependency management...
> **File Statistics:** 120 files total, 15 larger than 1MB...
> **Sensitive Info:** Found 3 hardcoded keys, 2 .env files (protected by .gitignore)...
> **Code Quality:** 5 unused imports, 2 commented code blocks...
> **Test Status:** 23 existing tests, 20 passing, 3 failing...
>
> ## Pruning Scan Results
>
> | Category | File Count |
> |----------|------------|
> | Core (keep) | 45 |
> | Definite remove | 30 |
> | Suggest remove | 12 |
> | Uncertain | 5 |
>
> **Suggested removal list:**
> 1. `scripts/internal_deploy.sh` — Internal deployment script
> 2. `src/legacy/old_parser.py` — Replaced by new_parser.py
> ...
>
> **Please review the analysis report and pruning results. Ask any questions, then confirm to proceed to proposal phase.**
> ````

**❌ Do NOT continue writing Phase 2 content after this message. You MUST wait for user reply.**

---

## Phase 2: Proposal & User Confirmation

### Determine Target Level

Present three levels to the user, **let them choose**:

| Level | Scope |
|-------|-------|
| **L1 Basic** | Security + License + README + .gitignore |
| **L2 Standard** | L1 + Code cleanup + Tests + CI + CONTRIBUTING |
| **L3 Professional** | L2 + API docs + Architecture docs + Examples + Badges |

### Group Proposals
1. **Must do** — Security, License, README
2. **Should do** — Code cleanup, structure normalization, tests
3. **Nice to have** — API docs, badges, advanced CI

### Project Naming Recommendation
Evaluate whether the current name is suitable for open source. If not ideal (too internal, too long, contains company name, hard to search), suggest 3-5 alternatives with reasoning. Consider:
- Short, memorable, easy to spell
- Reflects core functionality
- Not taken on PyPI/npm/crates.io (if checkable)
- No conflicts with well-known projects

### Pruning List Final Confirmation
Based on Phase 1.7 report, list all "suggest remove" and "uncertain" items for user to confirm one by one.

### 🚫 STOP-2: Wait for user to choose level, confirm name and plan

**❌ Do NOT choose a level for the user. You MUST wait for explicit reply.**

---

## Phase 3: Refactor Plan & Second Confirmation

Generate `$TARGET_DIR/.plan.md`, using template from [references/tracking-templates.md](references/tracking-templates.md).

Includes: detailed steps (file-level detail), file operation summary, risk assessment, test verification plan.

### 🚫 STOP-3: Present plan, wait for user confirmation

**❌ Do NOT start execution after generating the plan. You MUST wait for user to say "confirm" or "continue".**

---

## Phase 4: Initialize Tracking Files

Run `bash scripts/init-tracking.sh $TARGET_DIR {user-chosen-level}`, creating `.process.json` and `.checklist.json`.

Templates in [references/tracking-templates.md](references/tracking-templates.md). This is a purely technical step, no user confirmation needed — proceed directly to Phase 5.

---

## Phase 5: Execute Refactor

After each step: update .process.json → output "✅ Step X.Y complete"

### 5.1 Security Cleanup (always first)
- Hardcoded secrets → Replace with placeholders (`YOUR_API_KEY_HERE`)
- Sensitive files not in .gitignore → Add to .gitignore + create .env.example
- Already protected by .gitignore → Don't delete, just annotate
- Re-run `scripts/scan-secrets.sh` after cleanup to confirm

### 5.2 Deep Pruning
Follow [references/deep-pruning.md](references/deep-pruning.md) in three layers:
1. File-level → 2. Code-logic-level → 3. Test-level

**Run tests immediately after each batch of deletions.** If tests fail, check for accidental deletions.

### 🚫 STOP-4: When encountering uncertain items, stop and ask user

**❌ Do NOT decide to delete uncertain files on your own.**

### 5.3 Code Cleanup
Dead code, unused imports, debug prints, TODO/FIXME comments.

### 5.4 Structure Normalization
Reorganize per language conventions, fix import paths, **verify build immediately after reorganization**.

### 5.5 Dependency Cleanup
Remove unused dependencies, regenerate lock files.

### 5.6 Documentation (excluding README)
Generate docs per target level. Templates in [references/project-standards.md](references/project-standards.md).

**⚠️ README.md is NOT generated in this step.** README must be generated in Phase 7 based on final code after all refactoring is complete and tests pass.

| File | L1 | L2 | L3 |
|------|----|----|---- |
| LICENSE | Required | Required | Required |
| .gitignore | Required | Required | Required |
| CONTRIBUTING.md | — | Required | Required |
| CHANGELOG.md | — | Optional | Required |
| CODE_OF_CONDUCT.md | — | Optional | Required |
| SECURITY.md | — | — | Required |

### 5.7 CI/CD Configuration (if in scope)
GitHub Actions workflows, templates in [references/project-standards.md](references/project-standards.md).

### 5.8 Test Additions (if in plan)
Add missing tests per Phase 2 test strategy.

### 5.9 Git Preparation
Complete .gitignore, prepare initial commit message. Do not execute `git init`.

### Uncertainty Handling
- Low risk (`__pycache__`, `.DS_Store`) → Handle directly
- Medium risk (possibly referenced) → **Stop and ask user**
- High risk (core logic) → **Stop and discuss**

---

## Phase 6: Test & Verification

> No refactoring is complete without passing test verification.

1. **Run all tests** — Record pass/fail/skip counts
2. **Handle failures** — Analyze causes, fix and re-run. **Never skip failing tests.**
3. **Build verification** — Clean install/build from scratch
4. **Entry point verification** — Main entry points and example code
5. **Lint check** — Run linters (if available)
6. **Second sensitive info scan** — Run `scripts/scan-secrets.sh`
7. **Documentation verification** — Links valid, examples accurate, install steps work

### 🚫 STOP-5: Report test results, wait for user confirmation

**❌ Do NOT proceed to Phase 7 after tests complete. You MUST wait for user reply.**

---

## Phase 7: README Generation & Final Review

README is the face of an open source project — must be generated based on **final code**, not written mid-refactor.

### 🚫 STOP-6: Collect README materials, discuss style

Before writing README, ask user for materials:

> All refactoring complete, tests passing. Now let's write the README — the project's front door.
>
> **Before I start, please provide (whatever you have):**
>
> 1. **Project logo** — Place in `assets/` or `docs/images/`
> 2. **Screenshots / demos** — Running results, UI screenshots, architecture diagrams
> 3. **Demo GIF** — Usage demonstration animation
> 4. **One-liner description** — How would you describe the project's core value?
> 5. **README style preference:**
>    - A. Concise technical (straight to the point, like `httpx`, `ruff`)
>    - B. Comprehensive docs (detailed, like `fastapi`)
>    - C. Visual appeal (badges + GIF + screenshots, like `rich`)
>    - D. Reference a specific project?

**❌ Do NOT write README without asking user first.**

### 7.1 Generate README

After user reply, write README.md from scratch based on **final code**:
- Old README with outdated content → Delete and rewrite, don't patch
- Content must be based on actual directory structure, API, entry points, installation
- User provided logo/screenshots → Reference correct paths in README
- Install steps must match what was verified in Phase 6
- If Phase 2 determined a new project name → README uses new name
- Structure reference: [references/project-standards.md](references/project-standards.md)

### 7.2 Final Checklist

1. Walk through `.checklist.json` verifying each item
2. Review `.process.json` confirming all steps complete
3. Present final report (files created/deleted/modified, test results, security scan status)

---

## Phase 8: Follow-up Actions

Ask user which follow-up actions they need:
1. New repo initialization (`git init` + initial commit)
2. If Phase 2 determined a new project name, rename directory
3. Remote repo setup (if GitHub CLI available)
4. Clean up tracking files (.process.json, .checklist.json, .plan.md)

---

## Interrupt Recovery

If `.process.json` exists: read progress → report to user → confirm before continuing.

---

## Reference Files

| File | Content |
|------|---------|
| [references/anti-drift.md](references/anti-drift.md) | 6 anti-drift mechanisms (incl. progress bar template) |
| [references/deep-pruning.md](references/deep-pruning.md) | Deep pruning scan guide (scan items + report template + execution checklist) |
| [references/tracking-templates.md](references/tracking-templates.md) | .process.json / .checklist.json / .plan.md templates |
| [references/sensitive-patterns.md](references/sensitive-patterns.md) | Comprehensive sensitive info scan patterns |
| [references/project-standards.md](references/project-standards.md) | Open source project structure standards and README/CI templates |
| [references/cleanup-checklist.md](references/cleanup-checklist.md) | Detailed cleanup checklist by category |

## Scripts

| Script | Purpose |
|--------|---------|
| [scripts/copy-project.sh](scripts/copy-project.sh) | Copy project to working directory (excluding .git) |
| [scripts/scan-secrets.sh](scripts/scan-secrets.sh) | Scan for sensitive info (secrets/paths/IPs/connection strings) |
| [scripts/init-tracking.sh](scripts/init-tracking.sh) | Initialize .process.json and .checklist.json |
