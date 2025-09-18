package LogicalReferenceArchitecture {
    doc /*
        * The logical architecture serves as an intermediate level of abstraction 
        * between the black-box system requirements and the physical architecture.
        * (S. Friedenthal et al.)  
        */ 

    private import ScalarValues::*;

    package LogicalDefinitions {
        //logical parts, ports and interfaces
        //Logical items
        item def LogicalComputationService;
        item def LogicalDiagnostics;
        item def LogicalPowerSupply;
        item def LogicalControlCommand;
        item def LogicalShipReport;
        item def LogicalAnalogSignal;
        
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
            port commandControlGallentePort : LogicalShipControlPort[0..*];
            port computationNetworkPort : LogicalComputationNetworkPort;
            port powerGridPort : LogicalPowerGridPort;
        }
        
        //Logical parts ports
        port def LogicalComputationNetworkPort {
            in computationRequest : LogicalComputationService;
            out computationResponse : LogicalComputationService;
        }

        port def LogicalShipControlPort {
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
            out logicalAnalogSignal : LogicalAnalogSignal;
        }


        //Ship interfaces
        interface def LogicalControlIF {
            end port supplierPort : LogicalShipControlPort;
            end port consumerPort : ~LogicalShipControlPort;
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
    }
}