package NavigationManager {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part logicalMiningFrigateVentureClass : LogicalMiningFrigateVentureClass {
        
        part navigationManager : LogicalPart :>> navigationManager{
                doc /*
                    * Executes navigation commands received from the controller
                    */
                port :>> commandNetworkPort : ~LogicalShipCommandPort;
                port :>> mainPropulsorAnalog : LogicalAnalogPort;
                port :>> zdirectionalPropulsorAnalog : LogicalAnalogPort;
                port :>> ydirectionalPropulsorAnalog : LogicalAnalogPort;

                action :>> logicalInitializeNavigationServices {
                    doc /*
                        * Enable navigation commands
                        */
                    in :>> navigationServicesCommandPort : LogicalShipCommandPort;

                    first start; 
                    then action logicalPowerUpNavigationSystem;
                    then fork;
                        then logicalApproachSignatureAtRange;
                        then logicalOrbitSignatureAtRange;
                        then logicalKeepAtRangeSignature;
                        then logicalDockInStation;
                        then logicalexecuteWarpDrive;
                        
                    action logicalApproachSignatureAtRange {
                        action acceptApproachSignatureCommand accept approachSignatureCommand : LogicalApproachSignatureCommand via navigationServicesCommandPort;
                        then action navigateToSignature {
                            in navigationTarget : LogicalSignature = acceptApproachSignatureCommand.approachSignatureCommand.destinationSignature;
                            in atRange : Real = acceptApproachSignatureCommand.approachSignatureCommand.atRange;
                        }
                        then action logicalreportStatusApproach {out shipReport : LogicalShipReport;}
                        then send logicalreportStatusApproach.shipReport via navigationServicesCommandPort;
                    }
                    action logicalOrbitSignatureAtRange;
                    action logicalKeepAtRangeSignature;
                    action logicalDockInStation {
                        doc /*
                            * Navigates to docking radius of the given station
                            * Requests docking permission and reports back to pod
                            */
                        action acceptDockingCommand accept dockToStationCommand : LogicalDockToStationCommand via navigationServicesCommandPort;
                        then action logicalrequestDockingClearance {
                            in station = acceptDockingCommand.dockToStationCommand.destinationSignature; 
                            out ShipReport : LogicalShipReport;
                        }
                        //more actions come here
                        then send logicalrequestDockingClearance.ShipReport via navigationServicesCommandPort;
                        then action acceptDockingRequest accept DockingRequestAccepted : LogicalControlCommand;
                        //more actions come here
                        then action logicalreportRequestAccepted {out shipReport : LogicalShipReport;}
                        then send logicalreportRequestAccepted.shipReport via navigationServicesCommandPort;
                    }
                    action logicalexecuteWarpDrive  {
                        doc /*
                            * Executes the navigation maneuvres to initiate warp and activates the warp generator
                            */
                        in logicalWarpCommandPort : LogicalShipCommandPort;
                        in warpBubbleEnd : LogicalCelestialSignature;

                        action acceptwarpCommand accept logicalExecuteWarpCommand : LogicalExecuteWarpDriveCommand via logicalWarpCommandPort;
                        then action reportStatusWarpDrive {out shipReport : LogicalShipReport;}
                        then send reportStatusWarpDrive.shipReport via logicalWarpCommandPort;
                        then perform warpGenerator.warpToBubbleEnd {
                            in bubbleEnd = warpBubbleEnd; 
                            in destination = acceptwarpCommand.logicalExecuteWarpCommand.destinationSignature;
                        } 
                        then action reportStatusDestination {out shipReport : LogicalShipReport;}
                        then send reportStatusDestination.shipReport via logicalWarpCommandPort;
                    }  
                }
            }

    }
}