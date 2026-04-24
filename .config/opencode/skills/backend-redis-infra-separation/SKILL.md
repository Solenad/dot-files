---
name: backend-redis-infra-separation
description: Enforces clear boundaries and handoff between Redis application behavior guidance and Redis infrastructure operations.
compatibility: opencode
tags: [backend, redis, infra, architecture, boundaries]
metadata:
  workflow: openspec-proposal
  priority: correctness-over-speed
  requires:
    - openspec-proposal
    - backend-defensive-engineering
    - backend-redis-application-patterns
---

Boundary module for Redis concerns.

## Rationalization Table - Separation Violations

| Excuse | Reality |
|--------|---------|
| "Redis is one topic, keep it together" | Behavior and infrastructure have different owners and rollout paths. |
| "Provisioning details help app guidance" | Embedded infra setup in app guidance creates coupling and drift. |
| "Security hardening is app-level here" | TLS/ACL and topology hardening are infra operations. |
| "We'll split concerns later" | Deferred separation becomes long-term boundary erosion. |
| "Prototype can ignore separation" | Early boundary debt hardens into production architecture risk. |

## Separation Contract

Application-level Redis guidance includes:
- key usage contracts
- lock semantics
- cache consistency/fallback behavior
- session/cache behavior policy in app logic

Infrastructure Redis guidance includes:
- topology/HA design
- persistence/backup strategy
- failover/disaster recovery
- TLS/ACL and platform deployment

Do not merge these concern sets in one implementation plan.

## Handoff Rule

When app-level patterns depend on infra capabilities, document assumptions and handoff requirements without embedding provisioning steps.

## RED-GREEN-REFACTOR for Separation Enforcement

### RED: Classify concern type
- **Trigger**: request includes mixed Redis scope signals.
- **Action**: classify each concern as app behavior or infrastructure.
- **Verification**: no ambiguous concern remains unclassified.

### GREEN: Route by boundary
- **Trigger**: classification is complete.
- **Action**: route app behavior to app pattern skill and infra concerns to infra path.
- **Verification**: no cross-boundary implementation leakage remains.

### REFACTOR: Tighten handoffs
- **Trigger**: boundary confusion repeats.
- **Action**: strengthen handoff assumptions and escalation wording.
- **Verification**: mixed concerns are consistently split and routed.

```dot
digraph redis_separation_flow {
  req [label="Redis request", shape=ellipse];
  app [label="Application behavior concern?", shape=diamond];
  infra [label="Infrastructure concern?", shape=diamond];
  appRoute [label="Route to backend-redis-application-patterns", shape=box];
  infraRoute [label="Route to infra skill path", shape=box];
  split [label="Split concerns and handoff", shape=box];

  req -> app;
  app -> appRoute [label="Yes"];
  app -> infra [label="No"];
  infra -> infraRoute [label="Yes"];
  infra -> split [label="Mixed/unclear"];
  appRoute -> split;
  infraRoute -> split;
}
```

## Red Flags - Boundary Breaches

- PROVISIONING STEPS INSIDE APP GUIDANCE.
- APP LOGIC GUIDANCE INSIDE INFRA TOPOLOGY SECTION.
- NO EXPLICIT HANDOFF ASSUMPTIONS.
- MIXED CONCERN PLAN WITHOUT SPLIT.

When flagged: **Stop -> split concern sets -> route each path -> continue.**

## REQUIRED BACKGROUND

- **REQUIRED** `openspec-proposal`
- **REQUIRED** `backend-defensive-engineering`
- **REQUIRED** `backend-redis-application-patterns`

## Escalation Trigger

If request includes provisioning, cluster management, infra security hardening, or platform-specific Redis operations, route to infra skill path.
