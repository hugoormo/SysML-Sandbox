package DroneControlManager {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part logicalMiningFrigateVentureClass : LogicalMiningFrigateVentureClass {

        part droneControlManager : LogicalPart :>> droneControlManager {
                port :>> droneControlManagerPort : droneControlPort[2];
                port :>> commandNetworkPort : ~LogicalShipCommandPort;

                action :>> logicalInitializeDroneServices {
                    doc /*
                        * Power up and enable drone services through calls to the dronesManager (perform action manageDrones...).
                        */
                    in :>> dronesControlManagerCommandPort = commandNetworkPort;

                    first start;
                    then action logicalPowerUpDronesControlManager;
                    then action acceptDroneCommand accept engageDroneCommand : LogicalEngageDefensesCommand via dronesControlManagerCommandPort;
                    then action engageDroneDefenses {
                        in droneCommand = acceptDroneCommand.engageDroneCommand.signatureGrid; 
                        out reportDrones : LogicalShipReport;
                    }
                    then send engageDroneDefenses.reportDrones via dronesControlManagerCommandPort;
                }

            }
    }
}