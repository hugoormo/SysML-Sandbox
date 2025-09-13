package LogicalMiningFrigate {
    
    private import MiningFrigatePackage::*;
    private import ScalarValues::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;

    package LogicalStructure {
        private import LogicalBehavior::*;

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
            port highPowerSlot1 :>> highPowerSlot1;
            port highPowerSlot2 :>> highPowerSlot2;
            port highPowerSlot3  :>> highPowerSlot3;
            port midPowerSlot1  :>> midPowerSlot1;
            port midPowerSlot2  :>> midPowerSlot2;
            port midPowerSlot3  :>> midPowerSlot3;
            port lowPowerSlot1 :>> lowPowerSlot1;
            //Rig extension points of the mining frigate redefine the imperial ship definition
            port rigPort1 :>> rigPort1;
            port rigPort2 :>> rigPort2;
            port rigPort3 :>> rigPort3;
            //Other ports redefine the imperial ship definition or add to the specific ship
            port podPort :>> podPort;
            port dockingPort :>> dockingPort;
            port droneControlPort :>> droneControlPort[2];
            port longRangeDirectionalSensorPort :>> longRangeDirectionalSensorPort;
            port gridSensorPort :>> gridSensorPort;
            port shipCommsPort  :>> shipCommsPort;
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

            
            //Logical interfacing parts. Each port will have a part that handle it. 
            part highPowerSlotManager1 : LogicalPart {
                port highPowerSlotManagerPort :> highPowerSlot1;
            }
            part highPowerSlotManager2 : LogicalPart {
                port highPowerSlotManagerPort : highPowerSlot2;
            }
            part highPowerSlotManager3 : LogicalPart {
                port highPowerSlotManagerPort : highPowerSlot3;
            }
            part midPowerSlotManager1 : LogicalPart {
                port midPowerSlotManagerPort : midPowerSlotManager1;
            }
            part midPowerSlotManager2 : LogicalPart {
                port midPowerSlotManagerPort : midPowerSlotManager2;
            }
            part midPowerSlotManager3 : LogicalPart {
                port midPowerSlotManagerPort : midPowerSlotManager3;
            }
            part lowPowerSlotManager1 : LogicalPart {
                port lowPowerSlotManagerPort : lowPowerSlot1;
            }

            part rigCoupler1 : LogicalPart {
                port rigCouplingPort :> rigPort1;
            }
            part rigCoupler2 : LogicalPart {
                port rigCouplingPort :> rigPort2;
            }
            part rigCoupler3 : LogicalPart {
                port rigCouplingPort :> rigPort3;
            }

            part podManager : LogicalPart {
                port podManagerPort :>podPort;
            }
            part dockingManager : LogicalPart {
                port dockingManagerPort :> dockingPort;
            }
            part droneControlManager : LogicalPart {
                port droneControlManagerPort :> droneControlPort[2];
            }
            part longRangeDirectionalSensor : LogicalPart {
                port longRangeDirectionalSensorPort :> longRangeDirectionalSensorPort;
            }
            part gridSensor : LogicalPart {
                port gridSensorAntenna :> gridSensorPort;
            }
            part shipCommsManager : LogicalPart {
                port shipCommsPort :> shipCommsPort;
            } 
            part mainPropulsor : LogicalPart {
                port mainPropulsionNozzle :> xPropulsion [4];
            }
            part yAxisRotator : LogicalPart {
                port directionalPropulsorNozzle :> yPropulsion[2];
            }
            part zAxisRotator : LogicalPart {
                port directionalPropulsorNozzle :> zPropulsion[2];
            }

            part warpGenerator : LogicalPart {
                port warpShield :> warpShield;
            }
            part shieldGenerator : LogicalPart {
                port shieldProjector :> shieldMitigationPort;
            }
            part armourManager : LogicalPart {
                port armourPlate :> armourMitigationPort;
            }
            part structureManager : LogicalPart {
                port structureEnclosure :> structureMitigationPort;
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
            bind droneControlManager.droneControlManagerPort = droneControlPort;
            bind longRangeDirectionalSensor.longRangeDirectionalSensorPort = longRangeDirectionalSensorPort;
            bind gridSensor.gridSensorAntenna = gridSensorPort;
            bind shipCommsManager.shipCommsPort = shipCommsPort;
            bind mainPropulsor.mainPropulsionNozzle = zPropulsion;
            bind zAxisRotator.directionalPropulsorNozzle = xPropulsion;
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
    }

    package LogicalBehavior {
        //Logical behavior inherited from the mining frigate definition
        state logicalMiningFrigateStates :> miningFrigateStates {
            in :>> shipCommandPort;
            in :>> shipWarpBubbleEnd;
            
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
                accept boardShip :>> boardShip via shipCommandPort
                then LogicalBoarded;
            
            transition logicalMiningFrigate_boarded_to_parked
                first LogicalBoarded
                accept unboardShip :>> unboardShip via shipCommandPort
                then LogicalParked;
            
            transition logicalMiningFrigate_boarded_to_inGrid
                first LogicalBoarded
                accept pilotPodUndockCommandSig :>> pilotPodUndockCommandSig via shipCommandPort
                do action logicalInitializeGridServicesMiningFrigate
                then LogicalInGrid;  		
                
            transition logicalMiningFrigate_inGrid_to_docked
                first LogicalInGrid
                accept pilotPodDockCommandSig :>> pilotPodDockCommandSig via shipCommandPort
                then LogicalBoarded;
                
            transition logicalMiningFrigate_inGrid_to_onWarp
                first LogicalInGrid
                accept warpCommandSig :>> warpCommandSig via shipCommandPort
                then LogicalOnWarp;
        
            transition logicalMiningFrigate_onWarp_to_inGrid
                first LogicalOnWarp
                accept when shipWarpBubbleEnd
                then LogicalInGrid;  
        

        //Venture class Behavior redefines imperial spaceship behavior with manufacturer's technology 
            action logicalStartUpSequence :>> startUpSequence;
            action logicalShutDownSequence :>> shutDownSequence;
            action logicalInitializePowerGrid :>> initializePowerGrid;
            action logicalInitializeGenerator :>> initializeGenerator; 
            action logicalExecuteWarpDrive :>> executeWarpDrive;
            action logicalInitializeScanSpaceServices :>> initializeScanSpaceServices {
                in scanSpaceServicesCommandPort :>> scanSpaceServicesCommandPort;

                action logicalPowerUpSensorSystem :>> powerUpSensorSystem;
                action logicalScanGrid :>> scanGrid {
                    action LogicalCycleScanner :>> cycleScanner {out scanReport : String;}
                }
                action logicalDirectionalScan :>> directionalScan {
                    action LogicalScanSpace :>> scanSpace {out scanReport : String;}
                }

            }
            action logicalInitializeNavigationServices :>> initializeNavigationServices {
                in scanSpaceServicesCommandPort :>> scanSpaceServicesCommandPort;

                action logicalPowerUpNavigationSystem :>> powerUpNavigationSystem;
                action logicalApproachSignatureAtRange :>> approachSignatureAtRange;
                action logicalOrbitSignatureAtRange :>> orbitSignatureAtRange;
                action logicalKeepAtRangeSignature :>> keepAtRangeSignature;
                action logicalDockInStation :>> dockInStation;
            }
            action logicalInitializeExtensionModule :>> initializeExtensionModule {
                in moduleServicesCommandPort :>> moduleServicesCommandPort;
                in module :>> module;

                action logicalConfigureModule :>> configureModule {
                    in module : LogicalImperialStandardModule; 
                    out commandModule :>> commandModule;
                    out reportModule :>> reportModule;
                }
                action logicalPowerUpModule :>> powerUpModule;
                action logicalDiagnoseModule :>> diagnoseModule;
                action logicalEnableModuleServices :>> enableModuleServices;
            }
            action logicalUndockFromStation :>> undockFromStation;
            action logicalInitializeDroneServices :>> initializeDroneServices;
            action  logicalTransferOre :>> transferOre;
        }
    }      
}