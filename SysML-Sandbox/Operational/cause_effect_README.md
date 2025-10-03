# cause-effect.sysml

## Overview

This SysMLv2 model defines explicit cause-effect relationships within the operational domain of a mining corporation's fleet. It uses `#causation` and `#multicausation` connectors to trace how changes in mining pilot pod capabilities impact fleet-level outcomes.

## Description

- **Causation Connections**  
  Direct links from mining pilot pod property improvements to fleet or asteroid outcomes:
  - `miningRateIncreases` → `oreYieldIncreases`
  - `cargoCapacityIncreases` → `downtimeReduces`
  - `shieldStrengthIncreases` → `survivabilityEnhances`
  - `threatDetectionImproves` → `threatResponseImproves`
  - `droneOperationsImprove` → `operationalEfficiencyIncreases`
  - `warpSpeedIncreases` → `downtimeReduces`

- **Multicausation Connections**  
  Effects resulting from multiple causes:
  - `oreYieldIncreases` & `downtimeReduces` → `oreExtractionEfficiencyIncreases`
  - `survivabilityEnhances` & `threatResponseImproves` → `operationalEfficiencyIncreases`
  - `operationalEfficiencyIncreases` & `oreExtractionEfficiencyIncreases` → `profitabilityMaximizes`

## Purpose

This file models how improvements in individual pilot pod capabilities propagate to fleet-level outcomes, supporting analysis of operational effectiveness and decision-making.

## Note

Some syntax may require correction for full SysMLv2 compliance.

## License

This repository is for educational and modeling purposes. See the repository license for details.