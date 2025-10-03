# MiningFrigateVerificationCases.sysml

## Overview

This SysMLv2 model specifies verification and validation cases for mining frigates, using explicit `verification def`, `part def`, `action`, and `objective` elements. It demonstrates how requirements are tested and validated at both the system and operational levels, ensuring traceability and compliance.

## Description

### MiningFrigateVerification Package

- **part def MiningFrigateVerificationRig**
  - Defines a test rig with a `verificationPilot` (a `MiningPilotPod` with no mining bonuses) and a reference to the mining frigate under test (`miningFrigateDUT`).
  - Instantiated as `miningFrigateTestRigLowSec`, which performs the `oreExtractionEfficiencyTest`.

- **verification oreExtractionEfficiencyTest**
  - References the subject `miningFrigateDUT`.
  - Implements the verification definition `OreExtractionEfficiencyTest`.

- **verification def OreExtractionEfficiencyTest**
  - Subject: `miningFrigateDUT` (bound to `lowSecMiningFrigate`).
  - **objective**: Verifies the `oreExtractionEfficiencyRequirementLowSec`.
  - **metadata**: Specifies the verification method as a test.
  - **action collectData**: Measures mining rate from the test rig.
  - **action evaluateData**: Evaluates the measured mining rate against the requirement, outputs a verdict (`PassIf` logic).
  - **return**: Verdict of the evaluation.

### MiningFrigateValidation Package

- **part def MiningFrigateValidationRig**
  - Defines a validation rig with a `validationPilot` (from `lowSecMiningPilotPod`) and a reference to the mining frigate under test.
  - Instantiated as `miningFrigateTestRigLowSec`, which performs the `pilotProfitabilityRequirementTest`.

- **verification pilotProfitabilityRequirementTest**
  - References the subject `lowSecMiningPilotPod`.
  - Implements the validation definition `PilotProfitabilityRequirementTest`.

- **verification def PilotProfitabilityRequirementTest**
  - Subject: `miningCorporationDUT` (bound to `domain.miningCorporation`).
  - **objective**: Verifies the `pilotProfitabilityRequirementLS`.
  - **metadata**: Specifies the verification method as a test.
  - **action collectData**: Measures pilot profitability from the validation rig.
  - **action evaluateData**: Evaluates the measured profitability against the requirement, outputs a verdict (`PassIf` logic).
  - **return**: Verdict of the evaluation.

## SysMLv2 Compliance

- Uses `verification def` for formal test definitions.
- Uses `part def` for test/validation rig structure.
- Explicit `subject` bindings for traceability.
- `objective` elements link verification actions to requirements.
- `action` elements structure the test and evaluation process.
- `metadata` specifies verification method.
- `return` provides verdicts for requirement satisfaction.

## Purpose

This file provides a structured SysMLv2 specification for verifying and validating mining frigate requirements, supporting requirements traceability, system compliance, and operational effectiveness.

## License

This repository is for educational and modeling purposes. See the repository license for details.