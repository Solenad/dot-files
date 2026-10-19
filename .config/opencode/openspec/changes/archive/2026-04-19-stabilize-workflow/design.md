## Context

OpenSpec currently has apply, verify, validate, and archive, but no formal stabilization gate. The intended lifecycle is Apply -> Stabilize -> Verify -> Archive. Stabilize handles bug recovery, verify performs technical checks plus a separate UAT signoff artifact, and any failure in verify returns the change to Stabilize before archive is allowed.

Flow
- Apply
- Stabilize: reproduce, isolate, fix
- Verify: technical checks plus UAT signoff artifact
- If technical checks fail or UAT fails, return to Stabilize and retry Verify
- Archive only after a full verify pass

## Goals / Non-Goals

**Goals:**

- Add a distinct stabilization phase between apply and verify.
- Make bug recovery repeatable: reproduce, isolate, fix, and then re-enter verification.
- Keep verify focused on technical correctness plus UAT signoff.
- Make verification binary: no partial pass, and any failed technical or UAT check returns to stabilize.
- Make the workflow available globally through config and schema resolution.
- Preserve existing project-level overrides and schema precedence.

**Non-Goals:**

- Replace validate or archive.
- Build a runtime debugging engine or issue tracker.
- Force every project to adopt the new workflow immediately if they have their own local schema.
- Treat partial pass as archive-eligible state.

## Decisions

### 1. Separate stabilize phase instead of broadening verify

The change should add stabilize as its own phase. Verify remains the final readiness gate, while stabilize handles bug recovery before acceptance.
Alternative considered: extend verify to absorb all recovery work. Rejected because it blurs the boundary between fixing defects and confirming readiness.

### 2. Verify is the explicit acceptance gate with retry

Use verify as the place for technical checks and UAT signoff after stabilize. Verification is binary: technical checks and UAT signoff must both pass. If either fails, the workflow returns to stabilize, and verify runs again after the fix.
Alternative considered: partial pass states or a technical-pass/UAT-fail intermediate state. Rejected because archive readiness must remain unambiguous.

### 3. UAT signoff is a dedicated artifact

Capture UAT signoff as its own artifact so user approval is explicit, auditable, and separate from the technical verification result.
Alternative considered: encode UAT only as a transient status inside verify. Rejected because it hides the user-approval boundary.

### 4. Global schema-backed workflow

Define the workflow as a reusable global schema in ~/.local/share/openspec/schemas/stabilize-workflow/ and enable it through ~/.config/openspec/config.json. This keeps the behavior portable across all projects on the machine.
Alternative considered: project-only schema. Rejected because the goal is a global workflow for multiple projects.

### 5. Preserve precedence rules

Global schema resolution should respect the existing precedence model: CLI flags > project schemas > user/global schemas > built-in schemas. This allows local project exceptions without breaking the global default.
Alternative considered: global-only enforcement. Rejected because it would be too rigid for edge cases.

### 6. Archive remains the terminal state

Archive remains the final action after stabilize and verify pass. It should not become the place where bugs are discovered.
Alternative considered: archive with warnings. Rejected because warnings do not prevent incomplete changes from being stored as done.

## Risks / Trade-offs

- Extra workflow steps may feel heavy -> Mitigation: keep the stabilize checklist short and deterministic.
- UAT signoff as a dedicated artifact adds one more file -> Mitigation: keep the artifact small and binary.
- Global schema files may drift from project needs -> Mitigation: allow project-level override through existing precedence.
- Missing ~/.local/share/openspec/schemas/ directory may block setup -> Mitigation: create it during installation or first schema init.
- Retry cycles can feel repetitive -> Mitigation: keep the retry path binary and always return to stabilize before a fresh verify.

## Migration Plan

1. Create the global schema directory if it is absent.
2. Add the stabilize-workflow schema and enable it in config.json via the custom profile and workflow list.
3. Update project onboarding to recognize the new Apply -> Stabilize -> Verify -> Archive flow.
4. Validate that existing projects still resolve built-in workflows if they do not opt in.

Rollback: remove the stabilize workflow from config.json, delete the global schema directory, and revert any docs or onboarding references.

## Open Questions

- None. The retry path, UAT artifact boundary, and no-partial-pass rule are resolved in this design.
