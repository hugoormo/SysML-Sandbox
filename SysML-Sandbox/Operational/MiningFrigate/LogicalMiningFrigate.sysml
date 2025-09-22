package LogicalMiningFrigate {
    
    private import MiningFrigateBlackBoxSpecification::MiningFrigateVentureClassPackage::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import COTS;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardInteractionPoints::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    doc /*
        * The logical mining frigate inherit all the features of the mining frigate
        * and will define the logical system elements that will perform the defined
        * system behavior. logical system elements will be defined of three types: 
        * interfacing systems, aplication systems, and support systems.  
        */

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

        //Ship resilience ports
        port warpShieldPort :>> warpShieldPort {
            attribute warpShielding :>> warpShielding;
        }
        port shieldMitigationPort :>> shieldMitigationPort;
        port armourMitigationPort :>> armourMitigationPort;
        port structureMitigationPort :>> structureMitigationPort;

        
        //Logical interfacing parts. 
        //For each port we will have a part that handle it. 
        part highPowerTurretSlotCoupling1 : LogicalPart {
            port highPowerSlotManagerPort : HighSlotPort;
            port commandNetworkPort :>> commandControlGallentePort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            port tartetingLockComputerPort : ~LogicalAlignmentPort;
        }
        part highPowerTurretSlotCoupling2 : LogicalPart {
            port highPowerSlotManagerPort : HighSlotPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            port tartetingLockComputerPort : ~LogicalAlignmentPort;
        }
        part highPowerSlotCoupling3 : LogicalPart {
            port highPowerSlotManagerPort : HighSlotPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }
        part midPowerSlotCoupling1 : LogicalPart {
            port midPowerSlotManagerPort : MediumSlotPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }
        part midPowerSlotCoupling2 : LogicalPart {
            port midPowerSlotManagerPort : MediumSlotPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }
        part midPowerSlotCoupling3 : LogicalPart {
            port midPowerSlotManagerPort : MediumSlotPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }
        part lowPowerSlotCoupling1 : LogicalPart {
            port lowPowerSlotManagerPort : LowSlotPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }

        part rigCoupling1 : LogicalPart {
            port rigCouplingPort : RigPort;
        }
        part rigCoupling2 : LogicalPart {
            port rigCouplingPort : RigPort;
        }
        part rigCoupling3 : LogicalPart {
            port rigCouplingPort : RigPort;
        }

        part podManager : LogicalPart {
            doc /*
                * Receive asynchronously podCommand items and send shipControl items to shipController
                * Set between the podPort (physical items) and the ShipController (logical items).
                */
            attribute podDocked : Boolean;
            port podManagerPort :> podPort;
            port commandNetworkPort :>> commandControlGallentePort;

            action logicalInitializePodManagerServices {
                doc /*
                    * Decrypt incomming commands from the pod and relay to the commandNetwork
                    * Encrypt ship reports and relay to the pod
                    */
            }
        }
        part dockingManager : LogicalPart {

            attribute shipDockedStatus : Boolean;
            port dockingManagerPort :> dockingPort;
        }
        part droneControlManager : LogicalPart {
            port droneControlManagerPort :> droneControlPort[2];
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

            action logicalInitializeDroneServices {
                doc /*
                    * Power up and enable drone services
                    * Engage drone defenses if commanded
                    * Other drone actions may be added
                    */
                in dronesControlManagerCommandPort : LogicalShipCommandPort;
            }

        }
        part longRangeDirectionalSensor : LogicalPart {
            port longRangeDirectionalSensorPort :> longRangeGravimetricDirectionalSensorPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

            action logicalInitializeLongRangeScanServices {
                doc /*
                    * Enable long range scanner
                    * Autoactivate grid scanner and pass reports back to pod
                    */
                in scanSpaceServicesCommandPort : LogicalShipCommandPort;
            }
        }
        part gridSensor : LogicalPart {
            port gridSensorPort :> gridGravimetricSensorPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

            action logicalInitializeGridScanServices {
                doc /*
                    * Enable grid scanner
                    * Relay command to directional scanner and pass reports back to pod
                    */
                in scanSpaceServicesCommandPort : LogicalShipCommandPort;
            }
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

            action warpToBubbleEnd {
                in bubbleEnd : CelestialSignature;
            } 
        }
        part shieldGenerator : LogicalPart {
            port shieldProjectorPort :> shieldMitigationPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
        }
        part armourManager : LogicalPart {
            port armourPlatePort :> armourMitigationPort;
        }
        part structureManager : LogicalPart {

            attribute tractorBeamOn : Boolean;
            port beamTractorPort :> tractorBeamPort;
            port structureEnclosurePort :> structureMitigationPort;
        }

        //Binding interfacing logical parts to the logical ports
        bind highPowerTurretSlotCoupling1.highPowerSlotManagerPort = highPowerSlot1Port;
        bind highPowerTurretSlotCoupling2.highPowerSlotManagerPort = highPowerSlot2Port;
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
        bind structureManager.beamTractorPort = tractorBeamPort;

        
        //Logical application parts
        part shipController : LogicalPart {
            doc /*
                * Central controller of the ship that executes the state machine and
                * controls the parts of the ship.
                */
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

            state logicalMiningFrigateStates {
                doc /*
                    * This state defines the control behavior of the ship
                    * PodCommands are routed in through the commandNetworkPort
                    * Initialize the services of the ship for using by the pilot once the ship is undocking
                    * Prepares the ship services for warp priopr to entering in warp
                    * Shut down ship services prior to docking in station
                    */               
            }
        }
        part shipProcessor : LogicalPart {
            port computationNetwork : LogicalComputationNetworkPort :>> computationNetworkPort;

            action logicalInitializeShipProcessor {
                doc /*
                    * Initialize the shipProcesor for providing computation services to modules
                    */
                first start;
                then action logicalPowerUpShipProcessor;
                then action allocateComputationResources;
                then action monitorProcessorPerformance;
            }
        }
        
        part miningYieldEnhancer : LogicalPart;

        part powerGenerator : LogicalPart {
            port powerSourceGeneratorPort : LogicalPowerGridPort :>> powerGridPort;
            port powerGridPort : ~LogicalPowerGridPort :>> powerGridPort;

            action logicalInitializeGenerator {
            doc /*
                * Provides power to the energyStore 
                */
            
            first start;
            then action logicalPowerUpGenerator;
            then fork;
                then action monitorGenerator;
                then action generateEnergy {out energy : NaturalEnvironment::Energy = powerSourceGeneratorPort.powerGridEnergy;}
            }
        }
        part energyStore : LogicalPart {
            doc /*
                * Stores energy from the generator and stabilizes power supply in the powerGrid
                * Monitors the energy storage and regulates the generator
                */
            attribute maxStoredPower = suppliedCapacitor;
            port powerGridSupplyPort :>> powerGridPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port powerSourceStorePort : ~LogicalPowerGridPort :>> powerGridPort;
            
            ref item storedEnergy : NaturalEnvironment::Energy; // Energy in [GJ]

            action monitorEnergyStore;
            action provideEnergy {out energy : NaturalEnvironment::Energy = powerGridPort.powerGridEnergy;}
            action storeEnergy {in energy : NaturalEnvironment::Energy = powerSourceStorePort.powerGridEnergy;}
        }

        part oreStore : LogicalPart{
            doc /*
                * Stores Ore in transport containers (cans)
                */
        }

        part targetLockComputerArray : LogicalPart {
            doc /*
                * Locks and tracks up to five targets
                */

            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort; 
            port highPowerTurretSlot1TargetingPort : LogicalAlignmentPort;
            port highPowerTurretSlot2TargetingPort : LogicalAlignmentPort;
            action initializeTargetingComputers {
                doc /*
                    * Initializes the targeting computers.
                    */
            }
        }

        part extensionModulesManagementArray : LogicalPart {
            doc /*
                * Initializes and manages the extension modules
                * Receives modules commands from the commandNetwork
                * Relay commands to the modules
                */
            
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port extensionModule1ControlPort :>> commandControlGallentePort;
            port extensionModule2ControlPort :>> commandControlGallentePort;
            port extensionModule3ControlPort :>> commandControlGallentePort;
            port extensionModule4ControlPort :>> commandControlGallentePort;
            port extensionModule5ControlPort :>> commandControlGallentePort;
            port extensionModule6ControlPort :>> commandControlGallentePort;
            port extensionModule7ControlPort :>> commandControlGallentePort;
            
                action logicalInitializeExtensionModulesManagementArray {
                doc /*
                    * Initializes the modules configured in the ship
                    * Relays commands to the modules and reports back to the commandNetwork
                    */
                in modulesServicesCommandPort : LogicalShipCommandPort;
                }
        }

        part navigationManager : LogicalPart {
            doc /*
                * Executes navigation commands received from the controller
                */
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port mainPropulsorAnalog : LogicalAnalogPort;
            port zdirectionalPropulsorAnalog : LogicalAnalogPort;
            port ydirectionalPropulsorAnalog : LogicalAnalogPort;

            action logicalInitializeNavigationServices {
                doc /*
                    * Power up navigationManager
                    * Enable navigation commands (approach, orbit, keep at, dock, warp)
                    * return navigation reports
                    */
                in navigationServicesCommandPort : LogicalShipCommandPort;

            }
        }

        part droneStore : LogicalPart;

        //connectivity of logical application parts with logical interfacing parts
        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule1ControlPort to
            consumerPort ::> highPowerTurretSlotCoupling1.commandNetworkPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule2ControlPort to
            consumerPort ::> highPowerTurretSlotCoupling2.commandNetworkPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule3ControlPort to
            consumerPort ::> highPowerSlotCoupling3.commandNetworkPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule4ControlPort to
            consumerPort ::> midPowerSlotCoupling1.commandNetworkPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule5ControlPort to
            consumerPort ::> midPowerSlotCoupling2.commandNetworkPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule6ControlPort to
            consumerPort ::> midPowerSlotCoupling3.commandNetworkPort;

        interface : LogicalAlignmentSignalIF connect
            supplierPort ::> targetLockComputerArray.highPowerTurretSlot1TargetingPort to
            consumerPort ::> highPowerTurretSlotCoupling1.tartetingLockComputerPort;  

        interface : LogicalAlignmentSignalIF connect
            supplierPort ::> targetLockComputerArray.highPowerTurretSlot2TargetingPort to
            consumerPort ::> highPowerTurretSlotCoupling2.tartetingLockComputerPort;  


        //Flows are added to the standard logical interface
        interface def LogicalControlPipeIF :> LogicalControlIF {
            flow supplierPort.shipControl to consumerPort.shipControl;
            flow consumerPort.shipReport to supplierPort.shipReport;
        }

        //connectivity of logical application parts with logical application parts      
        //Flows are added to the standard logical interface       
        interface : LogicalControlPipeIF connect
            supplierPort ::> podManager.commandNetworkPort to
            consumerPort ::> commandNetwork.podManagerPort;

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
            port powerGeneratorPowerGridPort :>> powerGridPort;
            port energyStoreGridPort :>> powerGridPort;
            port highPowerSlotCoupling1GridPort :>> powerGridPort;
            port highPowerSlotCoupling2GridPort :>> powerGridPort;
            port highPowerSlotCoupling3GridPort :>> powerGridPort;
            port midPowerSlotCoupling1GridPort :>> powerGridPort;
            port midPowerSlotCoupling2GridPort :>> powerGridPort;
            port midPowerSlotCoupling3GridPort :>> powerGridPort;
            port shieldGeneratorGridPort :>> powerGridPort;

            action logicalInitializePowerGrid {
                doc /*
                    * Relays power from the energyStore to the modules
                    * Monitors the powerGrid
                    */
                
                first start;
                then action logicalPowerUpPowerGrid;
                then action monitorPowerInGrid;  
            }
                
        }
        part commandNetwork : LogicalPart {
            doc /*
                * Routes all shipCommand items between the ship parts.  
                */

            port podManagerPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port gridSensorCommandPort :>> commandControlGallentePort;
            port longRangeDirectionalSensorCommandPort :>> commandControlGallentePort;
            port navigationManagerCommandPort :>> commandControlGallentePort;
            port extensionModulesManagementArrayPort :>> commandControlGallentePort;
            port droneManagerCommandPort :>> commandControlGallentePort;
            port targetLockComputerArrayPort :>> commandControlGallentePort;
            port shipControllerPort :>> commandControlGallentePort;

            action logicalInitializecommandNetwork {
                doc /*
                    * Start services of the control network.
                    * Relay signals received from the podManager to all parts in the control network
                    * Collect reports from all parts in the control network
                    * Send reports to the podManager
                    */    
            }
        }
        part computationNetwork : LogicalPart {
            doc /*
                * Provides ship central CPU computation resources to modules.  
                */
            port shipProcessor : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            port highPowerSlotCoupling1Port :>> computationNetworkPort;
            port highPowerSlotCoupling2Port :>> computationNetworkPort;
            port highPowerSlotCoupling3Port :>> computationNetworkPort;
            port midPowerSlotCoupling1Port :>> computationNetworkPort;
            port midPowerSlotCoupling2Port :>> computationNetworkPort;
            port midPowerSlotCoupling3Port :>> computationNetworkPort;
            port lowPowerSlotCoupling1Port :>> computationNetworkPort;
            
            action logicalInitializeComputationNetwork {
                doc /*
                    * powers up and monitors the computation resources network 
                    */
                first start;
                then action logicalPowerUpcommandNetwork;
                then action monitorUsageCPU;
            }
        }

        //connectivity of logical infrastructure parts with logical application parts
        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.extensionModulesManagementArrayPort to
            consumerPort ::> extensionModulesManagementArray.commandNetworkPort; 
        
        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.targetLockComputerArrayPort to
            consumerPort ::> targetLockComputerArray.commandNetworkPort; 

        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.shipControllerPort to
            consumerPort ::> shipController.commandNetworkPort; 

        //connectivity of logical infrastructure parts with logical interfacing parts
        //control connectors
        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.gridSensorCommandPort to
            consumerPort ::> gridSensor.commandNetworkPort; 

        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.longRangeDirectionalSensorCommandPort to
            consumerPort ::> longRangeDirectionalSensor.commandNetworkPort; 

        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.navigationManagerCommandPort to
            consumerPort ::> navigationManager.commandNetworkPort;

        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.droneManagerCommandPort to
            consumerPort ::> droneControlManager.commandNetworkPort;

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
            consumerPort ::> highPowerTurretSlotCoupling1.powerGridPort;
        
        interface : LogicalPowerGridIF connect
            supplierPort ::> powerGrid.highPowerSlotCoupling2GridPort to
            consumerPort ::> highPowerTurretSlotCoupling2.powerGridPort;

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
            supplierPort ::> powerGrid.shieldGeneratorGridPort to
            consumerPort ::> shieldGenerator.powerGridPort;

        //computation network connectors
        //From ShipProcessor to network and from there to all modules
        interface : LogicalComputationServicesIF connect
            supplierPort ::> shipProcessor.computationNetwork to
            consumerPort ::> computationNetwork.shipProcessor;
        
        interface : LogicalComputationServicesIF connect
            supplierPort ::> computationNetwork.highPowerSlotCoupling1Port to
            consumerPort ::> highPowerTurretSlotCoupling1.computationNetworkPort;

        interface : LogicalComputationServicesIF connect
            supplierPort ::> computationNetwork.highPowerSlotCoupling2Port to
            consumerPort ::> highPowerTurretSlotCoupling2.computationNetworkPort;

        interface : LogicalComputationServicesIF connect
            supplierPort ::> computationNetwork.highPowerSlotCoupling3Port to
            consumerPort ::> highPowerSlotCoupling3.computationNetworkPort;

        interface : LogicalComputationServicesIF connect
            supplierPort ::> computationNetwork.midPowerSlotCoupling1Port to
            consumerPort ::> midPowerSlotCoupling1.computationNetworkPort;

        interface : LogicalComputationServicesIF connect
            supplierPort ::> computationNetwork.midPowerSlotCoupling2Port to
            consumerPort ::> midPowerSlotCoupling2.computationNetworkPort;

        interface : LogicalComputationServicesIF connect
            supplierPort ::> computationNetwork.midPowerSlotCoupling3Port to
            consumerPort ::> midPowerSlotCoupling3.computationNetworkPort;

        interface : LogicalComputationServicesIF connect
            supplierPort ::> computationNetwork.lowPowerSlotCoupling1Port to
            consumerPort ::> lowPowerSlotCoupling1.computationNetworkPort;
        
        //analog connectors
        //NavigationManager to Propulsion units
        interface : LogicalAnalogSignalIF connect
            supplierPort ::> navigationManager.mainPropulsorAnalog to
            consumerPort ::> mainPropulsor.navigationManagerAnalog;

        interface : LogicalAnalogSignalIF connect
            supplierPort ::> navigationManager.ydirectionalPropulsorAnalog to
            consumerPort ::> yAxisRotator.navigationManagerAnalog;

        interface : LogicalAnalogSignalIF connect
            supplierPort ::> navigationManager.zdirectionalPropulsorAnalog to
            consumerPort ::> zAxisRotator.navigationManagerAnalog;


        //Logical behavior inherited from the mining frigate definition
        //Venture class Behavior redefines imperial spaceship behavior 
        //(being a constraint for any spaceship) with manufacturer's technology 
                
    }  
}    
