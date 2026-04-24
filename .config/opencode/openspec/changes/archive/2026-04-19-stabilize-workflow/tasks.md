## 1. Global schema and configuration

- [x] 1.1 Create the global stabilize-workflow schema directory under ~/.local/share/openspec/schemas/
- [x] 1.2 Define the stabilize-workflow schema with explicit Apply -> Stabilize -> Verify -> Archive flow
- [x] 1.3 Update ~/.config/openspec/config.json to enable the custom global workflow profile

## 2. Stabilization and verification behavior

- [x] 2.1 Define the apply-to-stabilize transition and block direct archive
- [x] 2.2 Add reproduce, isolate, and fix checkpoints inside stabilize
- [x] 2.3 Make verify perform technical checks and write UAT signoff as a separate artifact
- [x] 2.4 Make verify failures return to stabilize for a fresh retry cycle
- [x] 2.5 Require archive only after verify passes with no partial states

## 3. Validation and rollout

- [x] 3.1 Document the workflow direction for global projects and onboarding
- [x] 3.2 Validate schema resolution and workflow availability across projects
- [x] 3.3 Confirm rollback by removing the schema and config entry
