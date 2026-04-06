# Anti-Drift & Anti-Forgetting Mechanisms

> Agent MUST read and follow all mechanisms in this document before executing any phase.

---

## Mechanism 1: Phase Gate

Before entering each phase, perform these checks:

```
┌─────────────────────────────────────────┐
│ Phase Gate Check (before entering N)     │
├─────────────────────────────────────────┤
│ 1. Review .process.json for progress     │
│ 2. Confirm Phase N-1 steps = completed   │
│ 3. Mark new phase as in-progress         │
│ 4. Brief user:                           │
│    "Entering Phase N: {phase name}       │
│     Completed: {completed list}          │
│     Remaining: {remaining steps}"        │
└─────────────────────────────────────────┘
```

---

## Mechanism 2: Step-Level Tracking

After each step, immediately:
1. Update step status in `.process.json`
2. Update corresponding todo_list entry
3. Output confirmation: "✅ Step X.Y complete: {description}"

**No batch completions** — mark one step at a time.

---

## Mechanism 3: Self-Check Heartbeat

Every 3 completed steps, perform a self-check:

```
┌─────────────────────────────────────────┐
│ 🔍 Self-Check Point                     │
├─────────────────────────────────────────┤
│ Current Phase: Phase X - {name}          │
│ Total Progress: M/N steps completed      │
│ Current Task: {what you're doing}        │
│ Drifted?: {compare against .plan.md}     │
│ Next Step: {what's next}                 │
└─────────────────────────────────────────┘
```

If drift detected: stop immediately, return to plan, report deviation to user.

---

## Mechanism 4: Completion Gate

Before leaving Phase N:
1. Check all sub-steps → all completed
2. If any skipped → must have annotated reason
3. Summarize phase results to user

---

## Mechanism 5: Context Anchor

After each user interaction, re-anchor:
```
Current Position: Phase X > Step Y
Overall Goal: Open-source {project name}, target level {L1/L2/L3}
Remaining Steps: {brief list}
```

---

## Mechanism 6: Persistent Progress Bar ⭐⭐⭐ (Most Important)

> **Every reply to user MUST start with the progress bar. No exceptions.**

**Format Template:**

```
📊 Open-Source Progress [{project-name}] ─ Target Level: {L1/L2/L3}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Phase 0 ✅ Project Copy
Phase 1 ✅ Deep Analysis
Phase 2 ✅ Proposal Confirmed
Phase 3 ✅ Refactor Plan
Phase 4 ✅ Init Tracking
Phase 5 🔄 Execute Refactor        ← Current Phase
  ├─ 5.1 ✅ Security Cleanup
  ├─ 5.2 🔄 Deep Pruning           ← Current Step
  ├─ 5.3 ⬜ Code Cleanup
  ├─ 5.4 ⬜ Structure Normalization
  ├─ 5.5 ⬜ Dependency Cleanup
  ├─ 5.6 ⬜ Documentation
  ├─ 5.7 ⬜ CI/CD
  ├─ 5.8 ⬜ Test Additions
  └─ 5.9 ⬜ Git Preparation
Phase 6 ⬜ Test & Verify
Phase 7 ⬜ Final Review
Phase 8 ⬜ Follow-up
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Progress: 12/25 steps completed (48%)  |  Current: Deep Pruning - File-level
```

**Icon meanings:** ✅ Done | 🔄 In progress | ⬜ Not started | ⏭️ Skipped | ❌ Failed/Blocked

**When to show:** Every reply to user (at the top). Only exception: pure confirmation replies (e.g., "OK").

---

## Anti-Forgetting Checklist (Agent Self-Use)

### Every step
- [ ] **Output progress bar** (every reply, no exceptions)
- [ ] Update .process.json
- [ ] Update todo_list
- [ ] Confirm completion to user

### Every 3 steps
- [ ] Self-check (against .plan.md)
- [ ] Check for plan drift
- [ ] Update anti_drift_log

### End of each phase
- [ ] Completion gate (all sub-steps completed)
- [ ] Summarize phase results to user
- [ ] Phase gate check (next phase)

### Never forget
- [ ] Files protected by .gitignore don't need deletion
- [ ] Must run tests after code changes
- [ ] Never skip failing tests
- [ ] Ask user for critical decisions
- [ ] Stay in $TARGET_DIR, don't touch original project
- [ ] Deep pruning needs thorough time, no rushing
- [ ] Uncertain files/code must be confirmed with user, never delete unilaterally
- [ ] Run tests immediately after each batch of deletions
