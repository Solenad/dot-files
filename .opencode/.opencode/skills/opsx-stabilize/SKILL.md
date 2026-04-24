---
name: opsx-stabilize
description: Dedicated stabilization command/skill for post-apply bug recovery and verification.
license: MIT
compatibility: Requires OpenSpec CLI.
metadata:
  author: Rohann
  version: "1.0"
  generatedBy: "opsx-stabilize skill"
---

Implement a dedicated stabilization phase after `/opsx-apply`.

**Input**: Optional change name (default current change).

**Steps**
1. Verify the change uses the `stabilize-workflow` schema.
2. Run stabilization steps:
   - Reproduce the issue.
   - Isolate root cause.
   - Apply fix.
3. After fix, invoke `/opsx-verify` automatically.
4. If verification passes, prompt for archive; otherwise, loop back to step 2.

**Guardrails**
- Only operates on changes with the `stabilize-workflow` schema.
- Requires explicit user confirmation before looping.
