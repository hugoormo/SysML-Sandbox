package ExtensionModuleManagementArrayGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {

        part extensionModulesManagementArrayGrayBox : LogicalPart :> extensionModulesManagementArray;

        part def ExtensionModulesManagementArrayGrayBox :> LogicalPart {
            doc /*
                * Initializes and manages the extension modules
                */
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port extensionModule1ControlPort :>> commandControlGallentePort;
            port extensionModule2ControlPort :>> commandControlGallentePort;
            port extensionModule3ControlPort :>> commandControlGallentePort;
            port extensionModule4ControlPort :>> commandControlGallentePort;
            port extensionModule5ControlPort :>> commandControlGallentePort;
            port extensionModule6ControlPort :>> commandControlGallentePort;
            port extensionModule7ControlPort :>> commandControlGallentePort;
            port extensionModulesLowPowerGridPort :>> lowPowerGridPort;

            part arrayController : LogicalPart {
                port lowPowerSupplyUnit : ~LogicalLowPowerLinePort :>> lowPowerLinePort;

                perform logicalInitializeExtensionModulesManagementArray {
                    in commandNetworkProxyPort : ~LogicalShipCommandPort;
                    in module1ControlProxyPort : LogicalModuleCommandPort;
                    in module2ControlProxyPort : LogicalModuleCommandPort;
                    in module3ControlProxyPort : LogicalModuleCommandPort;
                    in module4ControlProxyPort : LogicalModuleCommandPort;
                    in module5ControlProxyPort : LogicalModuleCommandPort;
                    in module6ControlProxyPort : LogicalModuleCommandPort;
                    in module7ControlProxyPort : LogicalModuleCommandPort;
                }
            }

            part lowPowerSupplyUnit : LogicalPart {              
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port arrayControllerPort :>> lowPowerLinePort;
                port muxDeMuxPort :>> lowPowerLinePort;
                port extensionModuleManager1Port :>> lowPowerLinePort;
                port extensionModuleManager2Port :>> lowPowerLinePort;
                port extensionModuleManager3Port :>> lowPowerLinePort;
                port extensionModuleManager4Port :>> lowPowerLinePort;
                port extensionModuleManager5Port :>> lowPowerLinePort;
                port extensionModuleManager6Port :>> lowPowerLinePort;
                port extensionModuleManager7Port :>> lowPowerLinePort;
                
                perform logicalInitializeExtensionModulesManagementArray.logicalPowerUpextensionModuleManagerArray;
            }
            
            abstract part extensionModuleManager[7] : LogicalPart {             
                port extensionSlotPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port muxDeMuxPort : ~LogicalModuleCommandPort :>> commandControlGallentePort;
                port lowPowerSupplyUnitPort :>> lowPowerLinePort;
            }

            part muxDeMux : LogicalPart {
                port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
                port extensionModule1ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port extensionModule2ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port extensionModule3ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port extensionModule4ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port extensionModule5ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port extensionModule6ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port extensionModule7ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port lowPowerSupplyUnitPort :>> lowPowerLinePort; 

                perform logicalInitializeExtensionModulesManagementArray.logicalInitializeDeMux {
                    in commandNetworkProxyPort : ~LogicalShipCommandPort = commandNetworkPort;
                    in extensionModule1ControlProxyPort : LogicalModuleCommandPort = extensionModule1ControlPort;
                    in extensionModule2ControlProxyPort : LogicalModuleCommandPort = extensionModule2ControlPort;
                    in extensionModule3ControlProxyPort : LogicalModuleCommandPort = extensionModule3ControlPort;
                    in extensionModule4ControlProxyPort : LogicalModuleCommandPort = extensionModule4ControlPort;
                    in extensionModule5ControlProxyPort : LogicalModuleCommandPort = extensionModule5ControlPort;
                    in extensionModule6ControlProxyPort : LogicalModuleCommandPort = extensionModule6ControlPort;
                    in extensionModule7ControlProxyPort : LogicalModuleCommandPort = extensionModule7ControlPort;               
                }
            }

            part lowPowerWiring : LogicalPart {
                ref lowPowerSupplyUnit :>> lowPowerSupplyUnit;
                ref arrayController :>> arrayController;
                ref muxDeMux :>> muxDeMux;
                ref extensionModuleManager1 :>> extensionModuleManager1;
                ref extensionModuleManager2 :>> extensionModuleManager1;
                ref extensionModuleManager3 :>> extensionModuleManager1;
                ref extensionModuleManager4 :>> extensionModuleManager1;
                ref extensionModuleManager5 :>> extensionModuleManager1;
                ref extensionModuleManager6 :>> extensionModuleManager1;
                ref extensionModuleManager7 :>> extensionModuleManager1;  

                //Low power wiring
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.arrayControllerPort to
                    consumerPort ::> arrayController.lowPowerSupplyUnit;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.muxDeMuxPort to
                    consumerPort ::> muxDeMux.lowPowerSupplyUnitPort;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.extensionModuleManager1Port to
                    consumerPort ::> extensionModuleManager1.lowPowerSupplyUnitPort;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.extensionModuleManager2Port to
                    consumerPort ::> extensionModuleManager2.lowPowerSupplyUnitPort;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.extensionModuleManager3Port to
                    consumerPort ::> extensionModuleManager3.lowPowerSupplyUnitPort;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.extensionModuleManager4Port to
                    consumerPort ::> extensionModuleManager4.lowPowerSupplyUnitPort;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.extensionModuleManager5Port to
                    consumerPort ::> extensionModuleManager5.lowPowerSupplyUnitPort;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.extensionModuleManager6Port to
                    consumerPort ::> extensionModuleManager6.lowPowerSupplyUnitPort;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.extensionModuleManager7Port to
                    consumerPort ::> extensionModuleManager7.lowPowerSupplyUnitPort;               
            }

            part extensionModuleManager1 :> extensionModuleManager {        
                port extensionSlotProxyPort :>> extensionSlotPort;
                port muxDeMuxProxyPort :>> muxDeMuxPort;

                perform logicalInitializeExtensionModulesManagementArray.logicalInitializeExtensionModule1 {
                    in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                    in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
                }                 
            }
            part extensionModuleManager2 :> extensionModuleManager {
                port extensionSlotProxyPort :>> extensionSlotPort;
                port muxDeMuxProxyPort :>> muxDeMuxPort;

                perform logicalInitializeExtensionModulesManagementArray.logicalInitializeExtensionModule2 {
                    in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                    in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
                } 
            }
            part extensionModuleManager3 :> extensionModuleManager {
                port extensionSlotProxyPort :>> extensionSlotPort;
                port muxDeMuxProxyPort :>> muxDeMuxPort;
                
                perform logicalInitializeExtensionModulesManagementArray.logicalInitializeExtensionModule3 {
                    in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                    in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
                } 
            }
            part extensionModuleManager4 :> extensionModuleManager {
                port extensionSlotProxyPort :>> extensionSlotPort;
                port muxDeMuxProxyPort :>> muxDeMuxPort;

                perform logicalInitializeExtensionModulesManagementArray.logicalInitializeExtensionModule4 {
                    in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                    in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
                } 
            }
            part extensionModuleManager5 :> extensionModuleManager {
                port extensionSlotProxyPort :>> extensionSlotPort;
                port muxDeMuxProxyPort :>> muxDeMuxPort;

                perform logicalInitializeExtensionModulesManagementArray.logicalInitializeExtensionModule5 {
                    in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                    in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
                }
            }
            part extensionModuleManager6 :> extensionModuleManager {
                port extensionSlotProxyPort :>> extensionSlotPort;
                port muxDeMuxProxyPort :>> muxDeMuxPort;

                perform logicalInitializeExtensionModulesManagementArray.logicalInitializeExtensionModule6 {
                    in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                    in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
                }
            }
            part extensionModuleManager7 :> extensionModuleManager {
                port extensionSlotProxyPort :>> extensionSlotPort;
                port muxDeMuxProxyPort :>> muxDeMuxPort;

                perform logicalInitializeExtensionModulesManagementArray.logicalInitializeExtensionModule7 {
                    in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                    in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
                } 
            }
            
            bind commandNetworkPort = muxDeMux.commandNetworkPort;
            bind extensionModuleManager1.extensionSlotProxyPort = extensionModule1ControlPort;
            bind extensionModuleManager2.extensionSlotProxyPort = extensionModule2ControlPort;
            bind extensionModuleManager3.extensionSlotProxyPort = extensionModule3ControlPort;
            bind extensionModuleManager4.extensionSlotProxyPort = extensionModule4ControlPort;
            bind extensionModuleManager5.extensionSlotProxyPort = extensionModule5ControlPort;
            bind extensionModuleManager6.extensionSlotProxyPort = extensionModule6ControlPort;
            bind extensionModuleManager7.extensionSlotProxyPort = extensionModule7ControlPort;
            bind extensionModulesLowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;

            interface : LogicalControlIF connect
                supplierPort ::> muxDeMux.extensionModule1ControlPort to
                consumerPort ::> extensionModuleManager1.muxDeMuxProxyPort; 
            interface : LogicalControlIF connect
                supplierPort ::> muxDeMux.extensionModule2ControlPort to
                consumerPort ::> extensionModuleManager2.muxDeMuxProxyPort; 
            interface : LogicalControlIF connect
                supplierPort ::> muxDeMux.extensionModule3ControlPort to
                consumerPort ::> extensionModuleManager3.muxDeMuxProxyPort;  
            interface : LogicalControlIF connect
                supplierPort ::> muxDeMux.extensionModule4ControlPort to
                consumerPort ::> extensionModuleManager4.muxDeMuxProxyPort; 
            interface : LogicalControlIF connect
                supplierPort ::> muxDeMux.extensionModule5ControlPort to
                consumerPort ::> extensionModuleManager5.muxDeMuxProxyPort; 
            interface : LogicalControlIF connect
                supplierPort ::> muxDeMux.extensionModule6ControlPort to
                consumerPort ::> extensionModuleManager6.muxDeMuxProxyPort; 
            interface : LogicalControlIF connect
                supplierPort ::> muxDeMux.extensionModule7ControlPort to
                consumerPort ::> extensionModuleManager7.muxDeMuxProxyPort; 

            //behavior of the graybox extensionModulesManagementArray    
            action logicalInitializeExtensionModulesManagementArray {
                in commandNetworkProxyPort : ~LogicalShipCommandPort;
                in module1ControlProxyPort : LogicalModuleCommandPort;
                in module2ControlProxyPort : LogicalModuleCommandPort;
                in module3ControlProxyPort : LogicalModuleCommandPort;
                in module4ControlProxyPort : LogicalModuleCommandPort;
                in module5ControlProxyPort : LogicalModuleCommandPort;
                in module6ControlProxyPort : LogicalModuleCommandPort;
                in module7ControlProxyPort : LogicalModuleCommandPort;
                doc /*
                    * Initializes the modules configured in the ship.
                    */
                first start;
                then action logicalPowerUpextensionModuleManagerArray;
                then fork; 
                    then logicalInitializeDeMux;                  
                    then logicalInitializeExtensionModule1;
                    then logicalInitializeExtensionModule2;
                    then logicalInitializeExtensionModule3;
                    then logicalInitializeExtensionModule4;
                    then logicalInitializeExtensionModule5;
                    then logicalInitializeExtensionModule6;
                    then logicalInitializeExtensionModule7; 
            
                action logicalInitializeDeMux {
                    
                    first start;
                    then action logicalPowerUpDeMux;
                    then fork;
                        then relayCommandsAndReports1;
                        then relayCommandsAndReports2;
                        then relayCommandsAndReports3;
                        then relayCommandsAndReports4;
                        then relayCommandsAndReports5;
                        then relayCommandsAndReports6;
                        then relayCommandsAndReports7;
                        action relayCommandsAndReports1 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module1ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = module1ControlProxyPort;
                        }
                        action relayCommandsAndReports2 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module2ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = module2ControlProxyPort;
                        }
                        action relayCommandsAndReports3 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module3ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = module3ControlProxyPort;
                        }
                        action relayCommandsAndReports4 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module4ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = module4ControlProxyPort;
                        }
                        action relayCommandsAndReports5 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module5ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = module5ControlProxyPort;
                        }
                        action relayCommandsAndReports6 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module6ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = module6ControlProxyPort;
                        }
                        action relayCommandsAndReports7 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module7ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = module7ControlProxyPort;
                        }
                }

                action logicalInitializeExtensionModule1 : LogicalInitializeExtensionModule;
                action logicalInitializeExtensionModule2 : LogicalInitializeExtensionModule;
                action logicalInitializeExtensionModule3 : LogicalInitializeExtensionModule;
                action logicalInitializeExtensionModule4 : LogicalInitializeExtensionModule;
                action logicalInitializeExtensionModule5 : LogicalInitializeExtensionModule;
                action logicalInitializeExtensionModule6 : LogicalInitializeExtensionModule;
                action logicalInitializeExtensionModule7 : LogicalInitializeExtensionModule;
            }
            action def RelayCommandsAndReports {          
                in commandNetworkPort : LogicalModuleCommandPort; 
                in extensionModuleControlCommandPort : LogicalModuleCommandPort;      
                
                first start;
                then fork;
                    action acceptShipCommand accept commandNetworkShipCommand : LogicalControlCommand via commandNetworkPort ;
                    then action verifyControlCommand {
                        in command = acceptShipCommand.commandNetworkShipCommand;
                        out verifiedCommand;
                    }
                    then send verifyControlCommand.verifiedCommand via extensionModuleControlCommandPort;

                    action acceptShipReport accept commandNetworkShipReport : LogicalControlCommand via extensionModuleControlCommandPort;
                    then action verifyReport {
                        in report = acceptShipReport.commandNetworkShipReport;
                        out verifiredReport = extensionModuleControlCommandPort;
                    }
                    then send verifyReport.verifiredReport via commandNetworkPort ;
            }
            action def LogicalInitializeExtensionModule {
                doc /*
                    * Initialize the extension modules of the ship as per the ship configuration
                    */
                in muxDeMuxPort : ~LogicalModuleCommandPort;
                in extensionSlotPort : LogicalModuleCommandPort;

                first start; 
                then action logicalPowerUpModule {
                    out poweredUp : Boolean;
                }
                then decide;
                    if logicalPowerUpModule.poweredUp then logicalDiagnoseModule;
                    else stop;
                action stop terminate;
                then action logicalDiagnoseModule {
                    out moduleReport : LogicalModuleReport;
                    //reports back name of the module, overheat, cycle time
                }
                then action logicalEnableModuleServices {
                    
                }
                then action acceptLogicalModuleCommand accept LogicalModuleToggleCommand via muxDeMuxPort.moduleToggleCommand;
                then action generateModuleCommand {
                    in logicalModuleCommand = acceptLogicalModuleCommand;
                    out moduleCommand;
                }
                then send generateModuleCommand.moduleCommand via extensionSlotPort.moduleToggleCommand; 
                then action acceptModuleReport accept ModuleReport via extensionSlotPort.moduleReport;
                then action logicalReportStatusModule {
                    in moduleReport = acceptModuleReport; 
                    out shipReport : LogicalShipReport;
                }
                then send logicalReportStatusModule.shipReport via muxDeMuxPort.moduleReport;
            }
        }
    }
}