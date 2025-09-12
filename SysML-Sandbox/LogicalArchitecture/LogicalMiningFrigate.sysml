package LogicalMiningFrigate {
    
    private import MiningFrigatePackage::*;
    private import ScalarValues::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalContext::*;
    private import LogicalActionsMiningFrigate::*;

    
    //Logical Mining Frigate
    part def LogicalMiningFrigateVentureClass :> MiningFrigateVentureClass {
        doc /*
            * The logical architecture serves as an intermediate level of abstraction 
            * between the black-box system requirements and the physical architecture.
            * (S. Friedenthal et al.)  
            * The logical mining frigate inherit all the features of the mining frigate
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
        attribute warpBubbleEnd :>> warpBubbleEnd;  
        attribute oreHoldCapacity :>> oreHoldCapacity : Real default 5000.0;
        attribute droneCapacity :>> droneCapacity : Real default 10;
        attribute oreHoldStatus :>> oreHoldStatus : Real default 2;
        attribute maxLockedTargets :>> maxLockedTargets default 5; 
        attribute gravimetricSensorStrength :>> gravimetricSensorStrength default 4;
        #mop attribute yieldBonus :>> yieldBonus;
        
        //Ports of the mining frigate redefine the imperial ship definition
        port highPowerSlot1 : LogicalHighSlotPort :>> highPowerSlot1;
        port highPowerSlot2 : LogicalHighSlotPort :>> highPowerSlot2;
        port highPowerSlot3 : LogicalHighSlotPort :>> highPowerSlot3;
        port midPowerSlot1 : LogicalMediumSlotPort :>> midPowerSlot1;
        port midPowerSlot2 : LogicalMediumSlotPort :>> midPowerSlot2;
        port midPowerSlot3 : LogicalMediumSlotPort :>> midPowerSlot3;
        port lowPowerSlot1 : LogicalLowSlotPort :>> lowPowerSlot1;
        //Rig extension points of the mining frigate redefine the imperial ship definition
        port rigPort1 : LogicalRigPort :>> rigPort1;
        port rigPort2 : LogicalRigPort :>> rigPort2;
        port rigPort3 : LogicalRigPort :>> rigPort3;
        //Other ports redefine the imperial ship definition or add to the specific ship
        port podPort : LogicalPodPort :>> podPort;
        port dockingPort : LogicalDockingPort :>> dockingPort;
        port droneControlAntenna : LogicalDroneControllerPort :>> droneControl[2];
        port longRangeDirectionalSensorAntenna : LogicalLongRangeSensorDirectionalAntenna :>> longRangeDirectionalSensorAntenna;
        port gridSensorAntenna : LogicalGridSensorAntenna :>> gridSensorAntenna;
        port shipCommsAntenna : LogicalShipCommsPort :>> shipComms;
        port zPropulsion : LogicalDirectionalPropulsion :>> zPropulsion[4];
        port xPropulsion : LogicalMainPropulsion :>> xPropulsion[2];
        port yPropulsion : LogicalDirectionalPropulsion :>> yPropulsion[2];
        //part oreScooper;

        //Ship resilience ports
        port warpShield :>> warpShield {
            attribute warpShielding :>> warpShielding;
        }
        port shieldMitigationPort :>> shieldMitigationPort;
        port armourMitigationPort :>> armourMitigationPort;
        port structureMitigationPort :>> structureMitigationPort;

        
        //Logical interfacing parts  
        part highPowerSlotManager1 {
            port highPowerSlotManagerPort : LogicalHighSlotPort;
        }
        part highPowerSlotManager2 {
            port highPowerSlotManagerPort : LogicalHighSlotPort;
        }
        part highPowerSlotManager3 {
            port highPowerSlotManagerPort : LogicalHighSlotPort;
        }
        part midPowerSlotManager1 {
            port midPowerSlotManagerPort : LogicalMediumSlotPort;
        }
        part midPowerSlotManager2 {
            port midPowerSlotManagerPort : LogicalMediumSlotPort;
        }
        part midPowerSlotManager3 {
            port midPowerSlotManagerPort : LogicalMediumSlotPort;
        }
        part lowPowerSlotManager1 {
            port lowPowerSlotManagerPort : LogicalLowSlotPort;
        }

        part rigCoupler1 {
            port rigCouplingPort : LogicalRigPort;
        }
        part rigCoupler2 {
            port rigCouplingPort : LogicalRigPort;
        }
        part rigCoupler3 {
            port rigCouplingPort : LogicalRigPort;
        }

        part podManager {
            port podManagerPort : LogicalPodPort;
        }
        part dockingManager {
            port dockingManagerPort : LogicalDockingPort;
        }
        part droneControlManager {
            port droneControlManagerPort : LogicalDroneControllerPort[2];
        }
        part longRangeDirectionalSensor {
            port longRangeDirectionalSensorAntenna : LogicalLongRangeSensorDirectionalAntenna;
        }
        part gridSensor {
            port gridSensorAntenna : LogicalGridSensorAntenna;
        }
        part shipCommsManager {
            port shipCommsPort : LogicalShipComms;
        } 
        part mainPropulsor {
            port mainPropulsionNozzle : LogicalMainPropulsion[4];
        }
        part xAxisRotator {
            port directionalPropulsorNozzle : LogicalDirectionalPropulsion[2];
        }
        part yAxisRotator {
            port directionalPropulsorNozzle : LogicalDirectionalPropulsion[2];
        }

        part warpGenerator {
            port warpShield : LogicalWarpDriveDisruptionShield {
                attribute warpShielding :>> warpShielding;
            }
        }
        part shieldGenerator {
            port shieldProjector : ~LogicalThreatPort;
        }
        part armourManager {
            port armourPlate : ~LogicalThreatPort;
        }
        part structureManager {
            port structureEnclosure : ~LogicalThreatPort;
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
        part shipController : LogicalPart;
        part powerGridManager : LogicalPart;
        part miningYieldEnhancer : LogicalPart;
        part powerGenerator : LogicalPart;
        part energyStore : LogicalPart;
        part oreStore : LogicalPart;
        part targetLockManager[5] : LogicalPart;
        part navigationManager : LogicalPart;
        part communicationManager : LogicalPart;
        part droneStore : LogicalPart;

        //connectivity of logical application parts with logical interfacing parts
        

        //Logical infrastructure parts
        part powerGrid : LogicalPart;
        part computationNetwork : LogicalPart;

        //connectivity of logical infrastructure parts with logical interfacing parts

        //Exhibited or performed logical behavior of the Venture class
        exhibit logicalMiningFrigateStates {
            in shipCommandPort = podPort;
            in shipWarpBubbleEnd = warpBubbleEnd;
        }
    } 

    //Logical behavior inherited from the mining frigate definition
    state logicalMiningFrigateStates :> miningFrigateStates {
        in :>> shipCommandPort : LogicalPodPort;
        in :>> shipWarpBubbleEnd : Boolean;
        
        entry action :>> initial;
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
            accept boardShip : LogicalStationCommand via shipCommandPort
            then LogicalBoarded;
        
        transition logicalMiningFrigate_boarded_to_parked
            first LogicalBoarded
            accept unboardShip : LogicalStationCommand via shipCommandPort
            then LogicalParked;
        
        transition logicalMiningFrigate_boarded_to_inGrid
            first LogicalBoarded
            accept pilotPodUndockCommandSig : LogicalShipCommand via shipCommandPort
            do action logicalInitializeGridServicesMiningFrigate
            then LogicalInGrid;  		
            
        transition logicalMiningFrigate_inGrid_to_docked
            first LogicalInGrid
            accept pilotPodDockCommandSig : LogicalShipCommand via shipCommandPort
            then LogicalBoarded;
            
        transition logicalMiningFrigate_inGrid_to_onWarp
            first LogicalInGrid
            accept warpCommandSig : LogicalShipCommand via shipCommandPort
            then LogicalOnWarp;
    
        transition logicalMiningFrigate_onWarp_to_inGrid
            first LogicalOnWarp
            accept when shipWarpBubbleEnd
            then LogicalInGrid;  
    

        //Venture class Behavior redefines imperial spaceship behavior with manufacturer's technology 
        action :>> startUpSequence ::> logicalStartUpSequence;
        action :>> shutDownSequence;
        action :>> initializePowerGrid;
        action :>> initializeGenerator; 
        action :>> executeWarpDrive;
        action :>> initializeScanSpaceServices {
            in scanSpaceServicesCommandPort : shipCommandPort;

            action :>> powerUpSensorSystem;
            action :>> scanGrid {
                action :>> cycleScanner {out scanReport : String;}
            }
            action :>> directionalScan {
                action :>> scanSpace {out scanReport : String;}
            }

        }
        action :>> initializeNavigationServices {
            in scanSpaceServicesCommandPort : shipCommandPort;

            action :>> powerUpNavigationSystem;
            action :>> approachSignatureAtRange;
            action :>> orbitSignatureAtRange;
            action :>> keepAtRangeSignature;
            action :>> dockInStation;
        }
        action :>> initializeExtensionModule {
            in moduleServicesCommandPort : shipCommandPort;
            in module : LogicalImperialStandardModule;

            action :>> configureModule {
                in module : LogicalImperialStandardModule; 
                out commandModule : LogicalShipCommand;
                out reportModule : LogicalShipReport;
            }
            action :>> powerUpModule;
            action :>> diagnoseModule;
            action :>> enableModuleServices;
        }
        action :>> undockFromStation;
        action :>> initializeDroneServices;
        action :>> transferOre;
    }       
   
}

