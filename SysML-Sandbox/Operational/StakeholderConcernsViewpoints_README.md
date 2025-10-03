# StakeholderConcernsViewpoints.sysml

## Overview

This SysMLv2 model defines stakeholders, their concerns, and viewpoints relevant to mining operations. It uses explicit `part def`, `concern`, and `viewpoint` elements to capture stakeholder roles, business and operational concerns, and how these concerns are addressed in the system.

## Description

### StakeholdersDef Package

- **part def** elements define stakeholder roles:
  - `MiningCEO`: Focuses on profitability, strategy, and risk management.
  - `OperationsManager`: Optimizes costs, deployment efficiency, and ore delivery.
  - `FleetCommander`: Manages fleet operations, survivability, and threat neutralization.
  - `ShipEngineer`: Ensures ship survivability and performance in hostile environments.
  - `MarketAnalyst`: Monitors market trends and maximizes revenue.

### StakeholderConcerns Package

- **concern** elements capture business and operational concerns:
  - `FleetProfitabilityConcern`: Ensures mining operations generate sufficient ISK/hour for different security zones. Linked to `MiningCEO`.
  - `SecurityConcern`: Ensures safety and survivability in hostile environments. Linked to `FleetCommander` and `ShipEngineer`.
  - `PilotPodProfitabilityConcern`: Ensures competitive profit for pilots in all security environments. Linked to `MiningCEO` and `FleetCommander`.

- Each concern specifies:
  - **subject**: The block or part the concern applies to (e.g., `MiningCorporation`, `highSecMiningFrigate`).
  - **attribute**: Relevant metrics (e.g., profitability).
  - **require constraint**: Documentation of the rationale.
  - **stakeholder**: Explicit linkage to stakeholder roles.

### Viewpoints Package

- **viewpoint** element defines a perspective for analysis:
  - `'Operational profitability'`: Frames the `FleetProfitabilityConcern` for system evaluation.
  - Includes a placeholder for further constraints.

## SysMLv2 Compliance

- Uses `part def` for stakeholder roles.
- Uses `concern` for stakeholder/business/operational concerns, with explicit `subject`, `attribute`, `require constraint`, and `stakeholder` relations.
- Uses `viewpoint` to frame concerns for analysis.
- Organizes elements for traceability and stakeholder alignment.

## Purpose

This file provides a structured SysMLv2 specification of stakeholders, their concerns, and viewpoints, supporting requirements engineering, traceability, and system validation.

## License

This repository is for educational and modeling purposes. See the repository license for details.