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
        item def LogicalControlCommand :> ShipCommand;
        item def LogicalDronesCommand :> DronesCommand;
        item def LogicalEngageDefensesCommand :> EngageDefensesCommand;
        item def LogicalDirectionalScanCommand :> DirectionalScanCommand;
        item def LogicalModuleToggleCommand :> LogicalControlCommand;
        item def LogicalModule1ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule2ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule3ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule4ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule5ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule6ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalModule7ToggleCommand :> LogicalModuleToggleCommand;
        item def LogicalNavigationCommand :> NavigationCommand {
            attribute destinationSignature : LogicalSignature :>> destinationSignature;
        }
        item def LogicalExecuteWarpDriveCommand :> LogicalNavigationCommand;
        item def LogicalApproachSignatureCommand :> LogicalNavigationCommand;
        item def LogicalOrbitSignatureCommand :> LogicalNavigationCommand;
        item def LogicalKeepSignatureAtRangeCommand  :> LogicalNavigationCommand;
        item def LogicalDockToStationCommand :> LogicalNavigationCommand;
        item def LogicalEngagePropulsionCommand :> LogicalNavigationCommand;
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
        }
        
        //Logical parts ports
        port def LogicalComputationNetworkPort {
            in computationRequest : LogicalComputationService;
            out computationResponse : LogicalComputationService;
        }

        port def LogicalShipCommandPort {
            out shipControl : LogicalControlCommand;
            in shipReport : LogicalShipReport;
        }

        port def LogicalDiagnosticsPort {
            out shipDiagnosticsreport : LogicalDiagnostics;
        }

        port def LogicalPowerGridPort {
            out powerGridEnergy : NaturalEnvironment::Energy;
        }

        port def LogicalAnalogPort {
            out logicalAnalogSignal1 : LogicalAnalogSignal;
            out logicalAnalogSignal2 : LogicalAnalogSignal;
            out logicalAnalogSignal3 : LogicalAnalogSignal;
        }

        port def LogicalAlignmentPort {
            out logicalAlignmentSignal : LogicalAlignmentSignal;
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

        interface def LogicalPowerGridIF {
            end port supplierPort : LogicalPowerGridPort;
            end port consumerPort : ~LogicalPowerGridPort;
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
    }
}