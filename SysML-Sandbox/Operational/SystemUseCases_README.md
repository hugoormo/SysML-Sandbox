# SystemUseCases.sysml

## Overview

This SysMLv2 model defines operational use cases for mining frigates, specifying the sequence of interactions between the system and its actors. It uses `use case def` elements, explicit `subject` bindings, and detailed `event occurrence` and `message` flows to capture system behavior and actor interactions.

## Description

### Use Case Definitions

- Each `use case def` element models a specific operational scenario for the mining frigate, with a bound `subject` (e.g., `highSecMiningFrigate`) and associated actors (e.g., `PilotPod`, `Asteroid`, `Station`, `Drone`).

#### Key Use Cases

- **MineAsteroids**  
  - Subject: `highSecMiningFrigate`
  - Actors: `PilotPod`, `Asteroid`
  - Sequence:  
    - `event occurrence` such as `activateMiningLaserSent`, `miningReportReceived`, `oreHoldFullReceived` for the pilot pod.
    - Asteroid emits `asteroidDeintegrationSend` and `asteroidDepletionSend`.
    - Actions: Mining lasers are activated, ore hold status is reported, mining is interrupted if the ore hold is full.
    - `message` flows: Commands and reports exchanged between pilot pod and frigate.

- **MonitorAndDetectThreats**  
  - Subject: `highSecMiningFrigate`
  - Actors: `PilotPod`, `HostilePilotPod`
  - Sequence:  
    - `event occurrence` for scanning actions and reports.
    - Hostile pilot pods emit `signatureEmissionSend`.
    - Actions: Grid and directional scans performed, scan reports sent to pilot pod.
    - `message` flows: Gravitational field and ship reports exchanged.

- **DeployDefenseDrones**  
  - Subject: `highSecMiningFrigate`
  - Actors: `PilotPod`, `HostilePilotPod`, `Drone`
  - Sequence:  
    - Drones are deployed, set to mode, and recalled.
    - Alternate flows for drone loss and redeployment.
    - `message` flows: Ship commands and reports exchanged.

- **DockToStation**  
  - Subject: `highSecMiningFrigate`
  - Actors: `PilotPod`, `Station`
  - Sequence:  
    - Docking commands and status reports.
    - Station emits docking approval.
    - `event occurrence` for docking actions and responses.
    - `message` flows: Ship and station commands exchanged.

- **WarpToCelestial**  
  - Subject: `highSecMiningFrigate`
  - Actors: `PilotPod`, `AsteroidBelt`
  - Sequence:  
    - Warp drive engagement and arrival notifications.
    - `event occurrence` for warp and arrival.
    - `message` flows: Celestial signature and ship commands exchanged.

- **ApproachSignature**  
  - Subject: `highSecMiningFrigate`
  - Actors: `PilotPod`, `Asteroid`
  - Sequence:  
    - Approach commands and status reports.
    - Asteroid emits signature.
    - `event occurrence` for approach initiation.
    - `message` flows: Grid signature and ship commands exchanged.

- **TransferOre** and **UndockFromStation**  
  - Subjects: Mining frigate configurations
  - Actors: `PilotPod`, `Station`
  - Sequence:  
    - Ore transfer and undocking requests.
    - Main flows documented in objectives.

### SysMLv2 Compliance

- Uses `use case def` for operational scenarios.
- Explicit `subject` bindings to system configurations.
- Actors defined with multiplicity and roles.
- Detailed `event occurrence` elements to model interaction points and state changes.
- `message` elements specify the flow of commands, reports, and signals between system and actors.
- Objectives document main and alternate flows.

## Purpose

This file provides a structured SysMLv2 specification of mining frigate operational use cases, supporting requirements validation, interface definition, and system behavior analysis through explicit occurrences and message flows.

## License

This repository is for educational and modeling purposes. See the repository license for details.