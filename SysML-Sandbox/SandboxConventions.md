# Modeling Conventions in the SysML-Sandbox

## Overview

All models in this folder are authored in **SysMLv2** and follow a set of conventions for structure, naming, and relationships to ensure clarity, traceability, and consistency across the mining frigate system architecture.

## Conventions

### 1. **Package Structure**
- Each subsystem or domain is encapsulated in a `package`.
- Related definitions (requirements, verification, analysis, etc.) are grouped in dedicated packages.

### 2. **Parts and Parts Definitions**
- Subsystems are defined using `part def` and instantiated with `part`.
- Inheritance and specialization use the `:>` notation (e.g., `part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass`).

### 3. **Ports and Interfaces**
- Ports are explicitly typed and named to indicate their function and direction (e.g., `commandNetworkPort`, `lowPowerGridPort`).
- Interfaces (`interface def`) are used for resource and signal connections, with clear supplier/consumer roles.

### 4. **Attributes and Parameters**
- Attributes are defined with default values and clear units (e.g., `alignTime default 5.99`).
- Parameters of interest are imported and referenced for analysis and requirements.

### 5. **Actions and Behavior**
- Actions (`action`, `action def`) model subsystem initialization, command handling, and reporting.
- State machines (`state`) and transitions (`transition`) are used for control logic and operational flow.

### 6. **Multiplicity and Arrays**
- Arrays and multiplicity are indicated using brackets (e.g., `extensionModuleManagerGrayBox[7]` for seven extension module managers).

### 7. **Bindings and Connections**
- `bind` statements connect ports and interfaces between subsystem parts for traceability and integration.

### 8. **Requirements and Verification**
- Requirements are defined with `requirement def` and instantiated with `requirement`.
- Verification and validation use `verification def`, `objective`, and `action` elements, with explicit subject bindings.

### 9. **Naming Conventions**
- Names are descriptive and use camelCase or PascalCase for clarity (e.g., `powerGridGrayBox`, `LogicalWhiteBoxMiningFrigateVentureClass`).
- Ports and attributes are suffixed to indicate their role (e.g., `Port`, `Attribute`, `GrayBox`).

### 10. **Documentation** (`doc /* ... */`)
- **Documentation blocks** are part of the SysMLv2 model.
- They use the `doc /* ... */` syntax and are attached to elements such as parts, actions, requirements, or packages.
- These blocks provide intent, rationale, operational context, and explanations that are included in the model for traceability and stakeholder communication.

- **Inline comments** use the `//...` syntax.
- They are not part of the SysMLv2 model and are ignored by SysMLv2 parsers.
- Inline comments are used for developer notes, reminders, or explanations within the source code, but do not appear in the formal model or its documentation.

#### Summary
- Use `doc /* ... */` for model documentation that should be visible and traceable in the SysMLv2 model.
- Use `// ...` for informal notes or explanations that are only relevant during model editing and are not part of the model itself.

## Purpose

These conventions support model readability, maintainability, and enable automated analysis and traceability throughout the mining frigate system architecture.

## License

This repository is for educational and modeling purposes. See the repository license for details.