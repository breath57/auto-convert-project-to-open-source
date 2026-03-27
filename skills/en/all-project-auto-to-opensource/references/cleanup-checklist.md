# Cleanup Checklist

Detailed open-source preparation checklist organized by category.
Used during Phase 1 analysis and Phase 7 final review.

## Table of Contents
- [Security](#security)
- [Deep Pruning](#deep-pruning)
- [Files & Structure](#files--structure)
- [Code Quality](#code-quality)
- [Dependencies](#dependencies)
- [Documentation](#documentation)
- [Git & CI](#git--ci)
- [Final Verification](#final-verification)

---

## Security

### Secrets & Credentials
- [ ] No API keys, tokens, or secrets in source code
- [ ] No passwords or credentials in config files
- [ ] No committed private keys or certificates
- [ ] `.env` files handled (see .gitignore protection rules below), `.env.example` created with placeholders
- [ ] No hardcoded database connection strings with real credentials
- [ ] No OAuth client secrets in source code

**⚠️ .gitignore Protection Rules:**
- Sensitive files already in .gitignore → Mark "protected", no deletion needed
- Sensitive files NOT in .gitignore → Add to .gitignore or delete

### Internal References
- [ ] No internal/corporate URLs, hostnames, or IP addresses
- [ ] No hardcoded paths with usernames (`/home/user/`, `/Users/name/`)
- [ ] No internal tool references or proprietary system names
- [ ] No employee names, emails, or internal identifiers in code/comments
- [ ] No internal JIRA/ticket references (clean or generalize)

### Git History (if preserving history)
- [ ] Secrets never appeared in git history (check with `git log -p -S 'secret_pattern'`)
- [ ] No large binary files in history causing repo bloat

---

## Deep Pruning

> Goal: Keep only the open-source core, trim everything unnecessary.

### File-Level Pruning
- [ ] Internal tools/deployment scripts removed (scripts only for internal workflows)
- [ ] Experimental/draft/POC code removed
- [ ] Output directories (output/, result/, generated/) emptied or removed
- [ ] Duplicate files of same functionality reduced to one version
- [ ] Excessively large test data/sample files removed or trimmed
- [ ] Internal documentation drafts (TODOs, research notes, meeting notes) removed
- [ ] Docker/config files only for internal deployment removed

### Code-Logic Pruning
- [ ] Unreferenced modules/classes/functions removed
- [ ] Internal-only code paths removed (internal API integration, internal auth, etc.)
- [ ] Redundant implementations of same functionality merged/simplified
- [ ] Over-wrapped single-use functions inlined
- [ ] Commented code blocks longer than 5 lines cleaned up
- [ ] Deprecated feature flags and associated code removed
- [ ] Code tightly coupled to internal systems removed or replaced with configurable interfaces

### Test Pruning
- [ ] Outdated tests for deleted features removed
- [ ] Integration tests depending on internal services/environments removed
- [ ] Duplicate test cases merged/simplified
- [ ] Oversized test fixtures trimmed to minimal necessary data
- [ ] Flaky tests fixed or removed

### Pruning Verification
- [ ] Tests run after each batch of deletions to confirm no accidental removal
- [ ] All "suggested removal" items confirmed with user
- [ ] All "uncertain" items confirmed with user
- [ ] Project still builds and runs after pruning

---

## Files & Structure

### Files to Delete
- [ ] Build artifacts (`dist/`, `build/`, `*.pyc`, `__pycache__/`)
- [ ] IDE/editor files (`.idea/`, `.vscode/` configs, `*.swp`)
- [ ] System files (`.DS_Store`, `Thumbs.db`, `desktop.ini`)
- [ ] Log files (`*.log`, `logs/`)
- [ ] Temporary files (`*.tmp`, `*.bak`, `*.orig`)
- [ ] Output/generated files users don't need
- [ ] Test output/coverage reports
- [ ] Docker/VM artifacts not needed for distribution
- [ ] Personal notes, TODO lists, draft files

### Files to Keep/Create
- [ ] `LICENSE` exists at root
- [ ] `README.md` exists at root
- [ ] `.gitignore` is comprehensive and correct
- [ ] Source code in clear directory (`src/`, `lib/`, or language convention)
- [ ] Tests in dedicated directory (`tests/`, `test/`, `__tests__/`)
- [ ] Examples in `examples/` if applicable

### Structure Quality
- [ ] No empty directories
- [ ] No deeply nested single-file directories (flatten where possible)
- [ ] Clear separation of concerns (source / test / docs / config)
- [ ] Entry points are clear and documented

---

## Code Quality

### Dead Code
- [ ] No unused imports
- [ ] No unreachable code blocks
- [ ] No commented-out code blocks (either restore or delete)
- [ ] No unused functions, classes, or variables
- [ ] No leftover debug code (`print("DEBUG")`, `console.log("test")`)
- [ ] No do-nothing placeholder/stub functions

### Code Standards
- [ ] Consistent naming conventions throughout project
- [ ] Consistent code formatting (ideally enforced by formatter config)
- [ ] Reasonable function/method length
- [ ] Adequate error handling (no bare `except:` or swallowed errors)
- [ ] No unexplained hardcoded magic numbers
- [ ] Public APIs have type annotations (for typed languages)

### Comments & Documentation
- [ ] No TODO/FIXME/HACK/XXX comments that should have been resolved
- [ ] No misleading or outdated comments
- [ ] Complex logic has explanatory comments
- [ ] Public functions have docstrings (for languages that support them)

---

## Dependencies

- [ ] No unused dependencies in manifest
- [ ] No critically outdated pinned versions (security risk)
- [ ] Version constraints are reasonable (not too loose or tight)
- [ ] Lock file is up-to-date and consistent with manifest
- [ ] No internal/private package registry references
- [ ] No dependencies on private/internal packages
- [ ] Dev dependencies properly separated from production
- [ ] No undocumented system-specific dependencies

---

## Documentation

### README
- [ ] Project name and one-line description
- [ ] What problem it solves / why it exists
- [ ] Installation instructions (copy-pasteable)
- [ ] Quick start / minimal usage example
- [ ] License reference
- [ ] Links to more documentation (if available)

### Supplementary Docs (L2+)
- [ ] CONTRIBUTING.md explains how to contribute
- [ ] CHANGELOG.md has at least one entry
- [ ] All code examples in docs actually work
- [ ] All links in docs are valid (no broken links)
- [ ] No unexplained internal jargon

### API Documentation (L3, if applicable)
- [ ] Public API is documented
- [ ] Common use cases have examples
- [ ] Parameter types and return types are documented

---

## Git & CI

### .gitignore
- [ ] Language-specific ignores (e.g., `__pycache__/` for Python)
- [ ] IDE/editor files ignored
- [ ] System-specific files ignored
- [ ] Build output ignored
- [ ] Environment/secret files ignored
- [ ] Log files ignored

### CI/CD (L2+)
- [ ] CI config exists and has valid syntax
- [ ] Tests run in CI
- [ ] Lint runs in CI
- [ ] CI runs on PRs to main branch
- [ ] CI matrix covers supported versions

### Repository Settings (post-push)
- [ ] Default branch is `main`
- [ ] Branch protection on `main` (optional but recommended)
- [ ] Topics/tags set for discoverability
- [ ] Description filled in

---

## Final Verification

### Build & Run
- [ ] Project installs from scratch in clean environment
- [ ] All tests pass
- [ ] Main entry point runs without errors
- [ ] Example code works as documented

### Second Sensitive Info Scan
- [ ] Final secret pattern grep scan is clean
- [ ] No internal paths remain
- [ ] No private IPs or internal hostnames remain

### Completeness
- [ ] All planned items in `.process.json` are completed or intentionally skipped
- [ ] All check items in `.checklist.json` are verified
- [ ] User has reviewed and approved final state
