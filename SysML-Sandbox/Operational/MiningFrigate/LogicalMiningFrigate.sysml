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
                port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            }
            part highPowerSlotCoupling2 : LogicalPart {
                port highPowerSlotManagerPort : HighSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
                port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            }
            part highPowerSlotCoupling3 : LogicalPart {
                port highPowerSlotManagerPort : HighSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
                port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            }
            part midPowerSlotCoupling1 : LogicalPart {
                port midPowerSlotManagerPort : MediumSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
                port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            }
            part midPowerSlotCoupling2 : LogicalPart {
                port midPowerSlotManagerPort : MediumSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
                port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            }
            part midPowerSlotCoupling3 : LogicalPart {
                port midPowerSlotManagerPort : MediumSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;
                port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            }
            part lowPowerSlotCoupling1 : LogicalPart {
                port lowPowerSlotManagerPort : LowSlotPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port computationNetworkPort : ~LogicalComputationNetworkPort :>> computationNetworkPort;
            }

            part rigCoupling1 : LogicalPart {
                port rigCouplingPort : RigPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
            }
            part rigCoupling2 : LogicalPart {
                port rigCouplingPort : RigPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
            }
            part rigCoupling3 : LogicalPart {
                port rigCouplingPort : RigPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
            }

            part podManager : LogicalPart {
                doc /*
                    * Receive asynchronously podCommand items and send shipControl items to shipController
                    * Set between the podPort and the ShipController.
                    */
                port podManagerPort :> podPort;
                port shipControllerPort :>> commandControlGallentePort;

                action logicalInitializePodManagerServices {

                    first start;
                    then action logicalPowerUpPodManager;
                    then fork;
                        then logicalDecryptShipCommands {
                            in encryptedPilotPodCommands = podManagerPort.command;
                            out decryptedShipCommand = shipControllerPort.shipControl;
                        }
                        then logicalEncryptShipReports {
                            in decryptedShipReport = shipControllerPort.shipReport;
                            out encryptedShipReport = podManagerPort.shipReport;
                        }
                    action logicalDecryptShipCommands {
                        doc /*
                            * Decrypts and Relays commands from the pilotPod to the shipController
                            * The input signals are physical, the output signals are logical. 
                            */
                        in encryptedPilotPodCommands : ShipCommand;
                        out decryptedShipCommand : LogicalControlCommand;
                    }
                    action logicalEncryptShipReports {
                        doc /*
                            * Collect reports, encrypt them and relay them to the pilotPod 
                            */
                        
                        in decryptedShipReport : LogicalShipReport;
                        out encryptedShipReport : ShipReport;
                    }
                }
            }
            part dockingManager : LogicalPart {
                port dockingManagerPort :> dockingPort;
            }
            part droneControlManager : LogicalPart {
                port droneControlManagerPort :> droneControlPort[2];
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                action logicalInitializeDroneServices {
                    doc /*
                        * Power up and enable drone services through calls to the dronesManager (perform action manageDrones...).
                        */
                    in dronesControlManagerCommandPort : LogicalShipControlPort;
                    first start;
                    then action logicalPowerUpDronesControlManager;
                    then accept pilotDroneCommand : LogicalControlCommand via dronesControlManagerCommandPort;
                    then action manageDrones {
                        in droneCommand : LogicalControlCommand; 
                        out reportDrones : LogicalShipReport;
                    }
                    then send manageDrones.reportDrones via dronesControlManagerCommandPort;
                }

            }
            part longRangeDirectionalSensor : LogicalPart {
                port longRangeDirectionalSensorPort :> longRangeGravimetricDirectionalSensorPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                action logicalInitializeLongRangeScanServices {
                    doc /*
                        * Enable long range scanner
                        */
                    in scanSpaceServicesCommandPort : LogicalShipControlPort;

                    first start;
                    
                    then action logicalPowerUpDirectionalSensorSystem;
                    then action logicalDirectionalScan {
                        accept ScanForThreatsCommand : ShipCommand via scanSpaceServicesCommandPort;
                        then action logicalScanSpace {out scanReport : String;}
                        then send logicalScanSpace.scanReport via scanSpaceServicesCommandPort;
                        then terminate this;
                    }
                }
            }
            part gridSensor : LogicalPart {
                port gridSensorPort :> gridGravimetricSensorPort;
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                action logicalInitializeGridScanServices {
                    doc /*
                        * Enable grid scanner
                        */
                    in scanSpaceServicesCommandPort : LogicalShipControlPort;

                    first start;
                    then action logicalPowerUpGridSensorSystem;
                    then action logicalScanGrid {
                        accept after 1[s];
                        then action logicalCycleScanner {out scanReport : String;}
                        then send logicalCycleScanner.scanReport via scanSpaceServicesCommandPort;
                        then terminate this;
                    }
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
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port powerGridPort : ~LogicalPowerGridPort  :>> powerGridPort;

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
                port controlNetworkCommandPort : LogicalShipControlPort :>> commandControlGallentePort;
                port podManagerPort : ~LogicalShipControlPort :>> commandControlGallentePort;

                action logicalStartUpSequence {
                    doc /*
                        * Initialize the services of the ship for using by the pilot
                        * 
                        */
                    in logicalGridServicesCommandPort : LogicalShipControlPort;
                    
                    in podManagerPort : ~LogicalShipControlPort;
                    in controlNetworkCommandPort : LogicalShipControlPort;

                    in podManagerControlCommand : LogicalControlCommand;
                    out controlNetworkControlCommand : LogicalControlCommand;
                    in controlNetworkShipReport : LogicalShipReport;
                    out podManagerShipReport : LogicalShipReport;

                    first start;
                    then action powerUpShipController;
                    then perform powerGrid.logicalInitializePowerGrid;
                    then perform powerGenerator.logicalInitializeGenerator;
                    then perform podManager.logicalInitializePodManagerServices;
                    then perform controlNetwork.logicalInitializeControlNetwork;
                    then perform longRangeDirectionalSensor.logicalInitializeLongRangeScanServices;
                    then perform gridSensor.logicalInitializeGridScanServices;
                    then perform navigationManager.logicalInitializeNavigationServices;
                    then perform targetLockComputerArray.initializeTargetingComputers;
                    then perform shipProcessor.logicalInitializeShipProcessor;
                    then perform droneControlManager.logicalInitializeDroneServices;
                    then perform extensionModulesManagementArray.logicalInitializeExtensionModulesManagementArray;
                    then perform computationNetwork.logicalInitializeComputationNetwork;
                    
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
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
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

                abstract part targetLockComputer[5] : LogicalPart {

                    port targetLockManagerPort : LogicalShipControlPort;

                    action logicalEnableTargetingComputer {
                        in logicalEnableTargetingComputerCommandPort : LogicalShipControlPort;

                        accept trigger : LockTarget via logicalEnableTargetingComputerCommandPort;
                        then action targetLockSignature;
                        then action logicalreportTargetLock {out shipReport : String;}
                        then send logicalreportTargetLock.shipReport via logicalEnableTargetingComputerCommandPort;
                    }
                }
                part targetLockComputer1 :> targetLockComputer {
                    action :>> logicalEnableTargetingComputer;
                }
                part targetLockComputer2 :> targetLockComputer {
                    action :>> logicalEnableTargetingComputer;
                }
                part targetLockComputer3 :> targetLockComputer {
                    action :>> logicalEnableTargetingComputer;
                }
                part targetLockComputer4 :> targetLockComputer {
                    action :>> logicalEnableTargetingComputer;
                }
                part targetLockComputer5 :> targetLockComputer {
                    action :>> logicalEnableTargetingComputer;
                }

                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port highPowerSlot1Targeting : LogicalAnalogPort;
                port highPowerSlot2Targeting : LogicalAnalogPort;
                port highPowerSlot3Targeting : LogicalAnalogPort;

                action initializeTargetingComputers {
                    doc /*
                        * Initializes the targeting computers.
                        */

                    first start;
                    then action logicalPowerUpTrackingComputers;
                    then fork;
                        then targetLockComputer1.logicalEnableTargetingComputer {
                            in logicalEnableTargetingComputerCommandPort = targetLockComputer1.targetLockManagerPort;
                        }
                        then targetLockComputer2.logicalEnableTargetingComputer {
                            in logicalEnableTargetingComputerCommandPort = targetLockComputer2.targetLockManagerPort;
                        }
                        then targetLockComputer3.logicalEnableTargetingComputer {
                            in logicalEnableTargetingComputerCommandPort = targetLockComputer3.targetLockManagerPort;
                        }
                        then targetLockComputer4.logicalEnableTargetingComputer {
                            in logicalEnableTargetingComputerCommandPort = targetLockComputer4.targetLockManagerPort;
                        }
                        then targetLockComputer5.logicalEnableTargetingComputer {
                            in logicalEnableTargetingComputerCommandPort = targetLockComputer5.targetLockManagerPort;
                        }
                }
            }

            part extensionModulesManagementArray : LogicalPart {
                doc /*
                    * Initializes and manages the extension modules
                    */
                
                port controlNetworkPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port extensionModule1ControlPort :>> commandControlGallentePort;
                port extensionModule2ControlPort :>> commandControlGallentePort;
                port extensionModule3ControlPort :>> commandControlGallentePort;
                port extensionModule4ControlPort :>> commandControlGallentePort;
                port extensionModule5ControlPort :>> commandControlGallentePort;
                port extensionModule6ControlPort :>> commandControlGallentePort;
                port extensionModule7ControlPort :>> commandControlGallentePort;

                abstract part extensionModuleManager[7] : LogicalPart {
                    
                    port extensionSlotPort :>> commandControlGallentePort;
                    port deMuxPort : ~LogicalShipControlPort :>> commandControlGallentePort;

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
                            in moduleToEnable = module; 
                            out commandModule : ModuleCommand;
                        }
                        then accept logicalEnableModuleServices.commandModule;
                        then perform action logicalModuleFunction ::> logicalEnableModuleServices.moduleToEnable.imperialStandardModuleAction;
                        then accept logicalModuleFunction.moduleReport;
                        then action logicalReportStatusModule {
                            in moduleReport = logicalModuleFunction.moduleReport; 
                            out shipReport : ShipReport;
                        }
                        then send logicalReportStatusModule.shipReport via moduleServicesCommandPort;
                    }
                }

                part muxDeMux : LogicalPart {
                    port controlNetworkPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                    
                    port extensionModule1ControlPort :>> commandControlGallentePort;
                    port extensionModule2ControlPort :>> commandControlGallentePort;
                    port extensionModule3ControlPort :>> commandControlGallentePort;
                    port extensionModule4ControlPort :>> commandControlGallentePort;
                    port extensionModule5ControlPort :>> commandControlGallentePort;
                    port extensionModule6ControlPort :>> commandControlGallentePort;
                    port extensionModule7ControlPort :>> commandControlGallentePort;

                    action logicalInitializeDeMux {
                        first start;
                        then action logicalPowerUpDeMux;
                        then action relayControlCommands {
                            in relayControlCommandsPort : ~LogicalShipControlPort = controlNetworkPort;
                            in shipControllerControlCommand : LogicalControlCommand = controlNetworkPort.shipControl;        
                            
                            action verifyControlCommand {
                                in command = shipControllerControlCommand;
                                out verifiedCommand;
                            }
                            then send verifyControlCommand.verifiedCommand via relayControlCommandsPort;
                        }
                        then action relayShipReports {
                            in relayControlCommandsPort : ~LogicalShipControlPort = controlNetworkPort;
                            out shipControllerShipReport : LogicalShipReport = controlNetworkPort.shipReport;

                            action acceptShipReport accept controlNetworkShipReport : LogicalControlCommand via relayControlCommandsPort;
                            then action verifyReport {
                                in report = acceptShipReport.controlNetworkShipReport;
                                out verifiredReport = shipControllerShipReport;
                            }
                        }
                    }
                }

                part extensionModuleManager1 :> extensionModuleManager {
                    action :>> logicalInitializeExtensionModule;
                    port :>> extensionSlotPort;
                }
                part extensionModuleManager2 :> extensionModuleManager {
                    action :>> logicalInitializeExtensionModule;
                    port :>> extensionSlotPort;
                }
                part extensionModuleManager3 :> extensionModuleManager {
                    action :>> logicalInitializeExtensionModule;
                    port :>> extensionSlotPort;
                }
                part extensionModuleManager4 :> extensionModuleManager {
                    action :>> logicalInitializeExtensionModule;
                    port :>> extensionSlotPort;
                }
                part extensionModuleManager5 :> extensionModuleManager {
                    action :>> logicalInitializeExtensionModule;
                    port :>> extensionSlotPort;
                }
                part extensionModuleManager6 :> extensionModuleManager {
                    action :>> logicalInitializeExtensionModule;
                    port :>> extensionSlotPort;
                }
                part extensionModuleManager7 :> extensionModuleManager {
                    action :>> logicalInitializeExtensionModule;
                    port :>> extensionSlotPort;
                }
                
                bind controlNetworkPort = muxDeMux.controlNetworkPort;
                bind extensionModuleManager1.extensionSlotPort = extensionModule1ControlPort;
                bind extensionModuleManager2.extensionSlotPort = extensionModule2ControlPort;
                bind extensionModuleManager3.extensionSlotPort = extensionModule3ControlPort;
                bind extensionModuleManager4.extensionSlotPort = extensionModule4ControlPort;
                bind extensionModuleManager5.extensionSlotPort = extensionModule5ControlPort;
                bind extensionModuleManager6.extensionSlotPort = extensionModule6ControlPort;

                interface : LogicalControlIF connect
                    supplierPort ::> muxDeMux.extensionModule1ControlPort to
                    consumerPort ::> extensionModuleManager1.deMuxPort; 
                interface : LogicalControlIF connect
                    supplierPort ::> muxDeMux.extensionModule2ControlPort to
                    consumerPort ::> extensionModuleManager2.deMuxPort; 
                interface : LogicalControlIF connect
                    supplierPort ::> muxDeMux.extensionModule3ControlPort to
                    consumerPort ::> extensionModuleManager3.deMuxPort;  
                interface : LogicalControlIF connect
                    supplierPort ::> muxDeMux.extensionModule4ControlPort to
                    consumerPort ::> extensionModuleManager4.deMuxPort; 
                interface : LogicalControlIF connect
                    supplierPort ::> muxDeMux.extensionModule5ControlPort to
                    consumerPort ::> extensionModuleManager5.deMuxPort; 
                interface : LogicalControlIF connect
                    supplierPort ::> muxDeMux.extensionModule6ControlPort to
                    consumerPort ::> extensionModuleManager6.deMuxPort; 
                interface : LogicalControlIF connect
                    supplierPort ::> muxDeMux.extensionModule7ControlPort to
                    consumerPort ::> extensionModuleManager7.deMuxPort; 

                action logicalInitializeExtensionModulesManagementArray {
                    doc /*
                        * Initializes the modules configured in the ship.
                        */
                    in modulesServicesCommandPort : LogicalShipControlPort;
                    first start;
                    then fork; 
                        then muxDeMux.logicalInitializeDeMux;                  
                        then extensionModuleManager1.logicalInitializeExtensionModule {
                            in moduleServicesCommandPort = extensionModuleManager1.extensionSlotPort;
                            in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot1;
                        }
                        then extensionModuleManager2.logicalInitializeExtensionModule {
                            in moduleServicesCommandPort = modulesServicesCommandPort;
                            in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot2;
                        }
                        then extensionModuleManager3.logicalInitializeExtensionModule {
                            in moduleServicesCommandPort = modulesServicesCommandPort;
                            in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot3;
                        }
                        then extensionModuleManager4.logicalInitializeExtensionModule {
                            in moduleServicesCommandPort = modulesServicesCommandPort;
                            in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot1;
                        }
                        then extensionModuleManager5.logicalInitializeExtensionModule {
                            in moduleServicesCommandPort = modulesServicesCommandPort;
                            in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot2;
                        }
                        then extensionModuleManager6.logicalInitializeExtensionModule {
                            in moduleServicesCommandPort = modulesServicesCommandPort;
                            in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot3;
                        }
                        then extensionModuleManager7.logicalInitializeExtensionModule {
                            in moduleServicesCommandPort = modulesServicesCommandPort;
                            in module = LogicalStructure::LogicalMiningFrigateVentureClass::configurationManager::lowPowerSlot1;
                        }                     
                }
            }

            part navigationManager : LogicalPart {
                doc /*
                    * Executes navigation commands received from the controller
                    */
                port controlNetworkCommandPort : ~LogicalShipControlPort :>> commandControlGallentePort;
                port mainPropulsorAnalog : LogicalAnalogPort;
                port zdirectionalPropulsorAnalog : LogicalAnalogPort;
                port ydirectionalPropulsorAnalog : LogicalAnalogPort;

                action logicalInitializeNavigationServices {
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
                        accept approachSignatureAtRangeCommand : ShipCommand via navigationServicesCommandPort;
                        //more actions come here
                        then action logicalreportStatusApproach {out shipReport : String;}
                        then send logicalreportStatusApproach.shipReport via navigationServicesCommandPort;
                    }
                    action logicalOrbitSignatureAtRange;
                    action logicalKeepAtRangeSignature;
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

                        accept executeWarpDriveCommand : ExecuteWarpDriveCommand via logicalWarpCommandPort;
                        then action reportStatusWarpDrive {out shipReport : ShipReport;}
                        then send reportStatusWarpDrive.shipReport via logicalWarpCommandPort;
                        then perform warpGenerator.warpToBubbleEnd {in bubbleEnd = warpBubbleEnd;} 
                        then action reportStatusDestination {out shipReport : String;}
                        then send reportStatusDestination.shipReport via logicalWarpCommandPort;
                    }  
                }
            }

            part droneStore : LogicalPart;

            //connectivity of logical application parts with logical interfacing parts
            interface : LogicalControlIF connect
                supplierPort ::> extensionModulesManagementArray.extensionModule1ControlPort to
                consumerPort ::> highPowerSlotCoupling1.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModulesManagementArray.extensionModule2ControlPort to
                consumerPort ::> highPowerSlotCoupling2.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModulesManagementArray.extensionModule3ControlPort to
                consumerPort ::> highPowerSlotCoupling3.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModulesManagementArray.extensionModule4ControlPort to
                consumerPort ::> midPowerSlotCoupling1.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModulesManagementArray.extensionModule5ControlPort to
                consumerPort ::> midPowerSlotCoupling2.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModulesManagementArray.extensionModule6ControlPort to
                consumerPort ::> midPowerSlotCoupling3.controlNetworkCommandPort;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModulesManagementArray.extensionModule7ControlPort to
                consumerPort ::> lowPowerSlotCoupling1.controlNetworkCommandPort;  

            //Flows are added to the standard logical interface
            interface def LogicalControlPipeIF :> LogicalControlIF {
                flow supplierPort.shipControl to consumerPort.shipControl;
                flow consumerPort.shipReport to supplierPort.shipReport;
            }
            
            interface : LogicalControlPipeIF connect
                supplierPort ::> podManager.podManagerPort to
                consumerPort ::> shipController.podManagerPort;

            //connectivity of logical application parts with logical application parts      
            //Flows are added to the standard logical interface       
            interface : LogicalControlPipeIF connect
                supplierPort ::> shipController.controlNetworkCommandPort to
                consumerPort ::> controlNetwork.shipControllerCommandPort;

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

                action logicalInitializePowerGrid {
                    doc /*
                        * Relays power from the energyStore to the modules 
                        */
                    
                    first start;
                    then action logicalPowerUpPowerGrid;
                    then action monitorPowerInGrid;  
                }
                    
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
                port extensionModulesManagementArrayPort :>> commandControlGallentePort;
                port rigCoupler1CommandPort :>> commandControlGallentePort;
                port rigCoupler2CommandPort :>> commandControlGallentePort;
                port rigCoupler3CommandPort :>> commandControlGallentePort;
                port droneManagerCommandPort :>> commandControlGallentePort;
                port podManagerCommandPort :>> commandControlGallentePort;
                port warpGeneratorCommandPort :>> commandControlGallentePort;

                action logicalInitializeControlNetwork {
                    doc /*
                        * Relays power from the energyStore to the modules 
                        */
                    
                    first start;
                    then action logicalPowerUpControlNetwork;
                    then action relayControlCommands {
                        in relayControlCommandsPort1 : ~LogicalShipControlPort = shipControllerCommandPort;
                        in shipControllerControlCommand : LogicalControlCommand = shipControllerCommandPort.shipControl;        
                        
                        action verifyControlCommand {
                            in command = shipControllerControlCommand;
                            out verifiedCommand;
                        }
                        then send verifyControlCommand.verifiedCommand via relayControlCommandsPort1;
                    }
                    then action relayShipReports {
                        in relayControlCommandsPort : ~LogicalShipControlPort = shipControllerCommandPort;
                        out shipControllerShipReport : LogicalShipReport = shipControllerCommandPort.shipReport;

                        action acceptShipReport accept controlNetworkShipReport : LogicalControlCommand via relayControlCommandsPort;
                        then action verifyReport {
                            in report = acceptShipReport.controlNetworkShipReport;
                            out verifiredReport = shipControllerShipReport;
                        }
                    }    
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
                    then action logicalPowerUpControlNetwork;
                    then action monitorUsageCPU;
                }
            }

            //connectivity of logical infrastructure parts with logical application parts
            interface : LogicalControlIF connect
                supplierPort ::> controlNetwork.extensionModulesManagementArrayPort to
                consumerPort ::> extensionModulesManagementArray.controlNetworkPort; 

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

            //computation network connectors
            //From ShipProcessor to network and from there to all modules
            interface : LogicalComputationServicesIF connect
                supplierPort ::> shipProcessor.computationNetwork to
                consumerPort ::> computationNetwork.shipProcessor;
            
            interface : LogicalComputationServicesIF connect
                supplierPort ::> computationNetwork.highPowerSlotCoupling1Port to
                consumerPort ::> highPowerSlotCoupling1.computationNetworkPort;

            interface : LogicalComputationServicesIF connect
                supplierPort ::> computationNetwork.highPowerSlotCoupling2Port to
                consumerPort ::> highPowerSlotCoupling2.computationNetworkPort;

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

            
            //Behavior of the logical ship
            exhibit logicalMiningFrigateStates {
                    in shipControllerCommandPort;
                    in shipWarpBubbleEnd = warpBubbleEnd;
            }
        }
    }
    package LogicalBehavior {
        //Logical behavior inherited from the mining frigate definition
        //Venture class Behavior redefines imperial spaceship behavior 
        //(being a contsraint for any spaceship) with manufacturer's technology 
        
        state logicalMiningFrigateStates {
            doc /*
                * This state defines the controll behavior of the ship
                */
            in shipControllerCommandPort : ~LogicalShipControlPort;
            in shipWarpBubbleEnd : Boolean;
            
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
                accept boardShip :>> boardShip via shipControllerCommandPort
                then LogicalBoarded;
            
            transition logicalMiningFrigate_boarded_to_parked
                first LogicalBoarded
                accept unboardShip :>> unboardShip via shipControllerCommandPort
                then LogicalParked;
            
            transition logicalMiningFrigate_boarded_to_inGrid
                first LogicalBoarded
                accept pilotPodUndockCommandSig :>> pilotPodUndockCommandSig via shipControllerCommandPort
                do action logicalStartUpSequence
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
            
            //action logicalShutDownSequence;                
        }        
    }      
}