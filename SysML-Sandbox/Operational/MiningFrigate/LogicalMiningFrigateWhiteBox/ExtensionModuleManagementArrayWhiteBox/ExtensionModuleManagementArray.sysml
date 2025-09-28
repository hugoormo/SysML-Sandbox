package ExtensionModuleManagementArrayWhiteBox {
    
    private import ExtensionModuleManagementArrayGrayBox::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part extensionModulesManagementArrayGrayBox :> logicalWhiteBoxMiningFrigateVentureClass.extensionModulesManagementArray {
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
        port extensionModulesLowPowerGridPort :>> lowPowerGridPort :>> extensionModulesLowPowerGridPort;

        connect arrayController.logicalInitializeExtensionModulesManagementArray to extensionModuleManager1.logicalInitializeExtensionModule1;

        part arrayController : LogicalPart {

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

                    perform extensionModuleManager1.logicalInitializeExtensionModule1 {
                        in muxDeMuxPort = extensionModuleManager1.muxDeMuxPort;
                        in extensionSlotPort = extensionModuleManager1.extensionSlotPort;
                        
                    }
                    perform extensionModuleManager2.logicalInitializeExtensionModule2 {
                        in muxDeMuxPort = extensionModuleManager2.muxDeMuxPort;
                        in extensionSlotPort = extensionModuleManager2.extensionSlotPort;
                        
                    }
                    perform extensionModuleManager3.logicalInitializeExtensionModule3 {
                        in muxDeMuxPort = extensionModuleManager3.muxDeMuxPort;
                        in extensionSlotPort = extensionModuleManager3.extensionSlotPort;
                        
                    }
                    perform extensionModuleManager4.logicalInitializeExtensionModule4 {
                        in muxDeMuxPort = extensionModuleManager4.muxDeMuxPort;
                        in extensionSlotPort = extensionModuleManager4.extensionSlotPort;
                        
                    }
                    perform extensionModuleManager5.logicalInitializeExtensionModule5 {
                        in muxDeMuxPort = extensionModuleManager5.muxDeMuxPort;
                        in extensionSlotPort = extensionModuleManager5.extensionSlotPort;
                        
                    }
                    perform extensionModuleManager6.logicalInitializeExtensionModule6 {
                        in muxDeMuxPort = extensionModuleManager6.muxDeMuxPort;
                        in extensionSlotPort = extensionModuleManager6.extensionSlotPort;
                        
                    }
                    perform extensionModuleManager7.logicalInitializeExtensionModule7 {
                        in muxDeMuxPort = extensionModuleManager7.muxDeMuxPort;
                        in extensionSlotPort = extensionModuleManager7.extensionSlotPort;
                        
                    }

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
            
            action logicalPowerUpextensionModuleManagerArray;
        }
        
        abstract part extensionModuleManager[7] : LogicalPart {
            
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
            port :>> extensionSlotPort;

            action logicalInitializeExtensionModule1 :>> logicalInitializeExtensionModule;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager1.muxDeMuxPort to
                consumerPort ::> logicalInitializeExtensionModule1.muxDeMuxPort;
            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager1.extensionSlotPort to
                consumerPort ::> logicalInitializeExtensionModule1.extensionSlotPort;                 
        }
        part extensionModuleManager2 :> extensionModuleManager {
            port :>> extensionSlotPort;

            action logicalInitializeExtensionModule2 :>> logicalInitializeExtensionModule;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager2.muxDeMuxPort to
                consumerPort ::> logicalInitializeExtensionModule2.muxDeMuxPort;
            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager2.extensionSlotPort to
                consumerPort ::> logicalInitializeExtensionModule2.extensionSlotPort;  
        }
        part extensionModuleManager3 :> extensionModuleManager {
            port :>> extensionSlotPort;
            
            action logicalInitializeExtensionModule3 :>> logicalInitializeExtensionModule;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager3.muxDeMuxPort to
                consumerPort ::> logicalInitializeExtensionModule3.muxDeMuxPort;
            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager3.extensionSlotPort to
                consumerPort ::> logicalInitializeExtensionModule3.extensionSlotPort;  
        }
        part extensionModuleManager4 :> extensionModuleManager {
            port :>> extensionSlotPort;

            action logicalInitializeExtensionModule4 :>> logicalInitializeExtensionModule;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager4.muxDeMuxPort to
                consumerPort ::> logicalInitializeExtensionModule4.muxDeMuxPort;
            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager4.extensionSlotPort to
                consumerPort ::> logicalInitializeExtensionModule4.extensionSlotPort;  
        }
        part extensionModuleManager5 :> extensionModuleManager {
            port :>> extensionSlotPort;

            action logicalInitializeExtensionModule5 :>> logicalInitializeExtensionModule;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager5.muxDeMuxPort to
                consumerPort ::> logicalInitializeExtensionModule5.muxDeMuxPort;
            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager5.extensionSlotPort to
                consumerPort ::> logicalInitializeExtensionModule5.extensionSlotPort;  
        }
        part extensionModuleManager6 :> extensionModuleManager {
            port :>> extensionSlotPort;

            action logicalInitializeExtensionModule6 :>> logicalInitializeExtensionModule;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager6.muxDeMuxPort to
                consumerPort ::> logicalInitializeExtensionModule6.muxDeMuxPort;
            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager6.extensionSlotPort to
                consumerPort ::> logicalInitializeExtensionModule6.extensionSlotPort; 
        }
        part extensionModuleManager7 :> extensionModuleManager {
            port :>> extensionSlotPort;

            action logicalInitializeExtensionModule7 :>> logicalInitializeExtensionModule;

            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager7.muxDeMuxPort to
                consumerPort ::> logicalInitializeExtensionModule7.muxDeMuxPort;
            interface : LogicalControlIF connect
                supplierPort ::> extensionModuleManager7.extensionSlotPort to
                consumerPort ::> logicalInitializeExtensionModule7.extensionSlotPort;  
        }
        
        bind commandNetworkPort = muxDeMux.commandNetworkPort;
        bind extensionModuleManager1.extensionSlotPort = extensionModule1ControlPort;
        bind extensionModuleManager2.extensionSlotPort = extensionModule2ControlPort;
        bind extensionModuleManager3.extensionSlotPort = extensionModule3ControlPort;
        bind extensionModuleManager4.extensionSlotPort = extensionModule4ControlPort;
        bind extensionModuleManager5.extensionSlotPort = extensionModule5ControlPort;
        bind extensionModuleManager6.extensionSlotPort = extensionModule6ControlPort;
        bind extensionModuleManager7.extensionSlotPort = extensionModule7ControlPort;
        bind extensionModulesLowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;

        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule1ControlPort to
            consumerPort ::> extensionModuleManager1.muxDeMuxPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule2ControlPort to
            consumerPort ::> extensionModuleManager2.muxDeMuxPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule3ControlPort to
            consumerPort ::> extensionModuleManager3.muxDeMuxPort;  
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule4ControlPort to
            consumerPort ::> extensionModuleManager4.muxDeMuxPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule5ControlPort to
            consumerPort ::> extensionModuleManager5.muxDeMuxPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule6ControlPort to
            consumerPort ::> extensionModuleManager6.muxDeMuxPort; 
        interface : LogicalControlIF connect
            supplierPort ::> muxDeMux.extensionModule7ControlPort to
            consumerPort ::> extensionModuleManager7.muxDeMuxPort; 

    }
    
}