## Context

Global backend discipline skills remain untested. Agents bypass them under production pressure.

## Goals / Non-Goals

**Goals:**
- Bulletproof discipline skills via TDD pressure testing
- Document rationalization patterns agents use under pressure
- Create anti-bypass clauses that close real loopholes

**Non-Goals:**
- Testing reference/walkthrough skills (no discipline to enforce)
- Testing workflow guide skills (optional, no harm if skipped)

## Decisions

**RED-GREEN-REFACTOR methodology**
- RED: Document baseline violations without skill (what agents naturally do)
- GREEN: Verify agents comply with skill present (boundaries respected)
- REFACTOR: Apply pressure scenarios, add explicit anti-bypass clauses

**Pressure scenario focus**
- Time pressure: \
Too
busy
to
check
skills\

**Test order**
1. backend-core-architecture-contracts (highest discipline, highest risk)
2. backend-defensive-engineering (defense pattern enforcement)
3. backend-runtime-safety-lifecycle (production safety)

## Risks / Trade-offs

**[Risk] Time investment may not surface violations** → Low investment early, test reveals rationalization patterns quickly
