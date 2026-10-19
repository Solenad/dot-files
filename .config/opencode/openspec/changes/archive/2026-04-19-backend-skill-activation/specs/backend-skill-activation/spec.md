## ADDED Requirements

### Requirement: Backend gateway selection
The system SHALL select `backend-defensive-engineering` as the primary backend entry skill when a request indicates repo-wide backend work, including Node.js, Express, services, controllers, routes, middleware, Redis, lifecycle, health, or architecture concerns.

#### Scenario: Express restructuring request
- **WHEN** a user requests Express controller-service-route restructuring
- **THEN** the backend gateway skill is selected first

#### Scenario: OpenSpec backend proposal request
- **WHEN** a user asks for a backend change proposal or design document
- **THEN** the backend gateway skill is selected first

### Requirement: Backend intent coverage
The system SHALL treat backend planning, specification work, and implementation work as backend signals even when the request does not name a framework explicitly.

#### Scenario: Planning request
- **WHEN** a user asks to plan backend validation or architecture work
- **THEN** the backend gateway skill is selected

#### Scenario: Code change request
- **WHEN** a user asks to implement or refactor backend code
- **THEN** the backend gateway skill is selected

### Requirement: Companion skills remain narrow
The system SHALL route to companion backend skills only when the request matches that skill's specific concern and SHALL NOT let those skills compete with the backend gateway for general backend requests.

#### Scenario: Lifecycle request
- **WHEN** a user asks about production health or lifecycle safety
- **THEN** backend-runtime-safety-lifecycle may be selected after the gateway is considered

#### Scenario: Redis request
- **WHEN** a user asks about Redis cache behavior or Redis infrastructure separation
- **THEN** the corresponding Redis skill may be selected after the gateway is considered

### Requirement: Backend debugging remains separate
The system SHALL NOT introduce backend debugging activation rules in this change.

#### Scenario: Debugging request
- **WHEN** a user asks to debug a backend failure
- **THEN** the request is treated as out of scope for this change
