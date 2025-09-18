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
            attribute warpBubbleEnd : CelestialSignature :>> warpBubbleEnd;  
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
            port tractorBeamPort :>> tractorBeamPort;
            port droneControlPort :>> droneControlPort[2];
            port longRangeGravimetricDirectionalSensorPort :>> longRangeGravimetricDirectionalSensorPort;
            port gridGravimetricSensorPort :>> gridGravimetricSensorPort;
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
            part highPowerSlotCoupling1 : LogicalPart {
                port highPowerSlotManagerPort : HighSlotPort;
                port controlNetworkCommandPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in moduleServicesCommandPort = controlNetworkCommandPort;
                    in module; //pending to define the module from the ship configurarion 
                }
            }
            part highPowerSlotCoupling2 : LogicalPart {
                port highPowerSlotManagerPort : HighSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in moduleServicesCommandPort = controlNetworkCommandPort;
                    in module; //pending to define the module from the ship configurarion 
                }
            }
            part highPowerSlotCoupling3 : LogicalPart {
                port highPowerSlotManagerPort : HighSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in moduleServicesCommandPort = controlNetworkCommandPort;
                    in module; //pending to define the module from the ship configurarion 
                }
            }
            part midPowerSlotCoupling1 : LogicalPart {
                port midPowerSlotManagerPort : MediumSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in moduleServicesCommandPort = controlNetworkCommandPort;
                    in module; //pending to define the module from the ship configurarion 
                }
            }
            part midPowerSlotCoupling2 : LogicalPart {
                port midPowerSlotManagerPort : MediumSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in moduleServicesCommandPort = controlNetworkCommandPort;
                    in module; //pending to define the module from the ship configurarion 
                }
            }
            part midPowerSlotCoupling3 : LogicalPart {
                port midPowerSlotManagerPort : MediumSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in moduleServicesCommandPort = controlNetworkCommandPort;
                    in module; //pending to define the module from the ship configurarion 
                }
            }
            part lowPowerSlotCoupling1 : LogicalPart {
                port lowPowerSlotManagerPort : LowSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in moduleServicesCommandPort = controlNetworkCommandPort;
                    in module; //pending to define the module from the ship configurarion 
                }
            }

            part rigCoupling1 : LogicalPart {
                port rigCouplingPort : RigPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in shipRig; //pending to define the rig from the ship configurarion
                }
            }
            part rigCoupling2 : LogicalPart {
                port rigCouplingPort : RigPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in shipRig; //pending to define the rig from the ship configurarion
                }
            }
            part rigCoupling3 : LogicalPart {
                port rigCouplingPort : RigPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                perform logicalMiningFrigateStates.logicalInitializeExtensionModule {
                    in shipRig; //pending to define the rig from the ship configurarion
                }
            }

            part podManager : LogicalPart {
                doc /*
                    * Receive asynchronously podCommand items and send shipControl items
                    * Set between the podPort and the ShipController.
                    */
                port podManagerPort :> podPort;
                port controlNetworkCommandPort :>> commandControlGallentePort : LogicalShipControlPort;

                perform logicalMiningFrigateStates.logicalInitializePodManagerServices.logicalManageShipCommand;
            }
            part dockingManager : LogicalPart {
                port dockingManagerPort :> dockingPort;
            }
            part droneControlManager : LogicalPart {
                port droneControlManagerPort :> droneControlPort[2];
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                perform logicalMiningFrigateStates.logicalInitializeDroneServices.manageDrones {
                    in droneCommand = controlNetworkCommandPort.shipControl;
                    out reportDrones = controlNetworkCommandPort.shipReport;
                }

            }
            part longRangeDirectionalSensor : LogicalPart {
                port longRangeDirectionalSensorPort :> longRangeGravimetricDirectionalSensorPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                perform logicalMiningFrigateStates.logicalInitializeScanSpaceServices.logicalPowerUpDirectionalSensorSystem;
                perform logicalMiningFrigateStates.logicalInitializeScanSpaceServices.logicalDirectionalScan;
            }
            part gridSensor : LogicalPart {
                port gridSensorPort :> gridGravimetricSensorPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                perform logicalMiningFrigateStates.logicalInitializeScanSpaceServices.logicalPowerUpGridSensorSystem;
                perform logicalMiningFrigateStates.logicalInitializeScanSpaceServices.logicalScanGrid;
            }
             
            part mainPropulsor : LogicalPart {
                port mainPropulsionNozzle :> xPropulsionPort [4];
                port navigationManagerAnalog : ~LogicalAnalogPort;
            }
            part yAxisRotator : LogicalPart {
                port directionalPropulsorNozzle :> yPropulsionPort[2];
                port navigationManagerAnalog : ~LogicalAnalogPort;
            }
            part zAxisRotator : LogicalPart {
                port directionalPropulsorNozzle :> zPropulsionPort[2];
                port navigationManagerAnalog : ~LogicalAnalogPort;
            }

            part warpGenerator : LogicalPart {
                port warpShieldPort :> LogicalMiningFrigateVentureClass::warpShieldPort; //Naming disambiguation
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

                perform action warpToBubbleEnd {in bubbleEnd : CelestialSignature = warpBubbleEnd;} 
            }
            part shieldGenerator : LogicalPart {
                port shieldProjectorPort :> shieldMitigationPort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            }
            part armourManager : LogicalPart {
                port armourPlatePort :> armourMitigationPort;
            }
            part structureManager : LogicalPart {
                port structureEnclosurePort :> structureMitigationPort;
            }

            //Binding interfacing logical parts to the logical ports
            bind highPowerSlotCoupling1.highPowerSlotManagerPort = highPowerSlot1Port;
            bind highPowerSlotCoupling2.highPowerSlotManagerPort = highPowerSlot2Port;
            bind highPowerSlotCoupling3.highPowerSlotManagerPort = highPowerSlot3Port;
            bind midPowerSlotCoupling1.midPowerSlotManagerPort = midPowerSlot1Port;
            bind midPowerSlotCoupling2.midPowerSlotManagerPort = midPowerSlot2Port;
            bind midPowerSlotCoupling3.midPowerSlotManagerPort = midPowerSlot3Port;
            bind lowPowerSlotCoupling1.lowPowerSlotManagerPort = lowPowerSlot1Port;
            bind rigCoupling1.rigCouplingPort = rigPort1Port;
            bind rigCoupling2.rigCouplingPort = rigPort2Port;
            bind rigCoupling3.rigCouplingPort = rigPort3Port;
            bind podManager.podManagerPort = podPort;
            bind dockingManager.dockingManagerPort = dockingPort;
            bind droneControlManager.droneControlManagerPort = droneControlPort;
            bind longRangeDirectionalSensor.longRangeDirectionalSensorPort = longRangeGravimetricDirectionalSensorPort;
            bind gridSensor.gridSensorPort = gridGravimetricSensorPort;
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
                port controlNetworkCommandPort :>> commandControlGallentePort;
                port podManagerCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                exhibit logicalMiningFrigateStates {
                    in commandControlGallente = commandControlGallente;
                    in shipWarpBubbleEnd = warpBubbleEnd;
                }
            }
            part miningYieldEnhancer : LogicalPart;

            part powerGenerator : LogicalPart {
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerSourceGeneratorPort : LogicalPowerGridPort :>> powerGridPort;
                port powerGridPort : ~LogicalPowerGridPort :>> powerGridPort;

                perform logicalMiningFrigateStates.logicalInitializeGenerator.monitorGenerator;
                action generateEnergy {out energy : NaturalEnvironment::Energy = powerSourceGeneratorPort.powerGridEnergy;}
            }
            part energyStore : LogicalPart {
                doc /*
                    * Stores energy from the generator and stabilizes power supply in the powerGrid
                    */
                attribute maxStoredPower = suppliedCapacitor;
                port powerGridSupplyPort :>> powerGridPort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
                port powerSourceStorePort : ~LogicalPowerGridPort :>> powerGridPort;
                
                ref item storedEnergy : NaturalEnvironment::Energy; // Energy in [GJ]

                perform logicalMiningFrigateStates.logicalInitializePowerGrid.monitorEnergyStore;
                action provideEnergy {out energy : NaturalEnvironment::Energy = powerGridPort.powerGridEnergy;}
                action storeEnergy {in energy : NaturalEnvironment::Energy = powerSourceStorePort.powerGridEnergy;}
            }

            part oreStore : LogicalPart{
                doc /*
                    * Stores Ore in transport containers (cans)
                    */
            }

            part targetLockManager : LogicalPart {
                doc /*
                    * Locks and tracks targets
                    */
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port highPowerSlot1Targeting : LogicalAnalogPort;
                port highPowerSlot2Targeting : LogicalAnalogPort;
                port highPowerSlot3Targeting : LogicalAnalogPort;

                part targetLockComputer1;

            }

            part navigationManager : LogicalPart {
                doc /*
                    * Executes navigation commands received from the controller
                    */
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port mainPropulsorAnalog : LogicalAnalogPort;
                port zdirectionalPropulsorAnalog : LogicalAnalogPort;
                port ydirectionalPropulsorAnalog : LogicalAnalogPort;

                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalPowerUpNavigationSystem;
                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalApproachSignatureAtRange;
                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalOrbitSignatureAtRange;
                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalKeepAtRangeSignature;
                perform logicalMiningFrigateStates.logicalInitializeNavigationServices.logicalDockInStation;
            }

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

            part configurationManager {
                doc /*
                    * Maintains the configuration of the ship
                    */
                
                attribute highPowerSlot1 : COTS::ImperialStandardModule;
                attribute highPowerSlot2 : COTS::ImperialStandardModule;
                attribute highPowerSlot3 : COTS::ImperialStandardModule;
                attribute midPowerSlot1 : COTS::ImperialStandardModule;
                attribute midPowerSlot2 : COTS::ImperialStandardModule;
                attribute midPowerSlot3 : COTS::ImperialStandardModule;
                attribute lowPowerSlot1 : COTS::ImperialStandardModule;
            }
            
            part powerGrid : LogicalPart {
                doc /*
                    * Routes power to the expansion modules.
                    */
                
                port energyStoreSupplyPort : ~LogicalPowerGridPort :>> powerGridPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGeneratorPowerGridPort :>> powerGridPort;
                port energyStoreGridPort :>> powerGridPort;
                port highPowerSlotCoupling1GridPort :>> powerGridPort;
                port highPowerSlotCoupling2GridPort :>> powerGridPort;
                port highPowerSlotCoupling3GridPort :>> powerGridPort;
                port midPowerSlotCoupling1GridPort :>> powerGridPort;
                port midPowerSlotCoupling2GridPort :>> powerGridPort;
                port midPowerSlotCoupling3GridPort :>> powerGridPort;
                port warpGeneratorGridPort :>> powerGridPort;
                port shieldGeneratorGridPort :>> powerGridPort;


                perform logicalMiningFrigateStates.logicalInitializePowerGrid.monitorPowerInGrid; 
            }
            part controlNetwork : LogicalPart {
                doc /*
                    * Routes all shipCommand items between the ship parts.  
                    */
                port shipControllerCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridManagerCommandPort :>> commandControlGallentePort;
                port powerGeneratorCommandPort :>> commandControlGallentePort;
                port gridSensorCommandPort :>> commandControlGallentePort;
                port longRangeDirectionalSensorCommandPort :>> commandControlGallentePort;
                port navigationManagerCommandPort :>> commandControlGallentePort;
                port highPowerSlotManager1CommandPort :>> commandControlGallentePort;
                port highPowerSlotManager2CommandPort :>> commandControlGallentePort;
                port highPowerSlotManager3CommandPort :>> commandControlGallentePort;
                port midPowerSlotManager1CommandPort :>> commandControlGallentePort;
                port midPowerSlotManager2CommandPort :>> commandControlGallentePort;
                port midPowerSlotManager3CommandPort :>> commandControlGallentePort;
                port lowPowerSlotManager1CommandPort :>> commandControlGallentePort;
                port rigCoupler1CommandPort :>> commandControlGallentePort;
                port rigCoupler2CommandPort :>> commandControlGallentePort;
                port rigCoupler3CommandPort :>> commandControlGallentePort;
                port droneManagerCommandPort :>> commandControlGallentePort;
                port podManagerCommandPort :>> commandControlGallentePort;
                port warpGeneratorCommandPort :>> commandControlGallentePort;

                action routeCommandTraffic; 
            }
            part computationNetwork : LogicalPart {
                doc /*
                    * Provides ship central CPU computation resources to modules.  
                    */

                action monitorUsageCPU;
            }

            //connectivity of logical infrastructure parts with logical interfacing parts
            //control connectors
            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.gridSensorCommandPort to
                consumerPort ::> gridSensor.controlNetworkCommandPort; 

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.longRangeDirectionalSensorCommandPort to
                consumerPort ::> longRangeDirectionalSensor.controlNetworkCommandPort; 

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.powerGridManagerCommandPort to
                consumerPort ::> powerGrid.controlNetworkCommandPort; 

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.powerGeneratorCommandPort to
                consumerPort ::> powerGenerator.controlNetworkCommandPort; 

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.navigationManagerCommandPort to
                consumerPort ::> navigationManager.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.highPowerSlotManager1CommandPort to
                consumerPort ::> highPowerSlotCoupling1.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.highPowerSlotManager2CommandPort to
                consumerPort ::> highPowerSlotCoupling2.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.highPowerSlotManager3CommandPort to
                consumerPort ::> highPowerSlotCoupling3.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.midPowerSlotManager1CommandPort to
                consumerPort ::> midPowerSlotCoupling1.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.midPowerSlotManager2CommandPort to
                consumerPort ::> midPowerSlotCoupling2.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.midPowerSlotManager3CommandPort to
                consumerPort ::> midPowerSlotCoupling3.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.lowPowerSlotManager1CommandPort to
                consumerPort ::> lowPowerSlotCoupling1.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.rigCoupler1CommandPort to
                consumerPort ::> rigCoupling1.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.rigCoupler2CommandPort to
                consumerPort ::> rigCoupling2.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.rigCoupler3CommandPort to
                consumerPort ::> rigCoupling3.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.droneManagerCommandPort to
                consumerPort ::> droneControlManager.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.podManagerCommandPort to
                consumerPort ::> podManager.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.warpGeneratorCommandPort to
                consumerPort ::> warpGenerator.controlNetworkCommandPort;

            //power connectors
            //power generator to powerSupply to powerGrid triangle
            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.powerGeneratorPowerGridPort to
                consumerPort ::> powerGenerator.powerGridPort;

            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGenerator.powerSourceGeneratorPort to
                consumerPort ::> energyStore.powerSourceStorePort;

            interface : LogicalPowerGridIF connect
                supplierPort ::> energyStore.powerGridSupplyPort to
                consumerPort ::> powerGrid.energyStoreSupplyPort;

            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.energyStoreGridPort to
                consumerPort ::> energyStore.powerGridPort;

            //power connectors
            //powerGrid to modules
            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.highPowerSlotCoupling1GridPort to
                consumerPort ::> highPowerSlotCoupling1.powerGridPort;
            
            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.highPowerSlotCoupling2GridPort to
                consumerPort ::> highPowerSlotCoupling2.powerGridPort;

            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.highPowerSlotCoupling3GridPort to
                consumerPort ::> highPowerSlotCoupling3.powerGridPort;

            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.midPowerSlotCoupling1GridPort to
                consumerPort ::> midPowerSlotCoupling1.powerGridPort;

            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.midPowerSlotCoupling2GridPort to
                consumerPort ::> midPowerSlotCoupling2.powerGridPort;

            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.midPowerSlotCoupling3GridPort to
                consumerPort ::> midPowerSlotCoupling3.powerGridPort;

            //power connectors
            //powerGrid to Ship subsystems that consume from powerGrid
            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.warpGeneratorGridPort to
                consumerPort ::> warpGenerator.powerGridPort;

            interface : LogicalPowerGridIF connect
                supplierPort ::> powerGrid.shieldGeneratorGridPort to
                consumerPort ::> shieldGenerator.powerGridPort;

            //analog connectors
            //NavigationManager to Pripulsion units
            interface : LogicalAnalogSignalIF connect
                supplierPort ::> navigationManager.mainPropulsorAnalog to
                consumerPort ::> mainPropulsor.navigationManagerAnalog;

            interface : LogicalAnalogSignalIF connect
                supplierPort ::> navigationManager.ydirectionalPropulsorAnalog to
                consumerPort ::> yAxisRotator.navigationManagerAnalog;

            interface : LogicalAnalogSignalIF connect
                supplierPort ::> navigationManager.zdirectionalPropulsorAnalog to
                consumerPort ::> zAxisRotator.navigationManagerAnalog;
        }
    }

    package LogicalBehavior {
        //Logical behavior inherited from the mining frigate definition
        
        state logicalMiningFrigateStates :> miningFrigateStates {
            doc /*
                * 
                */
            in shipControllerCommandPort : ~LogicalShipControlPort :>> shipCommandPort;
            in :>> shipWarpBubbleEnd;
            
            entry action :>> initial;
            then state LogicalParked :>> Parked {
                doc /* The mining frigate is parked inside a station and can be boarded. */
            } 	
            state LogicalBoarded :>> Boarded {
                doc /* The mining frigate is boarded inside a station in the docking pad, available for refitting, resupply, or cargo transfer. */
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

        //Venture class Behavior redefines imperial spaceship behavior 
        //(being a contsraint for any spaceship) with manufacturer's technology 
            action logicalStartUpSequence {
                doc /*
                    * Initialize the serivces of the ship for using by the pilot 
                    */
                in logicalGridServicesCommandPort : LogicalShipControlPort;
                
                first start;
                then logicalInitializePowerGrid;
                then logicalInitializeGenerator;
                then logicalInitializePodManagerServices;
                then logicalInitializeScanSpaceServices {in logicalScanSpaceServicesCommandPort = logicalGridServicesCommandPort;}
                then logicalInitializeNavigationServices {in logicalNavigationServicesCommandPort = logicalGridServicesCommandPort;}
                then logicalInitializeDroneServices;
                then logicalInitializeExtensionModule {in moduleServicesCommandPort = logicalGridServicesCommandPort;}

            }
            action logicalShutDownSequence;
            action logicalInitializePowerGrid {
                doc /*
                    * Relays power from the energyStore to the modules 
                    */
                
                first start;
                then action logicalPowerUpPowerGrid;
                then fork;
                    then monitorPowerInGrid;
                    then monitorEnergyStore;
                
                action monitorPowerInGrid;
                action monitorEnergyStore;
                
            }
            action logicalInitializeGenerator {
                doc /*
                    * Provides power to the energyStore 
                    */
                
                first start;
                then action logicalPowerUpGenerator;
                then perform action monitorGenerator;
            }
            action logicalInitializePodManagerServices {

                first start;
                then action logicalPowerUpPodManager;
                then perform action logicalManageShipCommand {
                    doc /*
                    * Relays commands from the pilotPod to the shipController, 
                    * collect reports and relay them to the pilotPod 
                    */
                }
            }
            action logicalInitializeScanSpaceServices {
                doc /*
                    * Enable scanners and start autoscan in grid
                    */
                in scanSpaceServicesCommandPort : LogicalShipControlPort;

                first start;
                then action logicalPowerUpGridSensorSystem;
                then action logicalPowerUpDirectionalSensorSystem;
                then fork;
                    then logicalScanGrid;
                    then logicalDirectionalScan;

                action logicalScanGrid {
                    accept after 1[s];
                    then action LogicalCycleScanner {out scanReport : String;}
                    then send LogicalCycleScanner.scanReport via scanSpaceServicesCommandPort;
                    then terminate this;
                }
                action logicalDirectionalScan {
                    accept ScanForThreatsCommand : ShipCommand via scanSpaceServicesCommandPort;
                    then action logicalScanSpace {out scanReport : String;}
                    then send logicalScanSpace.scanReport via scanSpaceServicesCommandPort;
                    then terminate this;
                }
            }
            action logicalInitializeNavigationServices  {
                doc /*
                    * Enable navigation commands
                    */
                in navigationServicesCommandPort : LogicalShipControlPort;

                first start; 
                then action logicalPowerUpNavigationSystem;
                then fork;
                    then logicalApproachSignatureAtRange;
                    then logicalOrbitSignatureAtRange;
                    then logicalKeepAtRangeSignature;
                    then logicalDockInStation;
                    then logicalexecuteWarpDrive;
                    
                action logicalApproachSignatureAtRange {
                    accept ApproachSignatureAtRangeCommand : ShipCommand via navigationServicesCommandPort;
                    //more actions come here
                    then action logicalreportStatusApproach {out shipReport : String;}
                    then send logicalreportStatusApproach.shipReport via navigationServicesCommandPort;
                }
                action logicalOrbitSignatureAtRange ;
                action logicalKeepAtRangeSignature ;
                action logicalDockInStation {
                    doc /*
                        * Navigates to docking radius of the given station
                        */
                    accept DockToStation : ShipCommand via navigationServicesCommandPort;
                    then action logicalrequestDockingClearance {
                        in station : CelestialSignature; 
                        out ShipReport : String;
                    }
                    //more actions come here
                    then send logicalrequestDockingClearance.ShipReport via navigationServicesCommandPort;
                    then accept DockingRequestAccepted : ShipCommand;
                    //more actions come here
                    then action logicalreportRequestAccepted {out shipReport : String;}
                    then send logicalreportRequestAccepted.shipReport via navigationServicesCommandPort;
                }
                action logicalexecuteWarpDrive  {
                    doc /*
                        * Executes the navigation maneuvres to initiate warp and activates the warp generator
                        */
                    in logicalWarpCommandPort : LogicalShipControlPort;
                    in warpBubbleEnd : CelestialSignature;

                    accept ExecuteWarpDriveCommand : ShipCommand via logicalWarpCommandPort;
                    then action reportStatusWarpDrive {out shipReport : ShipReport;}
                    then send reportStatusWarpDrive.shipReport via logicalWarpCommandPort;
                    then perform action warpToBubbleEnd {in bubbleEnd : CelestialSignature = warpBubbleEnd;} 
                    then action reportStatusDestination {out shipReport : String;}
                    then send reportStatusDestination.shipReport via logicalWarpCommandPort;
                }
            }
            action logicalInitializeExtensionModules {
                doc /*
                    * Initializes the modules configures in the ship.
                    */
                in modulesServicesCommandPort : LogicalShipControlPort;
                first start;
                then fork;
                    then logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot1;
                    }
                    then logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot2;
                    }
                    then logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot3;
                    }
                    then logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot1;
                    }
                    then logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot2;
                    }
                    then logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot3;
                    }
                    then logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::lowPowerSlot1;
                    }

            }    
            action logicalInitializeExtensionModule {
                doc /*
                    * Initialize the extension modules of the ship as per the ship configuration
                    */
                in moduleServicesCommandPort : LogicalShipControlPort;
                in module : COTS::ImperialStandardModule;

                first start; 
                then action logicalPowerUpModule {
                    out poweredUp : Boolean;
                }
                then decide;
                    if logicalPowerUpModule.poweredUp then logicalDiagnoseModule;
                    else stop;
                action stop terminate;
                then action logicalDiagnoseModule;
                then action logicalEnableModuleServices {
                    in module : COTS::ImperialStandardModule; 
                    out commandModule : ModuleCommand;
                }
                then accept logicalEnableModuleServices.commandModule;
                then perform action logicalModuleFunction ::> logicalEnableModuleServices.module.imperialStandardModuleAction;
                then accept logicalModuleFunction.moduleReport;
                then action logicalReportStatusModule {
                    in moduleReport = logicalModuleFunction.moduleReport; 
                    out shipReport : ShipReport;
                }
                then send logicalReportStatusModule.shipReport via moduleServicesCommandPort;
            }

            action logicalInitializeDroneServices {
                doc /*
                    * Power up and enable drone services through calls to the dronesManager (perform action manageDrones...).
                    */
                in dronesControlManagerCommandPort : LogicalShipControlPort;
                first start;
                then action logicalPowerUpDronesControlManager;
                then accept pilotDroneCommand : LogicalControlCommand via dronesControlManagerCommandPort;
                then perform action manageDrones {
                    doc /*
                    * Relays commands to the drones, collect reports and relay them to the shipControl 
                    */
                    in droneCommand : LogicalControlCommand; 
                    out reportDrones : LogicalShipReport;
                }
                then send manageDrones.reportDrones via dronesControlManagerCommandPort;
            }
            
        }
    }      
}