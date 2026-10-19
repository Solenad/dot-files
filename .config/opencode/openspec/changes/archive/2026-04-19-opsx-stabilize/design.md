## Context

OpenSpec has `/opsx-apply` for implementation and `/opsx-verify` for pre-archive validation, but lacks a dedicated stabilization phase for post-apply bug recovery. The `stabilize-workflow` schema exists but there is no command/skill to invoke it.

## Goals / Non-Goals

**Goals:**
- Create `/opsx-stabilize` as a dedicated command/skill for post-apply stabilization
- Match the style of other OPSX commands
- Support reproduce/isolate/fix checkpoints
- Integrate with the `stabilize-workflow` schema

**Non-Goals:**
- Replace `/opsx-apply` or `/opsx-verify`
- Support partial-pass states

## Decisions

### Command style matches OPSX pattern
`/opsx-stabilize` follows the same pattern as `/opsx-apply` for consistency.

### Stabilization is post-apply
Invoked after apply completes, handling recovery separately from implementation.

### Failed verification returns to stabilize
Verification failures (technical or UAT) loop back to stabilization for fixes.

## Risks / Trade-offs

- User confusion → Mitigation: Clear documentation
