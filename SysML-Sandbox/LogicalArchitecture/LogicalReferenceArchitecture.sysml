package LogicalReferenceArchitecture {
    doc /*
        * The logical architecture builds form a logical reference architecture. 
    */
    private import ScalarValues::*;

    package LogicalDefinitions {
        //logical parts, ports and interfaces
        //Logical items
        item def LogicalComputationService;
        item def LogicalDiagnosis;
        item def LogicalPowerSupply;
        
        //Logical part
        part def LogicalPart {
            port commandControlGallente : LogicalShipControl;
            port computationNetworkPort : LogicalComputationNetwork;
            port powerGridPort : LogicalPowerGrid;
        }

        //Logical external part
        part def LogicalImperialStandardModule {
            action logicalImperialStandardModuleAction;
        }
        
        
        //Logical parts ports
        port def LogicalComputationNetwork {
            in computationRequest : LogicalComputationService;
            out computationResponse : LogicalComputationService;
        }

        port def LogicalShipControl {
            out shipControl : LogicalShipControl;
            in shipDiagnosis : LogicalDiagnosis;
        }

        port def LogicalPowerGrid {
            out powerGrid : Real;
        }


        //Ship interfaces
        interface def LogicalControlIF {
            end port supplierPort : LogicalShipControl;
            end port consumerPort : ~LogicalShipControl;
        }

        interface def LogicalComputationServicesIF {
            end port supplierPort : LogicalComputationNetwork;
            end port consumerPort : ~LogicalComputationNetwork;
        }

        interface def LogicalPowerGridIF {
            end port supplierPort : LogicalPowerGrid;
            end port consumerPort : ~LogicalPowerGrid;
        }
    }
}