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
                port shipControllerCommandsPort : LogicalShipCommandPort;
                port longRangeDirectionalSensorCommandPort : LogicalScanCommandsSubPort;
                port navigationManagerCommandPort : LogicalNavigationCommandsSubPort;
                port extensionModulesManagementArrayPort : LogicalModuleCommandsSubPort;
                port droneManagerCommandPort : LogicalDroneCommandsSubPort;
                port targetLockComputerArrayPort : LogicalTargetingCommandsSubPort;

                    perform logicalInitializeCommandNetwork.relayControl {
                        in relayControl_podManagerPort : ~LogicalShipCommandPort = podManagerPort; 
                        in relayControl_ShipControllerCommandsPort : LogicalShipCommandPort = shipControllerCommandsPort;
                        in relayControl_longRangeDirectionalSensorCommandPort : LogicalScanCommandsSubPort = longRangeDirectionalSensorCommandPort;
                        in relayControl_navigationManagerCommandPort : LogicalNavigationCommandsSubPort = navigationManagerCommandPort;  
                        in relayControl_extensionModulesManagementArrayPort : LogicalModuleCommandsSubPort = extensionModulesManagementArrayPort;
                        in relayControl_droneManagerCommandPort : LogicalDroneCommandsSubPort = droneManagerCommandPort;
                        in relayControl_targetLockComputerArrayPort: LogicalTargetingCommandsSubPort = targetLockComputerArrayPort;
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
            bind shipControllerPort = controlRelay.shipControllerCommandsPort;
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

                in podManagerPort : ~LogicalShipCommandPort :>> podManagerPort;
                in ShipControllerCommandsPort : LogicalShipCommandPort; 
                in longRangeDirectionalSensorCommandPort : LogicalShipCommandPort :>> longRangeDirectionalSensorCommandPort;
                in navigationManagerCommandPort  : LogicalShipCommandPort :>> navigationManagerCommandProxyPort;
                in extensionModulesManagementArrayPort : LogicalShipCommandPort :>> extensionModulesManagementArrayPort;
                in droneManagerCommandPort : LogicalShipCommandPort :>> droneManagerCommandPort;
                in targetLockComputerArrayPort: LogicalShipCommandPort :>> targetLockComputerArrayPort;
                
                first start;
                then action logicalPowerUpcommandNetwork;
                then action relayControl {
                    doc/*
                        * Relay signals received from the podManager to all parts in the control network
                        * Relay back reports from the ship to the podManager
                        */     
                }   
            }
        }

    }
}