package ShipControllerGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {
        
        part shipControllerGrayBox : LogicalPart :> shipController {
            doc /*
                * Central controller of the ship that executes the state machine and
                * controls the parts of the ship.
                */
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;

            exhibit logicalWhiteBoxMiningFrigateStates {
                in logicalWhiteBoxMiningFrigateVentureClass :> logicalGrayBoxMiningFrigateVentureClass;
                in commandNetworkProxyPort = commandNetworkPort; 
            }
        }

        state logicalWhiteBoxMiningFrigateStates :>> logicalGrayBoxMiningFrigateStates {
            doc /*
                * This state defines the control behavior of the ship
                */
            in logicalWhiteBoxMiningFrigateVentureClass :> logicalGrayBoxMiningFrigateVentureClass;
            in commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;
    
            entry action :>> initial;
            then state LogicalWhiteBoxParked :>> LogicalGrayBoxParked {
                doc /* The mining frigate is parked inside a station and can be boarded. */
            } 	
            state LogicalWhiteBoxBoarded :>> LogicalGrayBoxBoarded {
                doc /* The mining frigate is boarded inside a station in the docking pad, available for refitting, resupply, or cargo transfer. */
            }
            state LogicalWhiteBoxInGrid :>> LogicalGrayBoxInGrid {
                doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
            }
            state LogicalWhiteBoxOnWarp :>> LogicalGrayBoxOnWarp {
                doc /* The mining frigate is in warp, traveling between locations. */
            }        
            
            transition logical_parked_to_boarded
                first LogicalWhiteBoxParked
                accept when logicalWhiteBoxMiningFrigateVentureClass.podManager.podDockedStatus == true
                then LogicalWhiteBoxBoarded;
            
            transition logical_boarded_to_parked
                first LogicalWhiteBoxBoarded
                accept when logicalWhiteBoxMiningFrigateVentureClass.podManager.podDockedStatus == false
                then LogicalWhiteBoxParked;
            
            transition logical_boarded_to_inGrid
                first LogicalWhiteBoxBoarded
                accept when logicalWhiteBoxMiningFrigateVentureClass.dockingManager.shipDockedStatus == false
                do logicalStartUpSequence
                then LogicalWhiteBoxInGrid;  		
                
            transition logical_inGrid_to_docked
                first LogicalWhiteBoxInGrid
                accept pilotPodDockCommandSig :>> pilotPodDockCommandSig via commandNetworkPort
                do logicalShutDownSequence
                then LogicalWhiteBoxBoarded;
                
            transition logical_inGrid_to_onWarp
                first LogicalWhiteBoxInGrid
                accept warpCommandSig :>> warpCommandSig via commandNetworkPort
                do logicalPrepareForWarp
                then LogicalWhiteBoxOnWarp;
        
            transition logical_onWarp_to_inGrid
                first LogicalWhiteBoxOnWarp
                accept when logicalWhiteBoxMiningFrigateVentureClass.warpBubbleEnd
                then LogicalWhiteBoxInGrid;                   
        }
        
        action logicalStartUpSequence {
            doc /*
                * Initialize the services of the ship for using by the pilot
                */

            first start;
            then action powerUpShipController;
            then perform powerGrid.logicalInitializePowerGrid;
            then perform powerGenerator.logicalInitializeGenerator;
            then perform podManager.logicalInitializePodManagerServices;
            then perform commandNetwork.logicalInitializeCommandNetwork;
            then perform longRangeDirectionalSensor.logicalInitializeLongRangeScanServices;
            then perform gridOmnidirectionalSensor.logicalInitializeGridScanServices;
            then perform navigationManager.logicalInitializeNavigationServices;
            then perform targetLockComputerArray.initializeTargetingComputers;
            then perform shipProcessor.logicalInitializeShipProcessor;
            then perform droneControlManager.logicalInitializeDroneServices;
            then perform extensionModulesManagementArray.logicalInitializeExtensionModulesManagementArray;
            then perform computationNetwork.logicalInitializeComputationNetwork;
            
        }
        
        action logicalShutDownSequence;
        action logicalPrepareForWarp; 
    }
    
}