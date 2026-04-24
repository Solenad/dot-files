# opsx-stabilize

## ADDED Requirements

### Requirement: Dedicated stabilize command exists
The system SHALL provide a `/opsx-stabilize` command that users can invoke after apply.

#### Scenario: User invokes stabilize
- **WHEN** a user types `/opsx-stabilize` after apply completes
- **THEN** the system SHALL enter stabilization mode for bug recovery

### Requirement: Stabilize handles bug recovery
The system SHALL guide users through reproduce, isolate, and fix steps.

#### Scenario: Bug discovered after apply
- **WHEN** a defect is found post-apply
- **THEN** the system SHALL guide through reproduction and isolation

### Requirement: Verify remains the acceptance gate
The system SHALL require verification after stabilization succeeds.

#### Scenario: Stabilization complete
- **WHEN** stabilize finishes successfully
- **THEN** the system SHALL prompt for verification before archive

### Requirement: Verify failure returns to stabilize
The system SHALL return the change to stabilize when verification fails.

#### Scenario: Verification fails
- **WHEN** technical or UAT verification fails
- **THEN** the system SHALL return to stabilization for another fix cycle

### Requirement: Integration with stabilize-workflow schema
The system SHALL work with the stabilize-workflow schema artifacts.

#### Scenario: Schema detected
- **WHEN** a change uses the stabilize-workflow schema
- **THEN** the system SHALL read and validate UAT signoff artifacts
