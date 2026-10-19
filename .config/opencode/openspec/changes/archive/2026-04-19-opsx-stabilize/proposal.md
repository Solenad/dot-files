## Why

OpenSpec currently has apply and verify, but no dedicated stabilization entry point for post-apply bugs. A separate /opsx-stabilize flow would make recovery explicit, keep validation out of ad hoc chat, and give users one consistent command for bug-fix and re-verification before archive.

## What Changes

- Add a dedicated /opsx-stabilize command/skill flow for post-apply recovery.
- Make stabilization handle reproduce, isolate, and fix work before re-verification.
- Keep verify as the technical and UAT gate after stabilization.
- Allow failed verification to loop back into stabilization until the change is ready.
- Keep archive as the terminal step only after stabilization and verification succeed.
- **BREAKING**: this introduces a new command/skill entry point rather than reusing /opsx-apply alone for bug recovery.

## Capabilities

### New Capabilities
- opsx-stabilize: a dedicated stabilization command/skill for post-apply bug recovery, re-verification, and archive readiness.

### Modified Capabilities

## Impact

- OpenSpec command/skill surface for /opsx-stabilize
- Workflow guidance for bug recovery, UAT handoff, and archive readiness
- Change artifacts under openspec/changes/opsx-stabilize/
