## 1. Trigger Review and Scope

- [ ] 1.1 Review the current backend skill metadata for overlapping trigger language.
- [ ] 1.2 Confirm the exact skill files that participate in the backend gateway path.
- [ ] 1.3 Keep backend debugging out of scope for this change.

## 2. Update Skill Metadata

- [ ] 2.1 Strengthen `backend-defensive-engineering` trigger language for repo-wide backend work.
- [ ] 2.2 Narrow `backend-core-architecture-contracts` trigger language to architecture boundaries only.
- [ ] 2.3 Narrow `backend-runtime-safety-lifecycle` trigger language to lifecycle and health concerns only.
- [ ] 2.4 Narrow `backend-node-init-minimal` trigger language to bootstrap and setup only.
- [ ] 2.5 Narrow Redis companion skills so they only activate for Redis-specific concerns.

## 3. Validation

- [ ] 3.1 Verify planning, spec, and implementation prompts still select the backend gateway first.
- [ ] 3.2 Verify companion skills only activate when their specific concern is present.
- [ ] 3.3 Run OpenSpec validation or status checks and confirm the change is ready for apply.
