# stabilize-workflow

## ADDED Requirements

### Requirement: Stabilize phase exists
The system SHALL provide a stabilize phase that occurs after apply and before verify.

#### Scenario: Change reaches stabilization
- **WHEN** a change has completed apply
- **THEN** the system SHALL route the change into stabilize instead of verify or archive

### Requirement: Stabilize includes bug recovery
The system SHALL support a stabilization flow that includes reproduction, root-cause isolation, and corrective action before verification.

#### Scenario: Bug found after apply
- **WHEN** a defect is discovered after apply
- **THEN** the system SHALL guide the user through reproduce, isolate, and fix steps

### Requirement: Verify is the acceptance gate
The system SHALL require verify to perform technical checks and UAT signoff after stabilization.

#### Scenario: Stabilization complete
- **WHEN** stabilize is complete
- **THEN** the system SHALL route the change into verify for final validation

### Requirement: Verify failure returns to stabilize
The system SHALL return the change to stabilize when technical verification fails or UAT signoff fails.

#### Scenario: Technical check fails
- **WHEN** technical verification fails
- **THEN** the system SHALL return the change to stabilize for another fix/retry cycle

#### Scenario: UAT fails
- **WHEN** UAT signoff fails
- **THEN** the system SHALL return the change to stabilize for another fix/retry cycle

### Requirement: UAT signoff is its own artifact
The system SHALL capture UAT signoff as a separate artifact from technical verification.

#### Scenario: UAT approval recorded
- **WHEN** a user completes UAT
- **THEN** the system SHALL store that approval in the UAT signoff artifact

### Requirement: Archive depends on verify completion
The system SHALL allow archive only after verify is complete.

#### Scenario: Verification not complete
- **WHEN** a user attempts to archive a change that has not completed verify
- **THEN** the system SHALL reject the archive attempt

### Requirement: Global workflow configuration supports stabilize
The system SHALL allow the stabilize workflow to be enabled through global OpenSpec configuration and schema resolution.

#### Scenario: Custom profile loads global schema
- **WHEN** the user selects the custom global profile
- **THEN** the stabilize workflow SHALL be available if the global schema is installed
