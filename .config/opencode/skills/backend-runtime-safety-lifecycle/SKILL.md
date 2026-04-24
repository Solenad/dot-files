---
name: backend-runtime-safety-lifecycle
description: Defines runtime lifecycle safety, health semantics, dependency criticality, and operational baseline for defensive backends.
compatibility: opencode
tags: [backend, runtime, lifecycle, healthcheck, reliability, operations]
metadata:
  workflow: openspec-proposal
  priority: correctness-over-speed
  requires:
    - openspec-proposal
    - backend-defensive-engineering
    - backend-core-architecture-contracts
---

Runtime safety module for Node.js + TypeScript + Express services.

## Rationalization Table - Safety Compromises

| Excuse | Reality |
|--------|---------|
| "Startup ordering can be parallelized" | Non-deterministic startup causes readiness failures. |
| "Liveness can check deep dependencies" | Deep liveness checks amplify transient outages. |
| "Graceful shutdown is optional for prototypes" | Abrupt exits leak resources and hide lifecycle defects. |
| "All dependencies are equal" | Critical and optional dependencies need explicit policies. |
| "Silent fallback keeps service available" | Silent degradation destroys operator signal quality. |

## Lifecycle Contract

Define deterministic startup before accepting traffic:

```text
init critical dependencies -> configure middleware -> register routes -> start listeners/workers
```

On shutdown (`SIGTERM`, `SIGINT`), require graceful closure:

```text
stop timers/workers -> close external clients/pools -> exit with observable logs
```

## Dependency Criticality Matrix

- Fail-fast critical (service must not run without it)
- Degrade-and-warn optional (service may run with reduced capability)

Production policy should be stricter than dev/local; avoid silent unsafe fallbacks.

## RED-GREEN-REFACTOR for Runtime Safety

### RED: Expose lifecycle gaps
- **Trigger**: startup/shutdown policy is missing or implicit.
- **Action**: identify ordering, signal, and probe ambiguity.
- **Verification**: gaps are explicit before safeguards are added.

### GREEN: Enforce baseline
- **Trigger**: lifecycle policy is explicit.
- **Action**: apply deterministic startup, explicit criticality, and probe semantics.
- **Verification**: readiness/liveness behavior is unambiguous and observable.

### REFACTOR: Tighten operations
- **Trigger**: new outage modes or ambiguity appear.
- **Action**: strengthen red flags and fallback/shutdown guidance.
- **Verification**: no silent degrade path or undefined shutdown behavior remains.

```dot
digraph dependency_criticality_flow {
  dep [label="Dependency", shape=ellipse];
  critical [label="Fail-fast critical?", shape=diamond];
  strict [label="Strict startup + readiness gate", shape=box];
  optional [label="Optional with degrade-and-warn?", shape=diamond];
  warn [label="Allow degraded mode + telemetry", shape=box];
  invalid [label="Policy undefined: stop", shape=box];

  dep -> critical;
  critical -> strict [label="Yes"];
  critical -> optional [label="No"];
  optional -> warn [label="Yes"];
  optional -> invalid [label="No"];
}
```

## Red Flags - Safety Violations

- NO GRACEFUL SHUTDOWN PATH.
- READINESS/LIVENESS SEMANTICS UNDEFINED.
- LIVENESS USES DEEP DEPENDENCY CHECKS.
- DEPENDENCY CRITICALITY NOT CLASSIFIED.
- SILENT DEGRADE WITHOUT WARNING SIGNALS.

When flagged: **Stop -> define lifecycle policy -> verify probe semantics -> continue.**

## REQUIRED BACKGROUND

- **REQUIRED** `openspec-proposal`
- **REQUIRED** `backend-defensive-engineering`
- **REQUIRED** `backend-core-architecture-contracts`

## Health Semantics (Required)

- Liveness: process is alive; avoid deep dependency checks.
- Readiness: service is ready for traffic based on required dependencies.

If optional dependencies are unconfigured, readiness behavior must stay explicit and observable.

## Operational Safety Baseline

- Rate limiting for externally reachable endpoints
- DI-friendly composition boundaries
- Liveness/readiness endpoints
- Compression strategy for response efficiency

## Observability Expectations

- Startup logs identify dependency state.
- Shutdown logs confirm worker/timer and connection closure.
- Degraded modes emit explicit warning signals.
