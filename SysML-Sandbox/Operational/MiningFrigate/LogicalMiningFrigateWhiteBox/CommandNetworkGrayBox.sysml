package CommandNetworkGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {
        
        part commandNetworkGrayBox : LogicalPart :> commandNetwork {
            doc /*
                * Routes all shipCommand and report items between the ship parts.  
                */

            port podManagerPort : ~LogicalShipCommandPort :>> podManagerPort;
            port shipControllerPort : LogicalShipCommandPort :>> shipControllerPort;
            port longRangeDirectionalSensorCommandPort : LogicalScanCommandsSubPort :>> longRangeDirectionalSensorCommandPort;
            port navigationManagerCommandPort : LogicalNavigationCommandsSubPort :>> navigationManagerCommandPort;
            port extensionModulesManagementArrayPort : LogicalModuleCommandsSubPort :>> extensionModulesManagementArrayPort;
            port droneManagerCommandPort : LogicalDroneCommandsSubPort :>> droneManagerCommandPort;
            port targetLockComputerArrayPort : LogicalTargetingCommandsSubPort :>> targetLockComputerArrayPort;
            port commandNetworkLowPowerGridPort :>> lowPowerGridPort; 
            
            part lowPowerSupplyUnit : LogicalPart {
                
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port controlRelayPort :>> lowPowerLinePort;
                
                perform logicalInitializeCommandNetwork.logicalPowerUpcommandNetwork;
            }
            part controlRelay : LogicalPart {
                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort; 
                port podManagerPort : ~LogicalShipCommandPort;
                port shipControllerPort : LogicalShipCommandPort;
                port longRangeDirectionalSensorCommandPort : LogicalScanCommandsSubPort;
                port navigationManagerCommandPort : LogicalNavigationCommandsSubPort;
                port extensionModulesManagementArrayPort : LogicalModuleCommandsSubPort;
                port droneManagerCommandPort : LogicalDroneCommandsSubPort;
                port targetLockComputerArrayPort : LogicalTargetingCommandsSubPort;

                    perform logicalInitializeCommandNetwork.relayControl {
                        in podControlCommandPort : ~LogicalShipCommandPort = podManagerPort; 
                        in relayShipControllerCommandsPort : LogicalShipCommandPort = shipControllerPort;
                        in relaySensorCommandsPort : LogicalScanCommandsSubPort = longRangeDirectionalSensorCommandPort;
                        in relayNavCommandsPort : LogicalNavigationCommandsSubPort = navigationManagerCommandPort;  
                        in relayModuleCommandsPort : LogicalModuleCommandsSubPort = extensionModulesManagementArrayPort;
                        in relayDronesCommandsPort : LogicalDroneCommandsSubPort = droneManagerCommandPort;
                        in relayTargetLockCommandsPort: LogicalTargetingCommandsSubPort = targetLockComputerArrayPort;
                    }
            }
            
            part lowPowerWiring : LogicalPart {
                ref lowPowerSupplyUnit :>> lowPowerSupplyUnit;
                ref controlRelay :>> controlRelay;

                //Low power wiring
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.controlRelayPort to
                    consumerPort ::> controlRelay.lowPowerSupplyUnitPort;       
            }

            bind podManagerPort = controlRelay.podManagerPort;
            bind shipControllerPort = controlRelay.shipControllerPort;
            bind longRangeDirectionalSensorCommandPort = controlRelay.longRangeDirectionalSensorCommandPort;
            bind navigationManagerCommandPort = controlRelay.navigationManagerCommandPort;
            bind extensionModulesManagementArrayPort = controlRelay.extensionModulesManagementArrayPort;
            bind droneManagerCommandPort = controlRelay.droneManagerCommandPort;
            bind targetLockComputerArrayPort = controlRelay.targetLockComputerArrayPort;
            bind commandNetworkLowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;

            action :>> logicalInitializeCommandNetwork {
                doc /*
                    * Start services of the control network. 
                    */

                in podManagerProxyPort : ~LogicalShipCommandPort :>> podManagerProxyPort;
                in longRangeDirectionalSensorCommandProxyPort : LogicalShipCommandPort :>> longRangeDirectionalSensorCommandProxyPort;
                in navigationManagerCommandProxyPort  : LogicalShipCommandPort :>> navigationManagerCommandProxyPort;
                in extensionModulesManagementArrayProxyPort : LogicalShipCommandPort :>> extensionModulesManagementArrayProxyPort;
                in droneManagerCommandProxyPort : LogicalShipCommandPort :>> droneManagerCommandProxyPort;
                in targetLockComputerArrayProxyPort: LogicalShipCommandPort :>> targetLockComputerArrayProxyPort;
                
                first start;
                then action logicalPowerUpcommandNetwork;
                then action relayControl {
                    doc/*
                        * Relay signals received from the podManager to all parts in the control network
                        * Relay back reports from the ship to the podManager
                        */
                    in podControlCommandPort : ~LogicalShipCommandPort;
                    in relayShipControllerCommandsPort : LogicalShipCommandPort; 
                    in relaySensorCommandsPort : LogicalScanCommandsSubPort;
                    in relayNavCommandsPort : LogicalNavigationCommandsSubPort;  
                    in relayModuleCommandsPort : LogicalModuleCommandsSubPort;
                    in relayDronesCommandsPort : LogicalDroneCommandsSubPort;
                    in relayTargetLockCommandsPort: LogicalTargetingCommandsSubPort;      
                }   
            }
        }

    }
}