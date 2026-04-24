## Context

Backend skill activation is inconsistent because trigger language is too implicit and companion skills overlap with the gateway skill. This change only adjusts OpenSpec-facing trigger guidance; it does not introduce a runtime dispatcher or backend debugging rules.

## Goals / Non-Goals

**Goals:**
- Make repo-wide backend intent reliably select `backend-defensive-engineering` first.
- Treat backend planning, OpenSpec spec work, and implementation work as backend signals.
- Narrow companion backend skills so they only activate for their own concern.
- Leave room for a later backend debugging change without blocking this one.

**Non-Goals:**
- Build a skill ranking engine or runtime router.
- Change non-backend skill families.
- Add backend debugging activation rules now.
- Alter product runtime behavior outside skill metadata.

## Decisions

### 1. Single gateway skill
Use `backend-defensive-engineering` as the default backend entry point for repo-wide backend work.
Alternative considered: multiple equal backend entry skills. Rejected because it creates ambiguity and weakens reliability.

### 2. Trigger on backend structure and intent
Treat a request as backend-related when it shows backend structure, backend intent, or both. Structure includes terms such as Node.js, Express, services, controllers, routes, middleware, Redis, lifecycle, health, and architecture. Intent includes planning, specs, and implementation for backend work.
Alternative considered: keyword-only triggers. Rejected because they miss planning and design requests.

### 3. Narrow companion skills
Keep `backend-core-architecture-contracts`, `backend-runtime-safety-lifecycle`, `backend-node-init-minimal`, `backend-redis-application-patterns`, and `backend-redis-infra-separation` focused on their specific concerns so they do not compete with the gateway.
Alternative considered: broad backend overlap across all skills. Rejected because it increases trigger competition.

### 4. Cover planning and code equally
Use the same backend trigger logic for OpenSpec planning/spec work and for implementation work.
Alternative considered: code-only activation. Rejected because backend planning requests were part of the problem statement.

### 5. Keep backend debugging separate
Reserve backend debugging for a future change so this proposal stays narrowly scoped.
Alternative considered: folding debugging into this change. Rejected to keep ownership clear.

## Risks / Trade-offs

- Overactivation on generic requests -> Mitigation: require backend structure or backend intent before selecting the gateway.
- Underactivation of companion skills -> Mitigation: include explicit concern-specific triggers in each skill description.
- Future debugging remains uncovered -> Mitigation: document the seam now and handle debugging in a later change.

## Migration Plan

- Update backend skill metadata and descriptions.
- Review trigger language for overlap and remove competing cues.
- Validate that planning/spec and implementation requests still resolve to the gateway.
- No runtime rollback is needed; revert the documentation change if the trigger behavior is too broad.

## Open Questions

- What exact trigger phrases should the later backend debugging change use?
