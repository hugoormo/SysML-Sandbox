# MiningFrigateRequirements.sysml

## Overview

This SysMLv2 model specifies system requirements for mining frigates, organized into reusable requirement definitions and concrete requirement assertions for different operational contexts (High Sec, Low Sec, Null Sec).

## Description

### MiningFrigateRequirementsDef Package

- **requirement def** elements formally define reusable requirements for mining frigates:
  - **OreExtractionEfficiencyRequirement**: Minimum ore extraction rate, linked to `OreYieldConcern`.
  - **CargoCapacityRequirement**: Minimum cargo capacity, with a constraint on `cargoHoldCapacity`, linked to `TotalProfitabilityConcern`.
  - **SurvivabilityRequirement**: Minimum shield strength, with constraints for High Sec, linked to `SecurityConcern` and `SurvivabilityConcern`.
  - **DroneOperationsRequirement**: Minimum drone capacity, linked to `ThreatNeutralizationConcern` and `OreYieldConcern`.
  - **TravelEfficiencyRequirement**: Minimum warp speed and maximum align time, linked to `DeploymentEfficiencyConcern`.
  - **MiningTargetRequirement**: Minimum number of asteroid targets that can be locked, linked to `OreYieldConcern`.

- Each requirement definition includes:
  - **subject**: The block or part the requirement applies to (e.g., `MiningFrigateVentureClass`).
  - **doc**: Documentation describing the intent.
  - **frame concern**: Explicit links to stakeholder concerns.
  - **require constraint**: Formal constraints on system properties.

### MiningFrigateRequirements Package

- **requirement** elements instantiate the definitions for specific mining frigate variants:
  - **oreExtractionEfficiencyRequirementHighSec**: Minimum 20 m³/minute in High Sec.
  - **oreExtractionEfficiencyRequirementLowSec**: Minimum 30 m³/minute in Low Sec.
  - **oreExtractionEfficiencyRequirementNullSec**: Minimum 40 m³/minute in Null Sec.

- Each assertion binds the requirement to a specific subject instance and sets the required property value.

## SysMLv2 Compliance

- Uses `requirement def` and `requirement` elements with explicit `subject` bindings.
- Applies formal constraints using `require constraint`.
- Links requirements to stakeholder concerns with `frame concern`.
- Organizes requirements for reuse and traceability.

## Purpose

This file provides a structured SysMLv2 specification of mining frigate requirements, supporting traceability, validation, and stakeholder alignment for different operational environments.

## License

This repository is for educational and modeling purposes. See the repository license for details.