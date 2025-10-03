package ExtensionModuleManagerGrayBox {
    
    private import ExtensionModuleManagementArrayGrayBox::LogicalWhiteBoxMiningFrigateVentureClass::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def ExtensionModulesManagementArrayWhiteBox :> ExtensionModulesManagementArrayGrayBox {

        abstract part extensionModuleManagerGrayBox[7] : LogicalPart {
                
                port extensionSlotPort : LogicalModuleCommandPort :>> commandControlGallentePort;
                port muxDeMuxPort : ~LogicalModuleCommandPort :>> commandControlGallentePort;
                port lowPowerSupplyUnitPort :>> lowPowerLinePort;

                action def LogicalInitializeExtensionModule {
                    doc /*
                        * Initialize the extension modules of the ship.
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
                        out moduleReport : LogicalModuleReport; //reports back name of the module, overheat, cycle time
                        in providedModuleCommand : ModuleToggleCommand; //provides the ModuleToggleCommand for this module
                    }
                    then action logicalEnableModuleServices;
                    then action acceptLogicalModuleCommand accept LogicalModuleToggleCommand via muxDeMuxPort.moduleToggleCommand;
                    then action generateModuleCommand {
                        in logicalModuleCommand = acceptLogicalModuleCommand;
                        in providedModuleCommand = logicalDiagnoseModule.providedModuleCommand;
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

        part extensionModuleManager1GrayBox :> extensionModuleManagerGrayBox {        
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            perform action logicalInitializeExtensionModule1 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            }                 
        }
        part extensionModuleManager2GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            perform action logicalInitializeExtensionModule2 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            } 
        }
        part extensionModuleManager3GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            perform action logicalInitializeExtensionModule3 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            } 
        }
        part extensionModuleManager4GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            perform action logicalInitializeExtensionModule4 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            } 
        }
        part extensionModuleManager5GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            perform action logicalInitializeExtensionModule5 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            }
        }
        part extensionModuleManager6GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            perform action logicalInitializeExtensionModule6 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            }
        }
        part extensionModuleManager7GrayBox :> extensionModuleManagerGrayBox {
            port extensionSlotProxyPort :>> extensionSlotPort;
            port muxDeMuxProxyPort :>> muxDeMuxPort;

            perform action logicalInitializeExtensionModule7 : LogicalInitializeExtensionModule {
                in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
                in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
            } 
        }
    }   
}