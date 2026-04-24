---
name: backend-node-init-minimal
description: Initializes a minimal Node backend baseline with canonical directories, health endpoints, and lifecycle-safe entrypoint contracts.
compatibility: opencode
tags: [backend, nodejs, bootstrap, scaffold, healthcheck, lifecycle]
metadata:
  workflow: openspec-proposal
  priority: correctness-over-speed
  requires:
    - openspec-proposal
    - backend-defensive-engineering
    - backend-core-architecture-contracts
    - backend-runtime-safety-lifecycle
---

Minimal backend initialization module for greenfield repositories.

## Rationalization Table - Bootstrap Overreach

| Excuse | Reality |
|--------|---------|
| "Add business routes now to save time" | Minimal bootstrap must stay capability-agnostic. |
| "Include auth to make it realistic" | Auth integration is specialized, not baseline init. |
| "Provision infra in bootstrap for completeness" | Optional infrastructure setup violates minimal scope. |
| "Health endpoints can wait" | Liveness/readiness are baseline safety contracts. |
| "Prototype can skip graceful shutdown" | Lifecycle safety must exist from first scaffold. |

## Scope

This module defines minimal baseline setup only.

Included:
- canonical directory structure
- base entrypoint contract (`index.ts` or `index.js`)
- liveness/readiness endpoint contract
- deterministic startup and graceful shutdown contract

Excluded by default:
- business/domain routes
- auth/oauth integrations
- optional infrastructure integrations
- heavy non-essential config scaffolding

## RED-GREEN-REFACTOR for Minimal Bootstrap

### RED: Detect scope drift
- **Trigger**: bootstrap includes domain/auth/infra additions.
- **Action**: identify non-baseline concerns.
- **Verification**: all non-baseline concerns are explicit.

### GREEN: Restore minimal contract
- **Trigger**: drift is identified.
- **Action**: remove non-baseline concerns and keep required bootstrap contracts.
- **Verification**: only baseline scope remains.

### REFACTOR: Keep minimal over time
- **Trigger**: repeated overreach pressure.
- **Action**: tighten exclusions and red-flag wording.
- **Verification**: no recurring scope creep in bootstrap guidance.

## Canonical Baseline Structure

```text
controllers/
services/
repositories/
models/
middleware/
routes/
utils/
config/
types/
```

## Base Entrypoint Contract

The base entrypoint must define:
- deterministic startup ordering
- explicit startup failure handling
- graceful shutdown on termination signals
- observable lifecycle logs

## Health Contract

Minimal scaffold must include:
- liveness semantics (process health)
- readiness semantics (traffic readiness, dependency-aware)

## Compatibility Rule

Guidance from this module must not conflict with `backend-core-architecture-contracts` or `backend-runtime-safety-lifecycle`.

## Red Flags - Bootstrap Scope Violations

- DOMAIN-SPECIFIC ROUTES IN BASELINE SCAFFOLD.
- AUTH/OAUTH EMBEDDED IN MINIMAL INIT.
- OPTIONAL INFRASTRUCTURE EMBEDDED BY DEFAULT.
- MISSING LIVENESS/READINESS CONTRACTS.
- NO GRACEFUL SHUTDOWN HANDLING.

When flagged: **Stop -> remove non-baseline concerns -> restore minimal scaffold contract.**

## REQUIRED BACKGROUND

- **REQUIRED** `openspec-proposal`
- **REQUIRED** `backend-defensive-engineering`
- **REQUIRED** `backend-core-architecture-contracts`
- **REQUIRED** `backend-runtime-safety-lifecycle`
