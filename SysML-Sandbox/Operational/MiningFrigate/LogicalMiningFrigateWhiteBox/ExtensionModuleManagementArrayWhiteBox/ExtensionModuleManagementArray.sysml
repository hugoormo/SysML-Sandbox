package ExtensionModuleManagementArrayWhiteBox {
    
    private import ExtensionModuleManagementArrayGrayBox::LogicalWhiteBoxMiningFrigateVentureClass::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def ExtensionModulesManagementArrayWhiteBox :> ExtensionModulesManagementArrayGrayBox {
        doc /*
            * Initializes and manages the extension modules
            */
        port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;
        port extensionModule1ControlPort : LogicalModuleCommandPort :>> extensionModule1ControlPort;
        port extensionModule2ControlPort : LogicalModuleCommandPort :>> extensionModule2ControlPort;
        port extensionModule3ControlPort : LogicalModuleCommandPort :>> extensionModule3ControlPort;
        port extensionModule4ControlPort : LogicalModuleCommandPort :>> extensionModule4ControlPort;
        port extensionModule5ControlPort : LogicalModuleCommandPort :>> extensionModule5ControlPort;
        port extensionModule6ControlPort : LogicalModuleCommandPort :>> extensionModule6ControlPort;
        port extensionModule7ControlPort : LogicalModuleCommandPort :>> extensionModule7ControlPort;
        port extensionModulesLowPowerGridPort :>> extensionModulesLowPowerGridPort;


        part arrayControllerGrayBox : LogicalPart {

            port lowPowerSupplyUnit : ~LogicalLowPowerLinePort :>> lowPowerLinePort;

            action logicalInitializeExtensionModulesManagementArray {
                doc /*
                    * Initializes the modules configured in the ship.
                    */
                first start;
                then fork; 
                    then muxDeMux.logicalInitializeDeMux;                  
                    then logicalInitializeExtensionModule1;
                    then logicalInitializeExtensionModule2;
                    then logicalInitializeExtensionModule3;
                    then logicalInitializeExtensionModule4;
                    then logicalInitializeExtensionModule5;
                    then logicalInitializeExtensionModule6;
                    then logicalInitializeExtensionModule7;

                    perform extensionModuleManager1.logicalInitializeExtensionModule1;
                    perform extensionModuleManager2.logicalInitializeExtensionModule2;
                    perform extensionModuleManager3.logicalInitializeExtensionModule3;
                    perform extensionModuleManager4.logicalInitializeExtensionModule4;
                    perform extensionModuleManager5.logicalInitializeExtensionModule5;
                    perform extensionModuleManager6.logicalInitializeExtensionModule6;
                    perform extensionModuleManager7.logicalInitializeExtensionModule7;

            }
        }

        part lowPowerSupplyUnitGrayBox : LogicalPart {
            
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
            
            action logicalPowerUpextensionModuleManagerArray;
        }
        
        abstract part extensionModuleManagerGrayBox[7] : LogicalPart {
            
            port extensionSlotPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port muxDeMuxPort : ~LogicalModuleCommandPort :>> commandControlGallentePort;
            port lowPowerSupplyUnitPort :>> lowPowerLinePort;

            action logicalInitializeExtensionModule {
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

        part muxDeMuxGrayBox : LogicalPart {
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
            port extensionModule1ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port extensionModule2ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port extensionModule3ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port extensionModule4ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port extensionModule5ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port extensionModule6ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port extensionModule7ControlPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port lowPowerSupplyUnitPort :>> lowPowerLinePort; 

            action logicalInitializeDeMux {
                in commandNetworkProxyPort : ~LogicalShipCommandPort = commandNetworkPort;
                in extensionModule1ControlProxyPort : LogicalModuleCommandPort = extensionModule1ControlPort;
                in extensionModule2ControlProxyPort : LogicalModuleCommandPort = extensionModule2ControlPort;
                in extensionModule3ControlProxyPort : LogicalModuleCommandPort = extensionModule3ControlPort;
                in extensionModule4ControlProxyPort : LogicalModuleCommandPort = extensionModule4ControlPort;
                in extensionModule5ControlProxyPort : LogicalModuleCommandPort = extensionModule5ControlPort;
                in extensionModule6ControlProxyPort : LogicalModuleCommandPort = extensionModule6ControlPort;
                in extensionModule7ControlProxyPort : LogicalModuleCommandPort = extensionModule7ControlPort;
                
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
                        in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule1ControlProxyPort;
                    }
                    action relayCommandsAndReports2 : RelayCommandsAndReports {
                        in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module2ToggleCommand;
                        in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule2ControlProxyPort;
                    }
                    action relayCommandsAndReports3 : RelayCommandsAndReports {
                        in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module3ToggleCommand;
                        in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule3ControlProxyPort;
                    }
                    action relayCommandsAndReports4 : RelayCommandsAndReports {
                        in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module4ToggleCommand;
                        in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule4ControlProxyPort;
                    }
                    action relayCommandsAndReports5 : RelayCommandsAndReports {
                        in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module5ToggleCommand;
                        in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule5ControlProxyPort;
                    }
                    action relayCommandsAndReports6 : RelayCommandsAndReports {
                        in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module6ToggleCommand;
                        in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule6ControlProxyPort;
                    }
                    action relayCommandsAndReports7 : RelayCommandsAndReports {
                        in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module7ToggleCommand;
                        in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule7ControlProxyPort;
                    }
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
        }

        part lowPowerWiringGrayBox : LogicalPart {
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

        part extensionModuleManager1GrayBox :> extensionModuleManagerGrayBox {        
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            action logicalInitializeExtensionModule1 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            }                
        }
        part extensionModuleManager2GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            action logicalInitializeExtensionModule2 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            } 
        }
        part extensionModuleManager3GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;
            
            action logicalInitializeExtensionModule3 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            }  
        }
        part extensionModuleManager4GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            action logicalInitializeExtensionModule4 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            }  
        }
        part extensionModuleManager5GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            action logicalInitializeExtensionModule5 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            }  
        }
        part extensionModuleManager6GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            action logicalInitializeExtensionModule6 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            } 
        }
        part extensionModuleManager7GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            action logicalInitializeExtensionModule7 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            }  
        }
        
        bind commandNetworkPort = muxDeMux.commandNetworkPort;
        bind extensionModuleManager1GrayBox.extensionSlotProxyPort = extensionModule1ControlPort;
        bind extensionModuleManager2GrayBox.extensionSlotProxyPort = extensionModule2ControlPort;
        bind extensionModuleManager3GrayBox.extensionSlotProxyPort = extensionModule3ControlPort;
        bind extensionModuleManager4GrayBox.extensionSlotProxyPort = extensionModule4ControlPort;
        bind extensionModuleManager5GrayBox.extensionSlotProxyPort = extensionModule5ControlPort;
        bind extensionModuleManager6GrayBox.extensionSlotProxyPort = extensionModule6ControlPort;
        bind extensionModuleManager7GrayBox.extensionSlotProxyPort = extensionModule7ControlPort;
        bind extensionModulesLowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;

        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule1ControlPort to
            consumerPort ::> extensionModuleManager1GrayBox.muxDeMuxProxyPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule2ControlPort to
            consumerPort ::> extensionModuleManager2GrayBox.muxDeMuxProxyPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule3ControlPort to
            consumerPort ::> extensionModuleManager3GrayBox.muxDeMuxProxyPort;  
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule4ControlPort to
            consumerPort ::> extensionModuleManager4GrayBox.muxDeMuxProxyPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule5ControlPort to
            consumerPort ::> extensionModuleManager5GrayBox.muxDeMuxProxyPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule6ControlPort to
            consumerPort ::> extensionModuleManager6GrayBox.muxDeMuxProxyPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule7ControlPort to
            consumerPort ::> extensionModuleManager7GrayBox.muxDeMuxProxyPort; 

    }
    
}