package LogicalGrayBoxMiningFrigate {
    
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
    part logicalGrayBoxMiningFrigateVentureClass : LogicalGrayBoxMiningFrigateVentureClass;

    //Logical Mining Frigate
    part def LogicalGrayBoxMiningFrigateVentureClass :> MiningFrigateVentureClass {
        
        attribute massShip :>> massFrigate default 1200000.0;
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
            port moduleControlPort : ~LogicalModuleCommandPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            port tartetingLockComputerPort : ~LogicalAlignmentPort;
        }
        part highPowerTurretSlotCoupling2 : LogicalPart {
            port highPowerSlotManagerPort : HighSlotPort;
            port moduleControlPort : ~LogicalModuleCommandPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            port tartetingLockComputerPort : ~LogicalAlignmentPort;
        }
        part highPowerSlotCoupling3 : LogicalPart {
            port highPowerSlotManagerPort : HighSlotPort;
            port moduleControlPort : ~LogicalModuleCommandPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }
        part midPowerSlotCoupling1 : LogicalPart {
            port midPowerSlotManagerPort : MediumSlotPort;
            port moduleControlPort : ~LogicalModuleCommandPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }
        part midPowerSlotCoupling2 : LogicalPart {
            port midPowerSlotManagerPort : MediumSlotPort;
            port moduleControlPort : ~LogicalModuleCommandPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }
        part midPowerSlotCoupling3 : LogicalPart {
            port midPowerSlotManagerPort : MediumSlotPort;
            port moduleControlPort : ~LogicalModuleCommandPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
        }
        part lowPowerSlotCoupling1 : LogicalPart {
            port lowPowerSlotManagerPort : LowSlotPort;
            port moduleControlPort : ~LogicalModuleCommandPort;
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
                * Asynchronously receive podCommand items and send shipControl items to shipController
                * Set between the podPort (physical items) and the ShipController (logical items).
                */
            attribute podDockedStatus : Boolean;
            port podManagerPort : ~PodPort;
            port commandNetworkPort : LogicalShipCommandPort :>> commandControlGallentePort;
            port lowPowerGridPort :>> lowPowerGridPort;

            perform logicalStartUpSequence.logicalInitializePodManagerServices {
                in podManagerProxyPort : ~PodPort = podManagerPort;
                out commandNetworkProxyPort : LogicalShipCommandPort = commandNetworkPort;
            }
        }
        part dockingManager : LogicalPart {

            attribute shipDockedStatus : Boolean;
            port dockingManagerPort :> dockingPort;
        }
        part droneControlManager : LogicalPart {
            port droneControlManagerPort :> droneControlPort[2];
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

            perform logicalStartUpSequence.logicalInitializeDroneServices {
                in dronesControlManagerCommandPort : LogicalShipCommandPort = commandNetworkPort;
            }

        }
        part longRangeDirectionalSensor : LogicalPart {
            attribute gravimetricDirectionalSensorStrength :>> gravimetricSensorStrength default 4;

            port longRangeDirectionalSensorPort :> longRangeGravimetricDirectionalSensorPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

            perform logicalStartUpSequence.logicalInitializeLongRangeScanServices {
                in scanSpaceServicesCommandPort : LogicalShipCommandPort = commandNetworkPort;
            }
        }
        part gridOmnidirectionalSensor : LogicalPart {
            attribute gravimetricOmnidirectionalSensorStrength :>> gravimetricSensorStrength default 4;

            port gridOmnidirectionalSensorPort :> gridGravimetricSensorPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

            perform logicalStartUpSequence.logicalInitializeGridScanServices {
                in scanSpaceServicesCommandPort : LogicalShipCommandPort = commandNetworkPort;
            }
        }
            
        part mainPropulsor : LogicalPart {
            attribute maxImpulse :Real;

            port mainPropulsionNozzle :> xPropulsionPort [4];
            port navigationManagerAnalog : ~LogicalAnalogPort;

            assert constraint impulse2ManeuverabilityConstraint {
                in propulsorImpulse = maxImpulse;
                in yrotatorImpulse = yAxisRotator.maxImpulse;
                in zrotatorImpulse = zAxisRotator.maxImpulse;
                in shipSpeed = maxVelocity;
                in structureStrength = structure.structureStrength;
            }

            //The constraint definition my be relocated to a libray of constraints
            //and be reused in different contexts.
            constraint def Impulse2ManeuverabilityConstraint {
                doc /*
                    * relate maxVelocity of ship with maxImpulse from propulsor
                    * attribute maxVelocity :>> maxVelocity default 335.0;
                    */
                in propulsorImpulse : Real;
                in yrotatorImpulse :Real;
                in zrotatorImpulse :Real;
                in shipSpeed : Real;
                in structureStrength : Real;

                //expression -> f(yrotatorImpulse, zrotatorImpulse, shipSpeed, structureStrength) => propulsorImpulse;
            }
        }
        part yAxisRotator : LogicalPart {
            attribute maxImpulse :Real;

            port directionalPropulsorNozzle :> yPropulsionPort[2];
            port navigationManagerAnalog : ~LogicalAnalogPort;
        }
        part zAxisRotator : LogicalPart {
            attribute maxImpulse :Real;
            
            port directionalPropulsorNozzle :> zPropulsionPort[2];
            port navigationManagerAnalog : ~LogicalAnalogPort;
        }

        part warpGenerator : LogicalPart {
            attribute warpCoreStrength :>> warpCoreStrength default 2;
            attribute warpSpeed :>> warpSpeed default 5.0;

            port warpShieldPort :> LogicalGrayBoxMiningFrigateVentureClass::warpShieldPort; //Naming disambiguation

            perform warpToBubbleEnd {
                in bubbleEnd : CelestialSignature;
            } 
        }
        part shieldGenerator : LogicalPart {
            attribute generatorShieldStrength;

            port shieldProjectorPort :> shieldMitigationPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

            assert constraint shieldStrenght2ShieldGenerator {
                in generatorShieldStrength = generatorShieldStrength;
                in shipShieldStrength = shieldStrength;
            }
            
            constraint def ShieldStrenght2ShieldGenerator{
                doc /*
                    * relate shieldStrength of ship with generatorShieldStrength from shieldGenerator
                    * attribute shieldStrength :>> shieldStrength : Real default 225.0;
                    */
                in generatorShieldStrength : Real;
                in shipShieldStrength : Real;

                //expression -> f(shipShieldStrength) => generatorShieldStrength;
            }
        }
        part armour : LogicalPart {
            attribute armorStrength :>> armorStrength : Real default 175.0;

            port armourPlatePort :> armourMitigationPort;
        }
        part structure : LogicalPart {
            attribute structureStrength :>> structureStrength : Real default 200.0;
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
        bind gridOmnidirectionalSensor.gridOmnidirectionalSensorPort = gridGravimetricSensorPort;
        bind mainPropulsor.mainPropulsionNozzle = zPropulsionPort;
        bind zAxisRotator.directionalPropulsorNozzle = xPropulsionPort;
        bind yAxisRotator.directionalPropulsorNozzle = yPropulsionPort;
        bind warpGenerator.warpShieldPort = warpShieldPort;
        bind shieldGenerator.shieldProjectorPort = shieldMitigationPort;
        bind armour.armourPlatePort = armourMitigationPort;
        bind structure.structureEnclosurePort = structureMitigationPort;
        bind structure.beamTractorPort = tractorBeamPort;

        
        //Logical application parts
        part shipController : LogicalPart {
            doc /*
                * Central controller of the ship that executes the state machine and
                * controls the parts of the ship.
                */
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

            exhibit logicalGrayBoxMiningFrigateStates {
                in logicalGrayBoxMiningFrigateVentureClass : LogicalGrayBoxMiningFrigateVentureClass;
                in commandNetworkProxyPort : ~LogicalShipCommandPort = commandNetworkPort;
            }

        }
        part shipProcessor : LogicalPart {
            attribute suppliedCpu :>> suppliedCpu default 240;
            port computationNetwork : LogicalComputationNetworkPort :>> computationNetworkPort;

            perform logicalStartUpSequence.logicalInitializeShipProcessor;
        }
        
        part miningYieldEnhancer : LogicalPart {
            #mop attribute yieldBonus :>> yieldBonus;
        }

        part powerGenerator : LogicalPart {
            port powerSourceGeneratorPort : LogicalPowerGridPort :>> powerGridPort;
            port lowPowerGridPort :>> lowPowerGridPort;

            perform logicalStartUpSequence.logicalInitializeGenerator {
                out generatedEnergy : LogicalPowerSupply = powerSourceGeneratorPort.powerGridEnergy;
            }
        }
        part energyStore : LogicalPart {
            doc /*
                * Stores energy from the generator and stabilizes power supply in the powerGrid
                * Monitors the energy storage and regulates the generator
                */
            attribute suppliedCapacitor :>> suppliedCapacitor default 250.0;

            attribute maxStoredPower = suppliedCapacitor;
            port powerGridSupplyPort :>> powerGridPort;
            port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
            port powerSourceStorePort : ~LogicalPowerGridPort :>> powerGridPort;
            
            ref item storedEnergy : NaturalEnvironment::Energy; // Energy in [GJ]

            //add constriant def and assert cnstraint

            perform logicalStartUpSequence.logicalInitializeEnergyStore {
                in energyIn : LogicalPowerSupply = powerGridPort.powerGridEnergy;
                out energyOut : LogicalPowerSupply = powerSourceStorePort.powerGridEnergy;
            }
        }

        part oreStore : LogicalPart{
            doc /*
                * Stores Ore in transport containers (cans)
                */
            attribute oreHoldCapacity :>> oreHoldCapacity : Real default 5000.0;
        }

        part cargoHold : LogicalPart{
            doc /*
                * Stores cargo in transport containers
                */
            attribute cargoHoldCapacity :>> cargoHoldCapacity : Real default 50;
        }

        part targetLockComputerArray : LogicalPart {
            doc /*
                * Locks and tracks up to five targets
                */
            attribute maxLockedTargets :>> maxLockedTargets default 5;

            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort; 
            port highPowerTurretSlot1TargetingPort : LogicalAlignmentPort;
            port highPowerTurretSlot2TargetingPort : LogicalAlignmentPort;
            
            perform logicalStartUpSequence.initializeTargetingComputers {
                in commandNetworkProxyPort : ~LogicalShipCommandPort = commandNetworkPort;
                in highPowerTurretSlot1TargetingProxyPort : LogicalAlignmentPort = highPowerTurretSlot1TargetingPort;
                in highPowerTurretSlot2TargetingProxyPort : LogicalAlignmentPort = highPowerTurretSlot2TargetingPort;
            }
        }

        part extensionModulesManagementArray : LogicalPart {
            doc /*
                * Initializes and manages the extension modules
                * Receives modules commands from the commandNetwork
                * Relay commands to the modules
                */
            
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port extensionModule1ControlPort : LogicalModuleCommandPort;
            port extensionModule2ControlPort : LogicalModuleCommandPort;
            port extensionModule3ControlPort : LogicalModuleCommandPort;
            port extensionModule4ControlPort : LogicalModuleCommandPort;
            port extensionModule5ControlPort : LogicalModuleCommandPort;
            port extensionModule6ControlPort : LogicalModuleCommandPort;
            port extensionModule7ControlPort : LogicalModuleCommandPort;
            
            perform logicalStartUpSequence.logicalInitializeExtensionModulesManagementArray {
                in commandNetworkProxyPort : ~LogicalShipCommandPort = commandNetworkPort;
                in module1ControlProxyPort : LogicalModuleCommandPort = extensionModule1ControlPort;
                in module2ControlProxyPort : LogicalModuleCommandPort = extensionModule2ControlPort;
                in module3ControlProxyPort : LogicalModuleCommandPort = extensionModule3ControlPort;
                in module4ControlProxyPort : LogicalModuleCommandPort = extensionModule4ControlPort;
                in module5ControlProxyPort : LogicalModuleCommandPort = extensionModule5ControlPort;
                in module6ControlProxyPort : LogicalModuleCommandPort = extensionModule6ControlPort;
                in module7ControlProxyPort : LogicalModuleCommandPort = extensionModule7ControlPort;
            
            }
        }

        part navigationManager : LogicalPart {
            doc /*
                * Executes navigation commands received from the controller
                */
            attribute alignTime :>> alignTime default 5.99;

            assert constraint maneuverability2AlignmentConstraint : Maneuverability2AlignmentConstraint {
                in maxAlignTime = alignTime;
                in mass = massShip;
                in yrotatorImpulse = yAxisRotator.maxImpulse;
                in zrotatorImpulse = zAxisRotator.maxImpulse;
                in shipSpeed = maxVelocity;
            }

            constraint def Maneuverability2AlignmentConstraint {
                doc /*
                    * relate maxVelocity of ship with maxImpulse from propulsor
                    * attribute maxVelocity :>> maxVelocity default 335.0;
                    */
                in maxAlignTime : Real;
                in mass : Real;
                in yrotatorImpulse :Real;
                in zrotatorImpulse :Real;
                in shipSpeed : Real;

                //expression -> f(yrotatorImpulse, zrotatorImpulse, shipSpeed, mass) => alignTime;
            }

            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port mainPropulsorAnalogPort : LogicalAnalogPort;
            port zdirectionalPropulsorAnalogPort : LogicalAnalogPort;
            port ydirectionalPropulsorAnalogPort : LogicalAnalogPort;

            perform logicalStartUpSequence.logicalInitializeNavigationServices {
                in commandNetworkProxyPort : ~LogicalShipCommandPort = commandNetworkPort;
                out mainPropulsorControl : LogicalAnalogSignal = mainPropulsorAnalogPort.logicalAnalogSignal1;
                out zdirectionalPropulsorControl : LogicalAnalogSignal = zdirectionalPropulsorAnalogPort.logicalAnalogSignal1;
                out ydirectionalPropulsorControl : LogicalAnalogSignal = ydirectionalPropulsorAnalogPort.logicalAnalogSignal1;
            }

            bind mainPropulsorAnalogPort.logicalAnalogSignal1 = logicalInitializeNavigationServices.mainPropulsorControl;
            bind zdirectionalPropulsorAnalogPort.logicalAnalogSignal1 = logicalInitializeNavigationServices.zdirectionalPropulsorControl;
            bind ydirectionalPropulsorAnalogPort.logicalAnalogSignal1 = logicalInitializeNavigationServices.ydirectionalPropulsorControl;
        }

        part droneStore : LogicalPart;
            attribute droneStoreCapacity :>> droneCapacity : Real default 10;

        //connectivity of logical application parts with logical interfacing parts
        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule1ControlPort to
            consumerPort ::> highPowerTurretSlotCoupling1.moduleControlPort; 

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule2ControlPort to
            consumerPort ::> highPowerTurretSlotCoupling2.moduleControlPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule3ControlPort to
            consumerPort ::> highPowerSlotCoupling3.moduleControlPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule4ControlPort to
            consumerPort ::> midPowerSlotCoupling1.moduleControlPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule5ControlPort to
            consumerPort ::> midPowerSlotCoupling2.moduleControlPort;

        interface : LogicalControlIF connect
            supplierPort ::> extensionModulesManagementArray.extensionModule6ControlPort to
            consumerPort ::> midPowerSlotCoupling3.moduleControlPort;

        interface : LogicalAlignmentSignalIF connect
            supplierPort ::> targetLockComputerArray.highPowerTurretSlot1TargetingPort to
            consumerPort ::> highPowerTurretSlotCoupling1.tartetingLockComputerPort;  

        interface : LogicalAlignmentSignalIF connect
            supplierPort ::> targetLockComputerArray.highPowerTurretSlot2TargetingPort to
            consumerPort ::> highPowerTurretSlotCoupling2.tartetingLockComputerPort;  


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
            attribute suppliedPowerGrid :>> suppliedPowerGrid default 45;

            port energyStoreSupplyPort : ~LogicalPowerGridPort :>> powerGridPort;
            port energyStoreFlowbackPort :>> powerGridPort;
            port highPowerSlotCoupling1GridPort :>> powerGridPort;
            port highPowerSlotCoupling2GridPort :>> powerGridPort;
            port highPowerSlotCoupling3GridPort :>> powerGridPort;
            port midPowerSlotCoupling1GridPort :>> powerGridPort;
            port midPowerSlotCoupling2GridPort :>> powerGridPort;
            port midPowerSlotCoupling3GridPort :>> powerGridPort;
            port shieldGeneratorGridPort :>> powerGridPort;

            perform logicalStartUpSequence.logicalInitializePowerGrid {
                in energyIn : LogicalPowerSupply = energyStoreSupplyPort.powerGridEnergy;
                in shieldGeneratorGridProxyPort : LogicalPowerGridPort = shieldGeneratorGridPort;
                out energyFlowback : LogicalPowerSupply = energyStoreFlowbackPort.powerGridEnergy;
                out highPowerSlotCoupling1Energy : LogicalPowerSupply = highPowerSlotCoupling1GridPort.powerGridEnergy;
                out highPowerSlotCoupling2Energy : LogicalPowerSupply = highPowerSlotCoupling2GridPort.powerGridEnergy;
                out highPowerSlotCoupling3Energy : LogicalPowerSupply = highPowerSlotCoupling3GridPort.powerGridEnergy;
                out midPowerSlotCoupling1Energy : LogicalPowerSupply = midPowerSlotCoupling1GridPort.powerGridEnergy;
                out midPowerSlotCoupling2Energy : LogicalPowerSupply = midPowerSlotCoupling2GridPort.powerGridEnergy;
                out midPowerSlotCoupling3Energy : LogicalPowerSupply = midPowerSlotCoupling3GridPort.powerGridEnergy;
            }   
        }
        part commandNetwork : LogicalPart {
            doc /*
                * Routes all shipCommand items to the ship parts.  
                */

            port podManagerPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port shipControllerPort :>> commandControlGallentePort;
            port longRangeDirectionalSensorCommandPort :>> commandControlGallentePort;
            port navigationManagerCommandPort :>> commandControlGallentePort;
            port extensionModulesManagementArrayPort :>> commandControlGallentePort;
            port droneManagerCommandPort :>> commandControlGallentePort;
            port targetLockComputerArrayPort :>> commandControlGallentePort;

            perform logicalStartUpSequence.logicalInitializeCommandNetwork {
                in podManagerProxyPort : ~LogicalShipCommandPort = podManagerPort;
                in longRangeDirectionalSensorCommandProxyPort : LogicalShipCommandPort = longRangeDirectionalSensorCommandPort;
                in navigationManagerCommandProxyPort  : LogicalShipCommandPort = navigationManagerCommandPort;
                in extensionModulesManagementArrayProxyPort : LogicalShipCommandPort = extensionModulesManagementArrayPort;
                in droneManagerCommandProxyPort : LogicalShipCommandPort = droneManagerCommandPort;
                in targetLockComputerArrayProxyPort: LogicalShipCommandPort = targetLockComputerArrayPort;
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
            
            perform logicalStartUpSequence.logicalInitializeComputationNetwork;
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
            supplierPort ::> commandNetwork.longRangeDirectionalSensorCommandPort to
            consumerPort ::> longRangeDirectionalSensor.commandNetworkPort; 

        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.navigationManagerCommandPort to
            consumerPort ::> navigationManager.commandNetworkPort;

        interface : LogicalControlIF connect
            supplierPort ::> commandNetwork.droneManagerCommandPort to
            consumerPort ::> droneControlManager.commandNetworkPort;

        interface : LogicalControlIF connect
            supplierPort ::> podManager.commandNetworkPort to
            consumerPort ::> commandNetwork.podManagerPort;

        //power connectors
        //power generator to powerSupply to powerGrid triangle

        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> powerGenerator.powerSourceGeneratorPort to
            consumerPort ::> energyStore.powerSourceStorePort;

        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> energyStore.powerGridSupplyPort to
            consumerPort ::> powerGrid.energyStoreSupplyPort;

        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> powerGrid.energyStoreFlowbackPort to
            consumerPort ::> energyStore.powerGridPort;

        //power connectors
        //powerGrid to modules
        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> powerGrid.highPowerSlotCoupling1GridPort to
            consumerPort ::> highPowerTurretSlotCoupling1.powerGridPort;
        
        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> powerGrid.highPowerSlotCoupling2GridPort to
            consumerPort ::> highPowerTurretSlotCoupling2.powerGridPort;

        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> powerGrid.highPowerSlotCoupling3GridPort to
            consumerPort ::> highPowerSlotCoupling3.powerGridPort;

        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> powerGrid.midPowerSlotCoupling1GridPort to
            consumerPort ::> midPowerSlotCoupling1.powerGridPort;

        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> powerGrid.midPowerSlotCoupling2GridPort to
            consumerPort ::> midPowerSlotCoupling2.powerGridPort;

        interface : LogicalPowerGridFlowIF connect
            supplierPort ::> powerGrid.midPowerSlotCoupling3GridPort to
            consumerPort ::> midPowerSlotCoupling3.powerGridPort;

        //power connectors
        //powerGrid to Ship subsystems that consume from powerGrid

        interface : LogicalPowerGridFlowIF connect
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
            supplierPort ::> navigationManager.mainPropulsorAnalogPort to
            consumerPort ::> mainPropulsor.navigationManagerAnalog;

        interface : LogicalAnalogSignalIF connect
            supplierPort ::> navigationManager.ydirectionalPropulsorAnalogPort to
            consumerPort ::> yAxisRotator.navigationManagerAnalog;

        interface : LogicalAnalogSignalIF connect
            supplierPort ::> navigationManager.zdirectionalPropulsorAnalogPort to
            consumerPort ::> zAxisRotator.navigationManagerAnalog;
        
                
    }

    //Logical behavior inherited from the mining frigate definition
    //Venture class Behavior redefines imperial spaceship behavior 
    //(being a constraint for any spaceship) with manufacturer's technology 
    state logicalGrayBoxMiningFrigateStates {
            doc /*
                * This state defines the control behavior of the ship
                * PodCommands are routed in through the commandNetworkPort
                * Initialize the services of the ship for using by the pilot once the ship is undocking
                * Prepares the ship services for warp priopr to entering in warp
                * Shut down ship services prior to docking in station
                */               
            in logicalGrayBoxMiningFrigateVentureClass: LogicalGrayBoxMiningFrigateVentureClass;
            in commandNetworkPort : ~LogicalShipCommandPort;
                
            entry action initial;
            then state LogicalGrayBoxParked {
                doc /* The mining frigate is parked inside a station and can be boarded. */
            } 	
            state LogicalGrayBoxBoarded {
                doc /* The mining frigate is boarded inside a station in the docking pad, available for refitting, resupply, or cargo transfer. */
            }
            state LogicalGrayBoxInGrid {
                doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
            }
            state LogicalGrayBoxOnWarp {
                doc /* The mining frigate is in warp, traveling between locations. */
            }        
            
            transition logicalMiningFrigate_parked_to_boarded
                first LogicalGrayBoxParked
                accept when logicalGrayBoxMiningFrigateVentureClass.podManager.podDockedStatus == true
                then LogicalGrayBoxBoarded;
            
            transition logicalMiningFrigate_boarded_to_parked
                first LogicalGrayBoxBoarded
                accept when logicalGrayBoxMiningFrigateVentureClass.podManager.podDockedStatus == false
                then LogicalGrayBoxParked;
            
            transition logicalMiningFrigate_boarded_to_inGrid
                first LogicalGrayBoxBoarded
                accept when logicalGrayBoxMiningFrigateVentureClass.dockingManager.shipDockedStatus == false
                do logicalStartUpSequence
                then LogicalGrayBoxInGrid;  		
                
            transition logicalMiningFrigate_inGrid_to_docked
                first LogicalGrayBoxInGrid
                accept pilotPodDockCommandSig :>> pilotPodDockCommandSig via commandNetworkPort
                do logicalShutDownSequence
                then LogicalGrayBoxBoarded;
                
            transition logicalMiningFrigate_inGrid_to_onWarp
                first LogicalGrayBoxInGrid
                accept warpCommandSig :>> warpCommandSig via commandNetworkPort
                do logicalPrepareForWarp
                then LogicalGrayBoxOnWarp;
        
            transition logicalMiningFrigate_onWarp_to_inGrid
                first LogicalGrayBoxOnWarp
                accept when logicalGrayBoxMiningFrigateVentureClass.warpBubbleEnd
                do logicalRestoreFromWarp
                then LogicalGrayBoxInGrid;                   
        }
            
    action logicalStartUpSequence {
        doc /*
            * Initialize the services of the ship for using by the pilot
            */

        first start;
        then action powerUpShipController;
        then action logicalInitializePowerGrid {
            doc /*
                * Relays power from the energyStore to the modules
                * Monitors the powerGrid
                */
            
            in energyIn : LogicalPowerSupply;
            in shieldGeneratorGridPort : LogicalPowerGridPort;
            out energyFlowback : LogicalPowerSupply;
            out highPowerSlotCoupling1Energy : LogicalPowerSupply;
            out highPowerSlotCoupling2Energy : LogicalPowerSupply;
            out highPowerSlotCoupling3Energy : LogicalPowerSupply;
            out midPowerSlotCoupling1Energy : LogicalPowerSupply;
            out midPowerSlotCoupling2Energy : LogicalPowerSupply;
            out midPowerSlotCoupling3Energy : LogicalPowerSupply;
        }
        then action logicalInitializeEnergyStore {
            doc /*
                * Stores energy from the generator and stabilizes power supply in the powerGrid
                * Monitors the energy storage and regulates the generator
                */
            
            in energyIn : LogicalPowerSupply;
            out energyOut : LogicalPowerSupply;

            action monitorEnergyStore;
            action provideEnergy {out energy : LogicalPowerSupply;}
            action storeEnergy {in energy : LogicalPowerSupply;}

            bind energyIn = storeEnergy.energy;
            bind energyOut = provideEnergy.energy;
        }
        then action logicalInitializeGenerator {
            doc /*
                * Provides power to the energyStore 
                */
            out generatedEnergy : LogicalPowerSupply;

            first start;
            then action logicalPowerUpGenerator;
            then fork;
                then action monitorGenerator;
                then action generateEnergy {out energy : LogicalPowerSupply;}
            
            bind generatedEnergy = generateEnergy.energy;
        }
        then action logicalInitializePodManagerServices {
            doc /*
                * Decrypt incomming commands from the pod and relay to the commandNetwork
                * The input signals are physical, the output signals are logical.
                * Collect reports, encrypt them and relay them to the pilotPod
                */
            in podManagerPort : ~PodPort;
            out commandNetworkPort : LogicalShipCommandPort;  
        }
        then action logicalInitializeCommandNetwork {
            doc /*
                * Start services of the control network.
                * Relay signals received from the podManager to all parts in the control network
                * Collect reports from all parts in the control network
                * Send reports to the podManager
                */
            in gridSensorCommandPort : LogicalShipCommandPort;
            in longRangeDirectionalSensorCommandPort : LogicalShipCommandPort;
            in navigationManagerCommandPort  : LogicalShipCommandPort;
            in extensionModulesManagementArrayPort : LogicalShipCommandPort;
            in droneManagerCommandPort : LogicalShipCommandPort;
            in targetLockComputerArrayPort: LogicalShipCommandPort;  
        }
        then action logicalInitializeLongRangeScanServices {
            doc /*
                * Enable long range scanner
                * Autoactivate grid scanner and pass reports back to pod
                */
        }
        then action logicalInitializeGridScanServices {
            doc /*
                * Enable grid scanner
                * Relay command to directional scanner and pass reports back to pod
                */
            }
        then action logicalInitializeNavigationServices {
            doc /*
                * Power up navigationManager
                * Enable navigation commands (approach, orbit, keep at, dock, warp)
                * return navigation reports
                */
            in navigationComandsPort : ~LogicalShipCommandPort;
            out mainPropulsorControl : LogicalAnalogSignal;
            out zdirectionalPropulsorrControl : LogicalAnalogSignal;
            out ydirectionalPropulsorControl : LogicalAnalogSignal;
        }
        then action initializeTargetingComputers {
            doc /*
                * Initializes the targeting computers.
                */
        }
        then action logicalInitializeShipProcessor {
            doc /*
                * Initialize the shipProcesor for providing computation services to modules
                * Allocate computer resources
                * monitro computer performance
                */
            first start;
            then action logicalPowerUpShipProcessor;
            then action allocateComputationResources;
            then action monitorProcessorPerformance;
        }
        then action logicalInitializeDroneServices {
            doc /*
                * Power up and enable drone services
                * Engage drone defenses if commanded
                * Other drone actions may be added
                */
            in dronesControlManagerCommandPort : ~LogicalShipCommandPort;
        }
        then action logicalInitializeExtensionModulesManagementArray {
            doc /*
                * Initializes the modules configured in the ship
                * Relays commands to the modules and reports back to the commandNetwork
                */
            in commandNetworkProxyPort : ~LogicalShipCommandPort;
            in module1ControlProxyPort : LogicalModuleCommandPort;
            in module2ControlProxyPort : LogicalModuleCommandPort;
            in module3ControlProxyPort : LogicalModuleCommandPort;
            in module4ControlProxyPort : LogicalModuleCommandPort;
            in module5ControlProxyPort : LogicalModuleCommandPort;
            in module6ControlProxyPort : LogicalModuleCommandPort;
            in module7ControlProxyPort : LogicalModuleCommandPort;
        }
        then action logicalInitializeComputationNetwork {
            doc /*
                * powers up and monitors the computation resources network 
                */
            first start;
            then action logicalPowerUpcommandNetwork;
            then action monitorUsageCPU;
        }
        
    }
    action logicalShutDownSequence {
        doc /*
            * powers down all services of the ship prior to docking in station
            */
    }
    action logicalPrepareForWarp {
        doc /*
            * powers down navigation and drones services prior to warping
            * reconfigures the ship for warp
            */
    }
    action logicalRestoreFromWarp {
        doc /*
            * powers up navigation and drones services after warp ends
            * reconfigures the ship for operations
            */
    }
    action warpToBubbleEnd {
        doc /*
            * aligns to destination
            * activates the warp generator
            * deactivates the warp generator on arrival to destination
            */
        in bubbleEnd : CelestialSignature;
    } 
    
}     
