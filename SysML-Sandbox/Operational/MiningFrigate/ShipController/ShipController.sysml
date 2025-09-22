package ShipController {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part logicalMiningFrigateVentureClass : LogicalMiningFrigateVentureClass {
        
        part shipController : LogicalPart :>> shipController {
            doc /*
                * Central controller of the ship that executes the state machine and
                * controls the parts of the ship.
                */
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;

            state :>> logicalMiningFrigateStates {
                doc /*
                    * This state defines the control behavior of the ship
                    */
                in shipControllerCommandPort : ~LogicalShipCommandPort = commandNetworkPort;
                in shipWarpBubbleEnd : Boolean = warpBubbleEnd;
                in podDocked : Boolean = podManager.podDocked;
                in shipDocked : Boolean = dockingManager.shipDockedStatus;

                
                entry action initial;
                then state LogicalParked {
                    doc /* The mining frigate is parked inside a station and can be boarded. */
                } 	
                state LogicalBoarded {
                    doc /* The mining frigate is boarded inside a station in the docking pad, available for refitting, resupply, or cargo transfer. */
                }
                state LogicalInGrid {
                    doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
                }
                state LogicalOnWarp {
                    doc /* The mining frigate is in warp, traveling between locations. */
                }        
                
                transition logicalMiningFrigate_parked_to_boarded
                    first LogicalParked
                    accept when podDocked == true
                    then LogicalBoarded;
                
                transition logicalMiningFrigate_boarded_to_parked
                    first LogicalBoarded
                    accept when podDocked == false
                    then LogicalParked;
                
                transition logicalMiningFrigate_boarded_to_inGrid
                    first LogicalBoarded
                    accept when shipDocked == false
                    do logicalStartUpSequence
                    then LogicalInGrid;  		
                    
                transition logicalMiningFrigate_inGrid_to_docked
                    first LogicalInGrid
                    accept pilotPodDockCommandSig :>> pilotPodDockCommandSig via shipControllerCommandPort
                    do logicalShutDownSequence
                    then LogicalBoarded;
                    
                transition logicalMiningFrigate_inGrid_to_onWarp
                    first LogicalInGrid
                    accept warpCommandSig :>> warpCommandSig via shipControllerCommandPort
                    do logicalPrepareForWarp
                    then LogicalOnWarp;
            
                transition logicalMiningFrigate_onWarp_to_inGrid
                    first LogicalOnWarp
                    accept when shipWarpBubbleEnd
                    then LogicalInGrid;                   
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
                then perform commandNetwork.logicalInitializecommandNetwork;
                then perform longRangeDirectionalSensor.logicalInitializeLongRangeScanServices;
                then perform gridSensor.logicalInitializeGridScanServices;
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
}