---
name: openspec-opsx-stabilize
description: Stabilize a change after apply by guiding through bug recovery, re-verification, and UAT handoff before archive.
license: MIT
compatibility: Requires openspec CLI with stabilize-workflow schema.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "@fission-ai/openspec"
---

# Skill: openspec-opsx-stabilize

Use when a change has completed apply but needs stabilization before archive. This skill guides users through bug recovery, verification, and archive readiness for changes using the stabilize-workflow schema.

## When to Use

- After `/opsx-apply` when bugs are discovered post-implementation
- When verification fails and the change needs fixes before re-verification
- For UAT handoff and signoff collection
- When archive is blocked pending stabilization and verification completion

## Input

**Change name** (optional): Target change to stabilize. If omitted, infer from context or prompt for selection.

## Steps

### 1. Select the change

If a name is provided, use it. Otherwise:
- Infer from conversation context if the user mentioned a change
- Auto-select if only one active change exists
- If ambiguous, run `openspec list --json` and use AskUserQuestion tool

Always announce: "Stabilizing change: <name>"

### 2. Check status and detect schema

Run `openspec status --change "<name>" --json` to understand:
- `schemaName`: Must be "stabilize-workflow" or compatible
- Current artifact completion status
- Whether UAT signoff exists

### 3. Load context files

Read artifacts from the change:
- `proposal.md`: Original intent and acceptance criteria
- `specs/`: Requirements and scenarios
- `design.md`: Technical decisions and risks
- `tasks.md`: Implementation status (what completed vs pending)
- `uat-signoff.md`: Human acceptance artifact (if exists)

### 4. Guide stabilization workflow

**Bug Recovery Loop:**
- Identify the defect from context or user input
- Guide through reproduce → isolate → fix
- After fixes, update tasks.md to reflect completion
- Mark progress in real-time

**UAT Handoff:**
- If `uat-signoff.md` does not exist, create it
- Prompt user for UAT reviewer, date, and result
- Record acceptance decision in the artifact

### 5. Prepare for verification

Once stabilization completes:
- Verify tasks.md shows all tasks complete
- Confirm `uat-signoff.md` exists with approval
- Prompt user to run `/opsx-verify` for final validation

**If verification fails:** return to Step 4 for another stabilization cycle.

### 6. Completion and archive readiness

When both stabilization and verification succeed:
- Display summary: changes made, UAT result, verification status
- Confirm archive is now unblocked
- Suggest `/opsx-archive` to finalize the change

## Output During Stabilization

```
## Stabilizing: <change-name> (schema: stabilize-workflow)

Step 1/3: Bug reproduction
- Identified issue: <description>
- Reproduction steps confirmed

Step 2/3: Root cause isolation  
- Isolated to: <component/file>

Step 3/3: Fix and re-verify preparation
- Fix applied: <summary>
- Tasks updated: [x] Task N
```

## Output On Completion

```
## Stabilization Complete
**Change:** <change-name>
**Schema:** stabilize-workflow
**UAT Status:** ✓ Approved / ✗ Rejected

Bug recovery complete. Ready for verification.
Run `/opsx-verify` to proceed to acceptance gate.
```

## Output On Verification Loop

```
## Stabilization Loop
**Change:** <change-name>
**Schema:** stabilize-workflow

Verification failed. Returning to stabilization.
Continue bug recovery, then re-verify.
```

## Guardrails

- Require stabilize-workflow schema; fail gracefully if incompatible
- Always create `uat-signoff.md` before suggesting verify
- Failed verification must return to stabilization, not skip to archive
- Keep changes minimal; focus on fixes, not scope expansion
- Pause if stabilization reveals design-level issues; suggest updating design.md
- Archive is blocked until verify succeeds
