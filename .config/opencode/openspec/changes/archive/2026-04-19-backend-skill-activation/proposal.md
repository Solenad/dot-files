## Why

Backend requests are still too easy to miss because trigger language is implicit and overlaps across the skill stack. We need one reliable backend gateway that catches repo-wide backend work - planning, specs, and code - before narrower companion skills are considered.

## What Changes

- Strengthen `backend-defensive-engineering` so it is the default backend entry skill for repo-wide backend work.
- Narrow companion backend skills so they trigger only for their specific concern instead of competing with the gateway.
- Cover backend planning/spec work and implementation work with the same trigger language.
- Keep backend debugging as a separate future change instead of folding that concern into this one.

## Capabilities

### New Capabilities

- `backend-skill-activation`: reliable selection of the backend gateway skill and its companion backend skills for repo-wide backend work.

### Modified Capabilities

## Impact

- OpenSpec change artifacts under `openspec/changes/backend-skill-activation/`
- Skill metadata and descriptions for the backend skill family
- Trigger coverage for backend planning, architecture, lifecycle, Redis, and implementation requests
- Future backend debugging work remains a separate change
