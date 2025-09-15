package LogicalMiningFrigate {
    
    private import MiningFrigateBlackBoxSpecification::MiningFrigateVentureClassPackage::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import COTS;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    package LogicalStructure {
        doc /*
            * The logical mining frigate inherit all the features of the mining frigate
            * and will define the logical system elements that will perform the defined
            * system behavior. logical system elements will be defined of three types: 
            * interfacing systems, aplication systems, and support systems.  
            */
        private import LogicalBehavior::*;

        //Logical Mining Frigate
        part def LogicalMiningFrigateVentureClass :> MiningFrigateVentureClass {
            
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
            port highPowerSlot1Port :>> highPowerSlot1;
            port highPowerSlot2Port :>> highPowerSlot2;
            port highPowerSlot3Port  :>> highPowerSlot3;
            port midPowerSlot1Port  :>> midPowerSlot1;
            port midPowerSlot2Port  :>> midPowerSlot2;
            port midPowerSlot3Port  :>> midPowerSlot3;
            port lowPowerSlot1Port :>> lowPowerSlot1;
            //Rig extension points of the mining frigate redefine the imperial ship definition
            port rigPort1Port :>> rigPort1;
            port rigPort2Port :>> rigPort2;
            port rigPort3Port :>> rigPort3;
            //Other ports redefine the imperial ship definition or add to the specific ship
            port podPort :>> podPort;
            port dockingPort :>> dockingPort;
            port droneControlPort :>> droneControlPort[2];
            port longRangeGravimetricDirectionalSensorPort :>> longRangeGravimetricDirectionalSensorPort;
            port gridGravimetricSensorPort :>> gridGravimetricSensorPort;
            port shipCommsPort  :>> shipCommsPort;
            port zPropulsionPort :>> zPropulsionPort[4];
            port xPropulsionPort :>> xPropulsionPort[2];
            port yPropulsionPort :>> yPropulsionPort[2];
            //part oreScooper;

            //Ship resilience ports
            port warpShieldPort :>> warpShieldPort {
                attribute warpShielding :>> warpShielding;
            }
            port shieldMitigationPort :>> shieldMitigationPort;
            port armourMitigationPort :>> armourMitigationPort;
            port structureMitigationPort :>> structureMitigationPort;

            
            //Logical interfacing parts. 
            //For each port we will have a part that handle it. 
            part highPowerSlotManager1 : LogicalPart {
                port highPowerSlotManagerPort :> highPowerSlot1Port;
                port controlNetworkCommandPort :>> commandControlGallente;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in moduleServicesCommandPort = controlNetworkCommandPort;
                }
            }
            part highPowerSlotManager2 : LogicalPart {
                port highPowerSlotManagerPort : highPowerSlot2Port;
                port controlNetworkCommandPort :>> commandControlGallente;
            }
            part highPowerSlotManager3 : LogicalPart {
                port highPowerSlotManagerPort : highPowerSlot3Port;
                port controlNetworkCommandPort :>> commandControlGallente;
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
                port lowPowerSlotManagerPort : lowPowerSlot1Port;
            }

            part rigCoupler1 : LogicalPart {
                port rigCouplingPort :> rigPort1Port;
            }
            part rigCoupler2 : LogicalPart {
                port rigCouplingPort :> rigPort2Port;
            }
            part rigCoupler3 : LogicalPart {
                port rigCouplingPort :> rigPort3Port;
            }

            part podManager : LogicalPart {
                doc /*
                    * Receive podCommand items and send shipControl items
                    * Set between the podPort and the ShipController.
                */
                port podManagerPort :> podPort;
                port shipControllerCommandPort :>> commandControlGallente : LogicalShipControlPort;

                perform logicalMiningFrigateStates.logicalManageShipCommand;
            }
            part dockingManager : LogicalPart {
                port dockingManagerPort :> dockingPort;
            }
            part droneControlManager : LogicalPart {
                port droneControlManagerPort :> droneControlPort[2];
            }
            part longRangeDirectionalSensor : LogicalPart {
                port longRangeDirectionalSensorPort :> longRangeDirectionalSensorPort;
                port controlNetworkCommandPort :>> commandControlGallente;

                perform logicalMiningFrigateStates.logicalInitializeScanSpaceServices.logicalPowerUpDirectionalSensorSystem;
                perform logicalMiningFrigateStates.logicalInitializeScanSpaceServices.logicalDirectionalScan;
            }
            part gridSensor : LogicalPart {
                port gridSensorAntenna :> gridSensorPort;
                port controlNetworkCommandPort :>> commandControlGallente;

                perform logicalMiningFrigateStates.logicalInitializeScanSpaceServices.logicalPowerUpGridSensorSystem;
                perform logicalMiningFrigateStates.logicalInitializeScanSpaceServices.logicalScanGrid;
            }
            part shipCommsManager : LogicalPart {
                port shipCommsPort :> shipCommsPort;
            } 
            part mainPropulsor : LogicalPart {
                port mainPropulsionNozzle :> xPropulsionPort [4];
            }
            part yAxisRotator : LogicalPart {
                port directionalPropulsorNozzle :> yPropulsionPort[2];
            }
            part zAxisRotator : LogicalPart {
                port directionalPropulsorNozzle :> zPropulsionPort[2];
            }

            part warpGenerator : LogicalPart {
                port warpShieldPort :> LogicalMiningFrigateVentureClass::warpShieldPort; //Naming disambiguation
            }
            part shieldGenerator : LogicalPart {
                port shieldProjectorPort :> shieldMitigationPort;
            }
            part armourManager : LogicalPart {
                port armourPlatePort :> armourMitigationPort;
            }
            part structureManager : LogicalPart {
                port structureEnclosurePort :> structureMitigationPort;
            }

            //Binding interfacing logical parts to the logical ports
            bind highPowerSlotManager1.highPowerSlotManagerPort = highPowerSlot1Port;
            bind highPowerSlotManager2.highPowerSlotManagerPort = highPowerSlot2Port;
            bind highPowerSlotManager3.highPowerSlotManagerPort = highPowerSlot3Port;
            bind midPowerSlotManager1.midPowerSlotManagerPort = midPowerSlot1Port;
            bind midPowerSlotManager2.midPowerSlotManagerPort = midPowerSlot2Port;
            bind midPowerSlotManager3.midPowerSlotManagerPort = midPowerSlot3Port;
            bind lowPowerSlotManager1.lowPowerSlotManagerPort = lowPowerSlot1Port;
            bind rigCoupler1.rigCouplingPort = rigPort1Port;
            bind rigCoupler2.rigCouplingPort = rigPort2Port;
            bind rigCoupler3.rigCouplingPort = rigPort3Port;
            bind podManager.podManagerPort = podPort;
            bind dockingManager.dockingManagerPort = dockingPort;
            bind droneControlManager.droneControlManagerPort = droneControlPort;
            bind longRangeDirectionalSensor.longRangeDirectionalSensorPort = longRangeDirectionalSensorPort;
            bind gridSensor.gridSensorAntenna = gridSensorPort;
            bind shipCommsManager.shipCommsPort = shipCommsPort;
            bind mainPropulsor.mainPropulsionNozzle = zPropulsionPort;
            bind zAxisRotator.directionalPropulsorNozzle = xPropulsionPort;
            bind yAxisRotator.directionalPropulsorNozzle = yPropulsionPort;
            bind warpGenerator.warpShieldPort = warpShieldPort;
            bind shieldGenerator.shieldProjectorPort = shieldMitigationPort;
            bind armourManager.armourPlatePort = armourMitigationPort;
            bind structureManager.structureEnclosurePort = structureMitigationPort;

            
            //Logical application parts
            part shipController : LogicalPart {
                doc /*
                * Central controller of the ship that executes the state machine and
                * controlls the parts of the ship.
                * Directly connected to the podManager.
                */
                port controlNetworkCommandPort :>> commandControlGallente;
                port podManagerCommandPort :>> commandControlGallente;

                exhibit logicalMiningFrigateStates {
                    in commandControlGallente = commandControlGallente;
                    in shipWarpBubbleEnd = warpBubbleEnd;
                }
            }
            part powerGridManager : LogicalPart {
                port controlNetworkCommandPort :>> commandControlGallente;

                perform logicalMiningFrigateStates.logicalInitializePowerGrid;
            }
            part miningYieldEnhancer : LogicalPart;

            part powerGenerator : LogicalPart {
                port controlNetworkCommandPort :>> commandControlGallente;

                perform logicalMiningFrigateStates.logicalInitializeGenerator;
            }
            part energyStore : LogicalPart;

            part oreStore : LogicalPart;

            part targetLockManager[5] : LogicalPart;

            part navigationManager : LogicalPart {
                doc /*
                    * Executes navigation commands received from the controller
                */
                port controlNetworkCommandPort :>> commandControlGallente;

                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalPowerUpNavigationSystem;
                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalApproachSignatureAtRange;
                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalOrbitSignatureAtRange;
                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalKeepAtRangeSignature;
                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalDockInStation;
            }

            part communicationManager : LogicalPart;

            part droneStore : LogicalPart;

            //connectivity of logical application parts with logical interfacing parts
            interface : LogicalControlIF connect
                supplierPort ::> podManager.podManagerPort to
                consumerPort ::> shipController.podManagerCommandPort;


            //Logical infrastructure parts
            //Infrastructure Components:  manage internal resources such as time, memory, processing, 
            //internally generated heat, and interconnection infrastructure such as wiring and plumbing.
            //The internal resources are derived from the design and are not necessarily derivable 
            //from the external environment.
            //(S. Friedenthal et al.)
            part powerGrid : LogicalPart;
            part controlNetwork : LogicalPart {
                doc /*
                    * Routes all shipCommand items betweent he ship parts.  
                */
                port powerGridManagerCommandPort :>> commandControlGallente;
                port powerGeneratorCommandPort :>> commandControlGallente;
                port gridSensorCommandPort :>> commandControlGallente;
                port longRangeDirectionalSensorCommandPort :>> commandControlGallente;
                port navigationManagerCommandPort :>> commandControlGallente;
                port highPowerSlotManager1CommandPort :>> commandControlGallente;
                port highPowerSlotManager2CommandPort :>> commandControlGallente;
                port highPowerSlotManager3CommandPort :>> commandControlGallente;

            }
            part computationNetwork : LogicalPart;

            //connectivity of logical infrastructure parts with logical interfacing parts

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.gridSensorCommandPort to
                consumerPort ::> gridSensor.controlNetworkCommandPort; 

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.longRangeDirectionalSensorCommandPort to
                consumerPort ::> longRangeDirectionalSensor.controlNetworkCommandPort; 

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.powerGridManagerCommandPort to
                consumerPort ::> powerGridManager.controlNetworkCommandPort; 

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.powerGeneratorCommandPort to
                consumerPort ::> powerGenerator.controlNetworkCommandPort; 

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.navigationManagerCommandPort to
                consumerPort ::> navigationManager.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.highPowerSlotManager1CommandPort to
                consumerPort ::> highPowerSlotManager1.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.highPowerSlotManager2CommandPort to
                consumerPort ::> highPowerSlotManager2.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.highPowerSlotManager3CommandPort to
                consumerPort ::> highPowerSlotManager3.controlNetworkCommandPort;
        }
    }

    package LogicalBehavior {
        //Logical behavior inherited from the mining frigate definition
        
        state logicalMiningFrigateStates :> miningFrigateStates {
            in shipControllerCommandPort : ~LogicalShipControlPort :>> shipCommandPort;
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
            }        
            
            transition logicalMiningFrigate_parked_to_boarded
                first LogicalParked
                accept boardShip :>> boardShip via shipControllerCommandPort
                then LogicalBoarded;
            
            transition logicalMiningFrigate_boarded_to_parked
                first LogicalBoarded
                accept unboardShip :>> unboardShip via shipControllerCommandPort
                then LogicalParked;
            
            transition logicalMiningFrigate_boarded_to_inGrid
                first LogicalBoarded
                accept pilotPodUndockCommandSig :>> pilotPodUndockCommandSig via shipControllerCommandPort
                do action logicalStartUpSequence {in logicalGridServicesCommandPort = shipControllerCommandPort;}
                then LogicalInGrid;  		
                
            transition logicalMiningFrigate_inGrid_to_docked
                first LogicalInGrid
                accept pilotPodDockCommandSig :>> pilotPodDockCommandSig via shipControllerCommandPort
                then LogicalBoarded;
                
            transition logicalMiningFrigate_inGrid_to_onWarp
                first LogicalInGrid
                accept warpCommandSig :>> warpCommandSig via shipControllerCommandPort
                then LogicalOnWarp;
        
            transition logicalMiningFrigate_onWarp_to_inGrid
                first LogicalOnWarp
                accept when shipWarpBubbleEnd
                then LogicalInGrid;  

        //Venture class Behavior redefines imperial spaceship behavior with manufacturer's technology 
            action logicalStartUpSequence :>> startUpSequence {
                in logicalGridServicesCommandPort :>> shipServicesCommandPort;
                
                first start;
                then logicalInitializePowerGrid;
                then logicalInitializeGenerator;
                then logicalInitializeScanSpaceServices {in logicalScanSpaceServicesCommandPort = logicalGridServicesCommandPort;}
                then logicalInitializeNavigationServices {in logicalNavigationServicesCommandPort = logicalGridServicesCommandPort;}
            }
            action logicalShutDownSequence :>> shutDownSequence;
            action logicalInitializePowerGrid :>> initializePowerGrid;
            action logicalInitializeGenerator :>> initializeGenerator; 
            action logicalInitializeScanSpaceServices :>> initializeScanSpaceServices {
                in scanSpaceServicesCommandPort :>> scanSpaceServicesCommandPort;

                first start;
                then action logicalPowerUpGridSensorSystem :>> powerUpSensorSystem;
                then action logicalPowerUpDirectionalSensorSystem :>> powerUpSensorSystem;
                then fork;
                    then logicalScanGrid;
                    then logicalDirectionalScan;

                action logicalScanGrid :>> scanGrid {
                    accept after 1[s];
                    then action LogicalCycleScanner :>> cycleScanner {out scanReport : String;}
                    then send LogicalCycleScanner.scanReport via scanSpaceServicesCommandPort;
                    then terminate this;
                }
                action logicalDirectionalScan :>> directionalScan {
                    accept ScanForThreatsCommand : ShipCommand via scanSpaceServicesCommandPort;
                    then action logicalScanSpace :>> scanSpace {out scanReport : String;}
                    then send logicalScanSpace.scanReport via scanSpaceServicesCommandPort;
                    then terminate this;
                }
            }
            action logicalInitializeNavigationServices :>> initializeNavigationServices {
                in scanSpaceServicesCommandPort :>> scanSpaceServicesCommandPort;

                first start; 
                then action logicalPowerUpNavigationSystem :>> powerUpNavigationSystem;
                then fork;
                    then logicalApproachSignatureAtRange;
                    then logicalOrbitSignatureAtRange;
                    then logicalKeepAtRangeSignature;
                    then logicalDockInStation;
                    
                action logicalApproachSignatureAtRange :>> approachSignatureAtRange {
                    accept ApproachSignatureAtRangeCommand : ShipCommand via navigationServicesCommandPort;
                    //more actions come here
                    then action logicalreportStatusApproach :>> reportStatusApproach {out shipReport : String;}
                    then send logicalreportStatusApproach.shipReport via navigationServicesCommandPort;
                }
                action logicalOrbitSignatureAtRange :>> orbitSignatureAtRange;
                action logicalKeepAtRangeSignature :>> keepAtRangeSignature;
                action logicalDockInStation :>> dockInStation {
                    accept DockToStation : ShipCommand via navigationServicesCommandPort;
                    then action logicalrequestDockingClearance :>> requestDockingClearance {
                        in station : CelestialSignature; 
                        out ShipReport : String;
                    }
                    //more actions come here
                    then send logicalrequestDockingClearance.ShipReport via navigationServicesCommandPort;
                    then accept DockingRequestAccepted : ShipCommand;
                    //more actions come here
                    then action logicalreportRequestAccepted :>> reportRequestAccepted {out shipReport : String;}
                    then send logicalreportRequestAccepted.shipReport via navigationServicesCommandPort;
                }
            }
            action logicalInitializeExtensionModule :>> initializeExtensionModule {
                in moduleServicesCommandPort : LogicalShipControlPort :>> moduleServicesCommandPort;
                in module :>> module;

                first start; 
                then action logicalConfigureModule :>> configureModule {
                    in module : COTS::ImperialStandardModule; 
                    out commandModule :>> commandModule;
                    out reportModule :>> reportModule;
                }
                then action logicalPowerUpModule :>> powerUpModule;
                then action logicalDiagnoseModule :>> diagnoseModule;
                then action logicalEnableModuleServices :>> enableModuleServices;
                then accept logicalConfigureModule.commandModule;
                then perform action logicalModuleFunction :>> moduleFunction ::> logicalConfigureModule.module.imperialStandardModuleAction;
                then accept logicalConfigureModule.reportModule;
                then action logicalReportStatusModule :>> reportStatusModule {out shipReport : ShipReport;}
                then send logicalReportStatusModule.shipReport via moduleServicesCommandPort;
            }
            action logicalInitializeExtensionRig :>> initializeExtensionRig {
                in :>> shipRig;

                first start;
                    then action logicalConfigureRig :>> configureRig {
                        in :>> shipRig; 
                    } //technology dependent actions will be added by the developers here.
                    then action logicalPowerUpRig :>> powerUpRig; //technology dependent actions will be added by the developers here.
                    then action logicalDiagnoseRig :>> diagnoseRig; //technology dependent actions will be added by the developers here.
                    then action logicalEnableRig :>> enableRig;
            }

            action logicalUndockFromStation :>> undockFromStation;
            action logicalInitializeDroneServices :>> initializeDroneServices;
            action logicalTransferOre :>> transferOre;
            action logicalexecuteWarpDrive :>> executeWarpDrive {
                in logicalWarpCommandPort :>> warpCommandPort;
                in warpBubbleEnd : CelestialSignature;
                in atRange : Real;

                first start; 
                then accept ExecuteWarpDriveCommand : ShipCommand via logicalWarpCommandPort;
                then action :>> reportStatusWarpDrive {out shipReport : ShipReport;}
                then send reportStatusWarpDrive.shipReport via logicalWarpCommandPort; 
                then action :>> reportStatusDestination {out shipReport : String;}
                then send reportStatusDestination.shipReport via logicalWarpCommandPort;
            }
            action logicalManageShipCommand {
                doc /*
                * Verify shipCommand from the podPilot and translate to shipControl items.
                */
            }
        }
    }      
}