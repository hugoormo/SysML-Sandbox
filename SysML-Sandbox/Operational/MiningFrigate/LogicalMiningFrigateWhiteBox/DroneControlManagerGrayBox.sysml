package DroneControlManagerGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part def LogicalwhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {

        part droneControlManagerGrayBox : LogicalPart :> droneControlManager {
            port :>> droneControlManagerPort : droneControlPort[2];
            port :>> commandNetworkPort : ~LogicalDroneCommandsSubPort;
            port :>> lowPowerGridPort;

            part lowPowerSupplyUnit : LogicalPart {
                
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port dronesCommandRelay :>> lowPowerLinePort;
                
                perform logicalInitializeDroneServices.logicalPowerUpDronesControlManager;
            } 
            
            part dronesCommandRelay {
                port commandNetworkPort : ~LogicalDroneCommandsSubPort = commandNetworkPort;
                port droneControlManagerPort : droneControlPort[2] = droneControlManagerPort;
                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort;

                perform logicalInitializeDroneServices.relayDronescommands {
                    in relayDronescommands_droneControlManagerProxyPort : droneControlPort[2] = droneControlManagerPort;
                    in relayDronescommands_commandNetworkProxyPort : ~LogicalDroneCommandsSubPort = commandNetworkPort;
                }
            }

            part lowPowerWiring : LogicalPart {
                ref lowPowerSupplyUnit :>> lowPowerSupplyUnit;
                ref dronesCommandRelay :>> dronesCommandRelay;

                //Low power wiring
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.dronesCommandRelay to
                    consumerPort ::> dronesCommandRelay.lowPowerSupplyUnitPort;       
            }

            bind droneControlManagerPort = dronesCommandRelay.droneControlManagerPort;
            bind commandNetworkPort = dronesCommandRelay.commandNetworkPort;
            bind lowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;
            
            action :>> logicalInitializeDroneServices {
                doc /*
                    * Power up and enable drone services through calls to the dronesManager (perform action manageDrones...).
                    */
                in droneControlManagerPort : droneControlPort[2];
                in commandNetworkPort : ~LogicalDroneCommandsSubPort;
                
                first start;
                then action logicalPowerUpDronesControlManager;
                then action relayDronescommands;
            }

        }
    }
}