package LogicalShipController {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part logicalMiningFrigateVentureClass : LogicalStructure::LogicalMiningFrigateVentureClass {

        part shipController : LogicalPart :>> shipController {
            
            port controlNetworkPort : ~LogicalShipControlPort :>> controlNetworkCommandPort;
            port :>> podManagerPort;

            action :>> logicalStartUpSequence {
                    doc /*
                        * Initialize the services of the ship for using by the pilot 
                        */
                    in :>> logicalGridServicesCommandPort : LogicalShipControlPort;
                    
                    in :>> podManagerPort : ~LogicalShipControlPort;
                    in :>> controlNetworkCommandPort : LogicalShipControlPort;

                    in :>> podManagerControlCommand : LogicalControlCommand;
                    out :>> controlNetworkControlCommand : LogicalControlCommand;
                    in :>> controlNetworkShipReport : LogicalShipReport;
                    out :>> podManagerShipReport : LogicalShipReport;
                    
                    
            }    

           
        }
    }
}