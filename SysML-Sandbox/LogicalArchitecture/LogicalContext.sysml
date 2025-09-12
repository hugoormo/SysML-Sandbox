package LogicalContext {
    doc /*
        * The logical architecture needs a logical context to interact
        * with. For this purpose the phisical items, ports, interfaces
        * and parts need a logiacl counterpart at a logical level of 
        * abstraction.  
    */
    private import ScalarValues::*;

    //logical parts, ports and interfaces
    //Logical items
    item def LogicalComputationService;
    item def LogicalDiagnosis;
    item def LogicalShipCommand;
    item def LogicalStationCommand;
    item def LogicalDroneCommand;
    item def LogicalShipReport;
    item def LogicalDroneReport;
    item def LogicalModuleCommand;
    item def LogicalPowerSupply;
    item def LogicalCargoContainer;
    item def LogicalCelestialSignature;
    item def LogicalGridSignature;
    item def LogicalShipComms;
    item def LogicalWebifierDisruptionField;
    item def LogicalFirePower;
    item def LogicalWarpField;
    
    //Logical part
    part def LogicalPart {
        port commandControlGallente : LogicalCommandControl;
        port computationNetworkPort : LogicalComputationNetwork;
        port powerGridPort : LogicalPowerGrid;
    }

    //Logical external part
    part def LogicalImperialStandardModule {
        action logicalImperialStandardModuleAction;
    }

    //Logical system ports
    port def LogicalPodPort {
        in item shipReport : LogicalShipReport;
        out item command : LogicalShipCommand;
    }
    
    port def LogicalDockingPort {
        out item charge : Real;
        in item cargo : LogicalCargoContainer;
    }

    port def LogicalDroneControllerPort {
        in item droneCommand : LogicalDroneCommand;
        out item droneReport : LogicalDroneReport;
    }

    port def LogicalLongRangeSensorDirectionalAntenna {
        in item longRangeSignature : LogicalCelestialSignature [1..*];
    }

    port def LogicalGridSensorAntenna {
        in item gridSignature : LogicalGridSignature [1..*];
    }

    port def LogicalShipCommsPort {
        inout item shipComm : LogicalShipComms;
    }

    port def LogicalMainPropulsion {
        in item disruptionField : LogicalWebifierDisruptionField;
    }

    port def LogicalDirectionalPropulsion;

    //Logical resilience interaction points
    port def LogicalThreatPort {
        out item firePower : LogicalFirePower;
    }

    port def LogicalWarpDriveDisruptionShield {
        attribute warpShielding : Integer;
        in item warpField : LogicalWarpField;
    }
    
    //Logical parts ports
    port def LogicalComputationNetwork {
        in computationRequest : LogicalComputationService;
        out computationResponse : LogicalComputationService;
    }

    port def LogicalCommandControl {
        out shipCommand : LogicalShipCommand;
        in shipDiagnosis : LogicalDiagnosis;
    }

    port def LogicalPowerGrid {
        out powerGrid : Real;
    }

    //Logical modules extension points
    port def LogicalHighSlotPort {
        in power : LogicalPowerSupply;
        in control : LogicalModuleCommand;
    }

    port def LogicalMediumSlotPort {
        in power : LogicalPowerSupply;
        in control : LogicalModuleCommand;
    }

    port def LogicalLowSlotPort {
        in control : LogicalModuleCommand;
    }

    port def LogicalRigPort {
        out rigEffect : Real;
    }

    //Ship interfaces
    interface def LogicalControlIF {
        end port supplierPort : LogicalCommandControl;
        end port consumerPort : ~LogicalCommandControl;
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