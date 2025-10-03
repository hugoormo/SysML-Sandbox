package NavigationManagerGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {
        
        part navigationManagerGrayBox : LogicalPart :> navigationManager {
            doc /*
                * Executes navigation commands received from the controller
                */

            attribute alignTime :>> alignTime default 5.99;

            port :>> commandNetworkPort : ~LogicalShipCommandPort;
            port :>> mainPropulsorAnalogPort : LogicalAnalogPort;
            port :>> zdirectionalPropulsorAnalogPort : LogicalAnalogPort;
            port :>> ydirectionalPropulsorAnalogPort : LogicalAnalogPort;
            port navigationManagerLowPowerGridPort :>> lowPowerGridPort;

            part lowPowerSupplyUnit : LogicalPart {
                
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port navigationComputerPort :>> lowPowerLinePort;
                
                perform logicalInitializeNavigationServices.logicalPowerUpNavigationSystem;
            }
            
            part navigationComputer : LogicalPart {

                port commandNetworkPort : ~LogicalShipCommandPort;
                port mainPropulsorAnalogPort : LogicalAnalogPort;
                port zdirectionalPropulsorAnalogPort : LogicalAnalogPort;
                port ydirectionalPropulsorAnalogPort : LogicalAnalogPort;
                port lowPowerSupplyUnitPort :>> lowPowerLinePort;

                perform logicalInitializeNavigationServices {
                    in commandNetworkPort : ~LogicalShipCommandPort;
                    out mainPropulsorControl : LogicalAnalogSignal;
                    out zdirectionalPropulsorControl : LogicalAnalogSignal;
                    out ydirectionalPropulsorControl : LogicalAnalogSignal;
                }
            }

            part lowPowerWiring : LogicalPart {
                ref lowPowerSupplyUnit :>> lowPowerSupplyUnit;
                ref navigationComputer :>> navigationComputer;

                //Low power wiring
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.navigationComputerPort to
                    consumerPort ::> navigationComputer.lowPowerSupplyUnitPort;       
            }            

            bind commandNetworkPort = navigationComputer.commandNetworkPort;
            bind mainPropulsorAnalogPort = navigationComputer.mainPropulsorAnalogPort;
            bind zdirectionalPropulsorAnalogPort = navigationComputer.zdirectionalPropulsorAnalogPort;
            bind ydirectionalPropulsorAnalogPort = navigationComputer.ydirectionalPropulsorAnalogPort;
            bind navigationManagerLowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;

            action :>> logicalInitializeNavigationServices {
                doc /*
                    * Enable navigation commands
                    */
                in :>> commandNetworkProxyPort : ~LogicalShipCommandPort;
                out :>> mainPropulsorControl : LogicalAnalogSignal;
                out :>> zdirectionalPropulsorControl : LogicalAnalogSignal;
                out :>> ydirectionalPropulsorControl : LogicalAnalogSignal;

                first start; 
                then action logicalPowerUpNavigationSystem;
                then fork;
                    then logicalApproachSignatureAtRange;
                    then logicalOrbitSignatureAtRange;
                    then logicalKeepAtRangeSignature;
                    then logicalDockInStation;
                    then logicalexecuteWarpDrive;
                    
                action logicalApproachSignatureAtRange {

                    action acceptApproachSignatureCommand accept approachSignatureCommand : LogicalApproachSignatureCommand via commandNetworkProxyPort;
                    then action navigateToSignature {
                        in navigationTarget : LogicalSignature = acceptApproachSignatureCommand.approachSignatureCommand.destinationSignature;
                        in atRange : Real = acceptApproachSignatureCommand.approachSignatureCommand.atRange;
                    }
                    then action logicalreportStatusApproach {out shipReport : LogicalShipReport;}
                    then send logicalreportStatusApproach.shipReport via commandNetworkProxyPort;
                }
                action logicalOrbitSignatureAtRange;
                action logicalKeepAtRangeSignature;
                action logicalDockInStation {
                    doc /*
                        * Navigates to docking radius of the given station
                        * Requests docking permission and reports back to pod
                        */
                    action acceptDockingCommand accept dockToStationCommand : LogicalDockToStationCommand via navigationComandsPort;
                    then action logicalrequestDockingClearance {
                        in station = acceptDockingCommand.dockToStationCommand.destinationSignature; 
                        out ShipReport : LogicalShipReport;
                    }
                    //more actions come here
                    then send logicalrequestDockingClearance.ShipReport via navigationComandsPort;
                    then action acceptDockingRequest accept DockingRequestAccepted : LogicalControlCommand;
                    //more actions come here
                    then action logicalreportRequestAccepted {out shipReport : LogicalShipReport;}
                    then send logicalreportRequestAccepted.shipReport via navigationComandsPort;
                }
                action logicalexecuteWarpDrive  {
                    doc /*
                        * Executes the navigation maneuvres to initiate warp and activates the warp generator
                        */
                    in warpBubbleEnd : LogicalCelestialSignature;

                    action acceptwarpCommand accept logicalExecuteWarpCommand : LogicalExecuteWarpDriveCommand via commandNetworkProxyPort;
                    then action reportStatusWarpDrive {out shipReport : LogicalShipReport;}
                    then send reportStatusWarpDrive.shipReport via commandNetworkProxyPort;
                    then perform warpGenerator.warpToBubbleEnd {
                        in bubbleEnd = warpBubbleEnd; 
                        in destination = acceptwarpCommand.logicalExecuteWarpCommand.destinationSignature;
                    } 
                    then action reportStatusDestination {out shipReport : LogicalShipReport;}
                    then send reportStatusDestination.shipReport via commandNetworkProxyPort;
                }  
            }    
        }
    }
}