package ExtensionModuleManagementArray {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part logicalMiningFrigateVentureClass : LogicalMiningFrigateVentureClass {

        part extensionModulesManagementArray : LogicalPart :>> extensionModulesManagementArray {
            doc /*
                * Initializes and manages the extension modules
                */
            port :>> commandNetworkPort;
            port :>> extensionModule1ControlPort;
            port :>> extensionModule2ControlPort;
            port :>> extensionModule3ControlPort;
            port :>> extensionModule4ControlPort;
            port :>> extensionModule5ControlPort;
            port :>> extensionModule6ControlPort;
            port :>> extensionModule7ControlPort;

            abstract part extensionModuleManager[7] : LogicalPart {
                
                port extensionSlotPort :>> commandControlGallentePort;
                port deMuxPort : ~LogicalShipCommandPort :>> commandControlGallentePort;

                action logicalInitializeExtensionModule {
                    doc /*
                        * Initialize the extension modules of the ship as per the ship configuration
                        */
                    in moduleServicesCommandPort : LogicalShipCommandPort;
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
                        out commandModule : LogicalModuleToggleCommand;
                    }
                    then accept logicalEnableModuleServices.commandModule;
                    then perform action logicalModuleFunction ::> logicalEnableModuleServices.moduleToEnable.imperialStandardModuleAction;
                    then accept logicalModuleFunction.moduleReport;
                    then action logicalReportStatusModule {
                        in moduleReport = logicalModuleFunction.moduleReport; 
                        out shipReport : LogicalShipReport;
                    }
                    then send logicalReportStatusModule.shipReport via moduleServicesCommandPort;
                }
            }

            part muxDeMux : LogicalPart {
                port commandNetworkPort : ~LogicalShipCommandPort :>> commandControlGallentePort;
                
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
                        in relayControlCommandsPort : ~LogicalShipCommandPort = commandNetworkPort;
                        in shipControllerControlCommand : LogicalControlCommand = commandNetworkPort.shipControl;        
                        
                        action verifyControlCommand {
                            in command = shipControllerControlCommand;
                            out verifiedCommand;
                        }
                        then send verifyControlCommand.verifiedCommand via relayControlCommandsPort;
                    }
                    then action relayShipReports {
                        in relayControlCommandsPort : ~LogicalShipCommandPort = commandNetworkPort;
                        out shipControllerShipReport : LogicalShipReport = commandNetworkPort.shipReport;

                        action acceptShipReport accept commandNetworkShipReport : LogicalControlCommand via relayControlCommandsPort;
                        then action verifyReport {
                            in report = acceptShipReport.commandNetworkShipReport;
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
            
            bind commandNetworkPort = muxDeMux.commandNetworkPort;
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

            action :>> logicalInitializeExtensionModulesManagementArray {
                doc /*
                    * Initializes the modules configured in the ship.
                    */
                in :>> modulesServicesCommandPort : LogicalShipCommandPort;
                first start;
                then fork; 
                    then muxDeMux.logicalInitializeDeMux;                  
                    then extensionModuleManager1.logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = extensionModuleManager1.extensionSlotPort;
                        in module = LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot1;
                    }
                    then extensionModuleManager2.logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot2;
                    }
                    then extensionModuleManager3.logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalMiningFrigateVentureClass::configurationManager::highPowerSlot3;
                    }
                    then extensionModuleManager4.logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot1;
                    }
                    then extensionModuleManager5.logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot2;
                    }
                    then extensionModuleManager6.logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalMiningFrigateVentureClass::configurationManager::midPowerSlot3;
                    }
                    then extensionModuleManager7.logicalInitializeExtensionModule {
                        in moduleServicesCommandPort = modulesServicesCommandPort;
                        in module = LogicalMiningFrigateVentureClass::configurationManager::lowPowerSlot1;
                    }                     
            }
        }
    }
}