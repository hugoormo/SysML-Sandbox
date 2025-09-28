package LogicalReferenceArchitecture {
    doc /*
        * The logical architecture serves as an intermediate level of abstraction 
        * between the black-box system requirements and the physical architecture.
        * (S. Friedenthal et al.)  
        */ 

    private import ScalarValues::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    package LogicalDefinitions {
        //logical parts, ports and interfaces
        //Logical items reflect the phisical items
        item def LogicalComputationService;
        item def LogicalDiagnostics;
        item def LogicalPowerSupply;
        item def LogicalLowPowerSupply;
        item def LogicalControlCommand :> ShipCommand;
        item def LogicalReleaseDronesToGrid :> ReleaseDronesToGrid;
        item def LogicalReconnectDrones :> ReconnectDrones;
        item def LogicalEngageDronesCommand :> EngageDronesCommand;
        item def LogicalDronesReport :> DronesReport;
        item def LogicalRecallDrones :> RecallDrones;
        item def LogicalDirectionalScanCommand :> DirectionalScanCommand;
        item def LogicalScanReport :> ScanReport;
        item def LogicalModuleToggleCommand :> LogicalControlCommand;
        item def LogicalModule1ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule2ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule3ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule4ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule5ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule6ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule7ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModuleReport :> ModuleReport;
        item def LogicalNavigationCommand :> NavigationCommand {
            attribute destinationSignature : LogicalSignature :>> destinationSignature;
        }
        item def LogicalExecuteWarpDriveCommand :> LogicalNavigationCommand;
        item def LogicalApproachSignatureCommand :> LogicalNavigationCommand;
        item def LogicalOrbitSignatureCommand :> LogicalNavigationCommand;
        item def LogicalKeepSignatureAtRangeCommand  :> LogicalNavigationCommand;
        item def LogicalDockToStationCommand :> LogicalNavigationCommand;
        item def LogicalEngagePropulsionCommand :> LogicalNavigationCommand;
        item def LogicalNavigationReport :> NavigationReport;
        item def LogicalLockTarget :> LockTarget;
        item def LogicalShipReport;
        item def LogicalAnalogSignal :> AnalogSignal;
        item def LogicalAlignmentSignal :> AlignmentSignal;
        item def LogicalSignature :> Signature;
        item def LogicalCelestialSignature :> CelestialSignature;
        item def LogicalGridSignature :> GridSignature; 
        
        //Logical part
        part def LogicalPart {
            doc /*
                * The system is decomposed into three classes of logical components:
                * 1) External Interface Components: manage the interface to each external system or user, 
                * which includes providing the connection to the external system or user and encoding 
                * and decoding signals for transmission and processing
                * 2) Application Components: provide the basic functionality (i.e., business logic) to 
                * process each external input and output item flow
                * 3) Infrastructure Components:  manage internal resources such as time, memory, processing, 
                * internally generated heat, and interconnection infrastructure such as wiring and plumbing.
                * The internal resources are derived from the design and are not necessarily derivable 
                * from the external environment.
                * (S. Friedenthal et al.)
                */
            port commandControlGallentePort : LogicalShipCommandPort[0..*];
            port computationNetworkPort : LogicalComputationNetworkPort;
            port powerGridPort : LogicalPowerGridPort;
            port lowPowerGridPort : LogicalLowPowerGridPort;
            port lowPowerLinePort : LogicalLowPowerLinePort[0..*];
            port analogLinePort : LogicalAnalogPort[0..*];
            port serialPort : LogicalSerialPort[0..*];
        }
        
        //Logical parts ports
        port def LogicalComputationNetworkPort {
            in computationRequest : LogicalComputationService;
            out computationResponse : LogicalComputationService;
        }

        port def LogicalShipCommandPort {
            port droneCommandsSubPort : LogicalDroneCommandsSubPort;
            port modulesCommandsSubPort : LogicalModuleCommandsSubPort;
            port navigationCommandsSubPort : LogicalNavigationCommandsSubPort;
            port scanCommandsSubPort : LogicalScanCommandsSubPort;
            port targetingCommandsSubPort : LogicalTargetingCommandsSubPort;
        }
        port def LogicalDroneCommandsSubPort {
            out releaseDronesToGrid : LogicalReleaseDronesToGrid;
            out recallDrones : LogicalRecallDrones;
            out reconnectDrones : LogicalReconnectDrones;
            out engageDronesCommand : LogicalEngageDronesCommand;
            in dronesReport : LogicalDronesReport;
        }
        port def LogicalModuleCommandsSubPort {
            port module1ToggleCommand : LogicalModuleCommandPort;
            port module2ToggleCommand : LogicalModuleCommandPort;
            port module3ToggleCommand : LogicalModuleCommandPort;
            port module4ToggleCommand : LogicalModuleCommandPort;
            port module5ToggleCommand : LogicalModuleCommandPort;
            port module6ToggleCommand : LogicalModuleCommandPort;
            port module7ToggleCommand : LogicalModuleCommandPort;
            in moduleReport : LogicalModuleReport;
        }
        port def LogicalNavigationCommandsSubPort {
            out executeWarpDriveCommand : LogicalExecuteWarpDriveCommand;
            out approachSignatureCommand : LogicalApproachSignatureCommand;
            out orbitSignatureCommand : LogicalOrbitSignatureCommand;
            out keepSignatureAtRangeCommand : LogicalKeepSignatureAtRangeCommand;
            out dockToStationCommand : LogicalDockToStationCommand;
            out engagePropulsionCommand : LogicalEngagePropulsionCommand;
            in navigationReport : LogicalNavigationReport;
        }

        port def LogicalScanCommandsSubPort {
            out directionalScanCommand : LogicalDirectionalScanCommand;
            in scanReport : LogicalScanReport;
        }

        port def LogicalTargetingCommandsSubPort {
            out lockTarget : LockTarget;
            in targetLockReport : TargetLockReport;
        }

        port def LogicalDiagnosticsPort {
            out shipDiagnosticsreport : LogicalDiagnostics;
        }

        port def LogicalPowerGridPort {
            out powerGridEnergy : LogicalPowerSupply;
        }

        port def LogicalLowPowerGridPort {
            out lowPowerGridEnergy : LogicalLowPowerSupply;
        }

        port def LogicalLowPowerLinePort {
            out lowPowerLineEnergy : LogicalLowPowerSupply;
        }

        port def LogicalAnalogPort {
            out logicalAnalogSignal1 : LogicalAnalogSignal;
            out logicalAnalogSignal2 : LogicalAnalogSignal;
            out logicalAnalogSignal3 : LogicalAnalogSignal;
        }

        port def LogicalAlignmentPort {
            out logicalAlignmentSignal : LogicalAlignmentSignal;
        }

        port def LogicalSerialPort {
            out logicalserialSignal : LogicalAnalogSignal;
        }

        port def LogicalModuleCommandPort {
            out moduleToggleCommand : ModuleToggleCommand;
            in moduleReport : ModuleReport;
        }


        //Ship interfaces
        interface def LogicalControlIF {
            end port supplierPort : LogicalShipCommandPort;
            end port consumerPort : ~LogicalShipCommandPort;
        }

        interface def LogicalComputationServicesIF {
            end port supplierPort : LogicalComputationNetworkPort;
            end port consumerPort : ~LogicalComputationNetworkPort;
        }
        
        interface def LogicalPowerGridFlowIF {
            end port supplierPort : LogicalPowerGridPort;
            end port consumerPort : ~LogicalPowerGridPort;

            flow supplierPort.powerGridEnergy to consumerPort.powerGridEnergy;
        }

        interface def LogicalLowPowerGridIF {
            end port supplierPort : LogicalLowPowerGridPort;
            end port consumerPort : ~LogicalLowPowerGridPort;
        }

        interface def LogicalDiagnosticsIF {
            end port supplierPort : LogicalDiagnosticsPort;
            end port consumerPort : ~LogicalPowerGridPort;
        }

        interface def LogicalAnalogSignalIF {
            end port supplierPort : LogicalAnalogPort;
            end port consumerPort : ~LogicalAnalogPort;
        }

        interface def LogicalAlignmentSignalIF {
            end port supplierPort : LogicalAlignmentPort;
            end port consumerPort : ~LogicalAlignmentPort;
        }

        interface def LogicalSerialIF {
            end port supplierPort : LogicalSerialPort;
            end port consumerPort : ~LogicalSerialPort;
        }
    }
}