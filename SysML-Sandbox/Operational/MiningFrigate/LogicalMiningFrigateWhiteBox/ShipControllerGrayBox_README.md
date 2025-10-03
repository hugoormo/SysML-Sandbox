# ShipControllerGrayBox.sysml

## Overview

This SysMLv2 model specifies the logical structure and control behavior of the ship controller subsystem for the Venture-class mining frigate. It uses `part def`, `port`, `state`, `action`, `perform`, `transition`, and `exhibit` elements to model the central control logic, state machine, and coordination of ship subsystems.

## Description

### Logical Structure

- **part def LogicalWhiteBoxMiningFrigateVentureClass**
  - Inherits from `LogicalGrayBoxMiningFrigateVentureClass`.
  - Contains the main logical part: `shipControllerGrayBox`.

- **part shipControllerGrayBox : LogicalPart :> shipController**
  - Acts as the central controller, executing the ship's state machine and coordinating subsystem actions.
  - **Ports**
    - `commandNetworkPort` (~LogicalShipCommandPort): Receives commands from the command network.
  - **Exhibits**
    - `logicalWhiteBoxMiningFrigateStates`: The state machine controlling ship behavior, with inputs for the ship instance and command network proxy port.

### State Machine

- **state logicalWhiteBoxMiningFrigateStates :>> logicalGrayBoxMiningFrigateStates**
  - Defines the control behavior and operational states of the ship:
    - `LogicalWhiteBoxParked`: Ship is parked inside a station.
    - `LogicalWhiteBoxBoarded`: Ship is boarded and available for refitting, resupply, or cargo transfer.
    - `LogicalWhiteBoxInGrid`: Ship is in open space, near asteroids or stations.
    - `LogicalWhiteBoxOnWarp`: Ship is in warp, traveling between locations.
  - **Transitions**
    - `logical_parked_to_boarded`: Triggered when pod is docked.
    - `logical_boarded_to_parked`: Triggered when pod is undocked.
    - `logical_boarded_to_inGrid`: Triggered when ship undocks, performs startup sequence.
    - `logical_inGrid_to_docked`: Triggered by dock command, performs shutdown sequence.
    - `logical_inGrid_to_onWarp`: Triggered by warp command, prepares for warp.
    - `logical_onWarp_to_inGrid`: Triggered when warp ends.

### Actions

- **logicalStartUpSequence**
  - Initializes all ship services for pilot use.
  - Sequentially powers up and performs initialization actions for all major subsystems:
    - Power grid, generator, pod manager, command network, sensors, navigation manager, targeting computers, ship processor, drone control manager, extension modules, computation network.
- **logicalShutDownSequence**
  - Shuts down ship services (details defined elsewhere).
- **logicalPrepareForWarp**
  - Prepares ship for warp (details defined elsewhere).

## SysMLv2 Compliance

- Uses `part def`, `port`, `state`, `action`, `perform`, `transition`, and `exhibit` for structure and behavior.
- Explicit state machine modeling for control logic.
- Actions and transitions ensure coordinated subsystem operation and traceability.

## Purpose

This file provides a structured SysMLv2 specification for the ship controller subsystem of the mining frigate, supporting centralized control, subsystem coordination, and reliable state management.

## License

This repository is for educational and modeling purposes. See the repository license for details.