package LogicalMiningFrigate {
    
    private import DomainPackage::*;
    private import MiningFrigatePackage::*;
    private import ScalarValues::*;
    private import COTS::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;
    private import StdPortsAndInterfaces::GallenteTechnology::*;
    private import RollupAnalysis::*;
    private import MiningFrigateActions_logical::*;
    private import ParametersOfInterestMetadata::*;

    //Logical Mining Frigate
    part def LogicalMiningFrigateVentureClass :> MiningFrigateVentureClass {
        doc /* The logical mining frigate inherit all the features of the mining frigate
        * and will define the logical system elements that will perform the defined
        * system behavior. logical system elements will be defined of three types: 
        * interfacing systems, aplication systems, and support systems.  
         */
        
        attribute massShip :>> massShip default 1200000.0;
        attribute suppliedPowerGrid :>> suppliedPowerGrid default 45;
        attribute suppliedCapacitor :>> suppliedCapacitor default 250.0;
        attribute suppliedCpu :>> suppliedCpu default 240;
        attribute maxVelocity :>> maxVelocity default 335.0; 
        attribute warpSpeed :>> warpSpeed default 5.0; 
        attribute alignTime :>> alignTime default 5.99;  
        attribute structureStrength :>> structureStrength : Real default 200.0;  
        attribute armorStrength :>> armorStrength : Real default 175.0; 
        attribute shieldStrength :>> shieldStrength : Real default 225.0;  
        attribute cargoHoldCapacity :>> cargoHoldCapacity : Real default 50; 
        attribute warpCoreStrength :>> warpCoreStrength default 2;   
        attribute oreHoldCapacity :>> oreHoldCapacity : Real default 5000.0;
        attribute droneCapacity :>> droneCapacity : Real default 10;
        attribute oreHoldStatus :>> oreHoldStatus : Real default 2;
        attribute maxLockedTargets :>> maxLockedTargets default 5; 
        attribute magnetometricSensorStrength :>> magnetometricSensorStrength default 4;
        #mop attribute yieldBonus :>> yieldBonus;
        
        //Ports of the mining frigate redefine the imperial ship definition
        port highPowerSlot1 :>> highPowerSlot1;
        port highPowerSlot2 :>> highPowerSlot2;
        port highPowerSlot3 :>> highPowerSlot3;
        port midPowerSlot1 :>> midPowerSlot1;
        port midPowerSlot2 :>> midPowerSlot2;
        port midPowerSlot3 :>> midPowerSlot3;
        port lowPowerSlot1 :>> lowPowerSlot1;
        //Rig extension points of the mining frigate redefine the imperial ship definition
        port rigPort1 :>> rigPort1;
        port rigPort2 :>> rigPort2;
        port rigPort3 :>> rigPort3;
        //Other ports redefine the imperial ship definition or add to the specific ship
        port podPort :>> podPort;
        port dockingPort :>> dockingPort;
        port droneControlAntenna :>> droneControl[2];
        port longRangeDirectionalSensorAntenna :>> longRangeDirectionalSensorAntenna;
        port gridSensorAntenna :>> gridSensorAntenna;
        port shipCommsAntenna :>> shipComms;
        port zPropulsion :>> zPropulsion[4];
        port xPropulsion :>> xPropulsion[2];
        port yPropulsion :>> yPropulsion[2];
        //part oreScooper;

        //Ship resilience ports
        port warpShield :>> warpShield {
            attribute warpShielding :>> warpShielding;
        }
        port shieldMitigationPort :>> shieldMitigationPort;
        port armourMitigationPort :>> armourMitigationPort;
        port structureMitigationPort :>> structureMitigationPort;

        //logical parts
        //Logical interfacing parts  
        part highPowerSlotManager1 {
            port highPowerSlotManagerPort : HighSlotPort;
        }
        part highPowerSlotManager2 {
            port highPowerSlotManagerPort : HighSlotPort;
        }
        part highPowerSlotManager3 {
            port highPowerSlotManagerPort : HighSlotPort;
        }
        part midPowerSlotManager1 {
            port midPowerSlotManagerPort : MediumSlotPort;
        }
        part midPowerSlotManager2 {
            port midPowerSlotManagerPort : MediumSlotPort;
        }
        part midPowerSlotManager3 {
            port midPowerSlotManagerPort : MediumSlotPort;
        }
        part lowPowerSlotManager1 {
            port lowPowerSlotManagerPort : LowSlotPort;
        }

        part rigCoupler1 {
            port rigCouplingPort : RigPortSmall;
        }
        part rigCoupler2 {
            port rigCouplingPort : RigPortSmall;
        }
        part rigCoupler3 {
            port rigCouplingPort : RigPortSmall;
        }

        part podManager {
            port podManagerPort : PodPort;
        }
        part dockingManager {
            port dockingManagerPort : DockingPort;
        }
        part droneControlManager {
            port droneControlManagerPort : DroneControllerPort[2];
        }
        part longRangeDirectionalSensor {
            port longRangeDirectionalSensorAntenna : LongRangeSensorDirectionalAntenna;
        }
        part gridSensor {
            port gridSensorAntenna : GridSensorAntenna;
        }
        part shipCommsManager {
            port shipCommsPort : ShipComms;
        } 
        part mainPropulsor {
            port mainPropulsionNozzle : MainPropulsion[4];
        }
        part xAxisRotator {
            port directionalPropulsorNozzle : DirectionalPropulsion[2];
        }
        part yAxisRotator {
            port directionalPropulsorNozzle : DirectionalPropulsion[2];
        }

        part warpGenerator {
            port warpShield : WarpDriveDisruptionShield {
                attribute warpShielding :>> warpShielding;
            }
        }
        part shieldGenerator {
            port shieldProjector : ~ThreatPort;
        }
        part armourManager {
            port armourPlate : ~ThreatPort;
        }
        part structureManager {
            port structureEnclosure : ~ThreatPort;
        }

        //Binding interfacing logical parts to the logical ports
        bind highPowerSlotManager1.highPowerSlotManagerPort = highPowerSlot1;
        bind highPowerSlotManager2.highPowerSlotManagerPort = highPowerSlot2;
        bind highPowerSlotManager3.highPowerSlotManagerPort = highPowerSlot3;
        bind midPowerSlotManager1.midPowerSlotManagerPort = midPowerSlot1;
        bind midPowerSlotManager2.midPowerSlotManagerPort = midPowerSlot2;
        bind midPowerSlotManager3.midPowerSlotManagerPort = midPowerSlot3;
        bind lowPowerSlotManager1.lowPowerSlotManagerPort = lowPowerSlot1;
        bind rigCoupler1.rigCouplingPort = rigPort1;
        bind rigCoupler2.rigCouplingPort = rigPort2;
        bind rigCoupler3.rigCouplingPort = rigPort3;
        bind podManager.podManagerPort = podPort;
        bind dockingManager.dockingManagerPort = dockingPort;
        bind droneControlManager.droneControlManagerPort = droneControlAntenna;
        bind longRangeDirectionalSensor.longRangeDirectionalSensorAntenna = longRangeDirectionalSensorAntenna;
        bind gridSensor.gridSensorAntenna = gridSensorAntenna;
        bind shipCommsManager.shipCommsPort = shipCommsAntenna;
        bind mainPropulsor.mainPropulsionNozzle = zPropulsion;
        bind xAxisRotator.directionalPropulsorNozzle = xPropulsion;
        bind yAxisRotator.directionalPropulsorNozzle = yPropulsion;
        bind warpGenerator.warpShield = warpShield;
        bind shieldGenerator.shieldProjector = shieldMitigationPort;
        bind armourManager.armourPlate = armourMitigationPort;
        bind structureManager.structureEnclosure = structureMitigationPort;

        //Logical application parts
        part shipController : GallenteStandardComponent;
        part powerGridManager : GallenteStandardComponent;
        part miningYieldEnhancer : GallenteStandardComponent;
        part powerGenerator : GallenteStandardComponent;
        part energyStore : GallenteStandardComponent;
        part oreStore : GallenteStandardComponent;
        part targetLockManager[5] : GallenteStandardComponent;
        part navigationManager : GallenteStandardComponent;
        part communicationManager : GallenteStandardComponent;
        part droneStore : GallenteStandardComponent;

        //connectivity of logical application parts with logical interfacing parts
        

        //Logical infrastructure parts
        part powerGrid : GallenteStandardComponent;
        part computationNetwork : GallenteStandardComponent;

        //connectivity of logical infrastructure parts with logical interfacing parts




        //Logical behavior inherited from the mining frigate definition
        state logicalminingFrigateStates :>> miningFrigateStates {
            
            entry action initial;
            then state LogicalParked :>> Parked {
                doc /* The mining frigate is parked inside a station and can be boarded. */
            } 	
            state LogicalBoarded :>> Boarded {
                doc /* The mining frigate is boarded inside a station in the docking pad, available for refitting, resupply, or cargo transfer. */
                exit action logicalUndockFromStationMiningFrigate;
            }
            state LogicalInGrid :>> InGrid {
                doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
            }
            state LogicalOnWarp :>> OnWarp {
                doc /* The mining frigate is in warp, traveling between locations. */
                entry action executeWarpDrive;
            }        
            
            transition logicalMiningFrigate_parked_to_boarded
                first LogicalParked
                accept boardShip : StationCommand via podPort
                then LogicalBoarded;
            
            transition logicalMiningFrigate_boarded_to_parked
                first LogicalBoarded
                accept unboardShip : StationCommand via podPort
                then LogicalParked;
            
            transition logicalMiningFrigate_boarded_to_inGrid
                first LogicalBoarded
                accept pilotPodUndockCommandSig : ShipCommand via podPort
                do action logicalInitializeGridServicesMiningFrigate
                then LogicalInGrid;  		
                
            transition logicalMiningFrigate_inGrid_to_docked
                first LogicalInGrid
                accept pilotPodDockCommandSig : ShipCommand via podPort
                then LogicalBoarded;
                
            transition logicalMiningFrigate_inGrid_to_onWarp
                first LogicalInGrid
                accept warpCommandSig : ShipCommand via podPort
                then LogicalOnWarp;
        
            transition logicalMiningFrigate_onWarp_to_inGrid
                first LogicalOnWarp
                accept when warpBubbleEnd
                then LogicalInGrid;  
        } 

        action logicalInitializeGridServices :>> initializeGridServices {
            doc /*This action initializes the spaceship for the operational services in grid.
                    * The actions do not end of themselves but will be terminated by the transition on the state. 
                    */
            first start;
            then fork;
                then logicalInitializeScanSpaceServices;
                then logicalInitializeNavigationServices;
                then logicalDockInStation;
                then logicalExecuteWarpDrive;
                then logicalInitializeDrones;
                then initializeExtensionModulesAndRigs;

            action logicalInitializeScanSpaceServices :>> initializeScanSpaceServices;
            action logicalInitializeNavigationServices :>> initializeNavigationServices;
            action logicalDockInStation :>> dockInStation;
            action logicalExecuteWarpDrive :>> executeWarpDrive;
            action logicalInitializeDrones :>> initializeDrones {
                //more actions will come here
            }
            action :>> initializeExtensionModulesAndRigs;    
        }
        action logicalTransferOre :>> transferOre { //the Mining Frigate hull has a built in ore hold with transfer functionality. 
            doc /*Transfer Ores from the ore hold in the frigate to the station warehouse*/
            //more actions will come here  
        }
        action logicalUndockFromStation :>> undockFromStation; //more actions will come here
    }  
}