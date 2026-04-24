## Why

OpenSpec needs a clearer post-apply lifecycle so bug fixing does not disappear into ad hoc chat. Splitting stabilization from verification makes recovery explicit while keeping the final readiness gate visible for global projects.

## What Changes

- Add a new stabilize phase between apply and verify.
- Keep verify as the explicit gate for technical checks and UAT signoff.
- Block archive until verify passes.
- Keep stabilization focused on reproduce, isolate, and fix.
- Make the workflow usable globally through config and schema resolution.
- BREAKING: changes can no longer move from apply directly to archive.

## Capabilities

### New Capabilities
- stabilize-workflow: a staged post-apply workflow where stabilize handles bug recovery, verify handles technical validation and UAT signoff, and archive only follows a verified result.

### Modified Capabilities

## Impact

- Global workflow configuration in ~/.config/openspec/config.json
- Global schema definitions in ~/.local/share/openspec/schemas/
- OpenSpec lifecycle docs and change artifacts under openspec/changes/stabilize-workflow/
- Archive readiness rules across all projects
