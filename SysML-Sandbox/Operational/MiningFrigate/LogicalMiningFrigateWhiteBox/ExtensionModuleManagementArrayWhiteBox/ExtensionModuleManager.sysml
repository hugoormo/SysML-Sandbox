package ExtensionModuleManagerGrayBox {
    
    private import ExtensionModuleManagementArrayWhiteBox::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    abstract part extensionModuleManager[7] : LogicalPart {
            
            port extensionSlotPort : LogicalModuleCommandPort :>> commandControlGallentePort;
            port muxDeMuxPort : ~LogicalModuleCommandPort :>> commandControlGallentePort;
            port lowPowerSupplyUnitPort :>> lowPowerLinePort;

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

    part extensionModuleManager1 :> extensionModuleManager {        
        port extensionSlotProxyPort :>> extensionSlotPort;
        port muxDeMuxProxyPort :>> muxDeMuxPort;

        action logicalInitializeExtensionModule : LogicalInitializeExtensionModule {
            in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
            in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
        }                 
    }
    part extensionModuleManager2 :> extensionModuleManager {
        port extensionSlotProxyPort :>> extensionSlotPort;
        port muxDeMuxProxyPort :>> muxDeMuxPort;

        action logicalInitializeExtensionModule : LogicalInitializeExtensionModule {
            in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
            in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
        } 
    }
    part extensionModuleManager3 :> extensionModuleManager {
        port extensionSlotProxyPort :>> extensionSlotPort;
        port muxDeMuxProxyPort :>> muxDeMuxPort;
        
        action logicalInitializeExtensionModule : LogicalInitializeExtensionModule {
            in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
            in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
        } 
    }
    part extensionModuleManager4 :> extensionModuleManager {
        port extensionSlotProxyPort :>> extensionSlotPort;
        port muxDeMuxProxyPort :>> muxDeMuxPort;

        action logicalInitializeExtensionModule : LogicalInitializeExtensionModule {
            in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
            in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
        } 
    }
    part extensionModuleManager5 :> extensionModuleManager {
        port extensionSlotProxyPort :>> extensionSlotPort;
        port muxDeMuxProxyPort :>> muxDeMuxPort;

        action logicalInitializeExtensionModule : LogicalInitializeExtensionModule {
            in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
            in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
        }
    }
    part extensionModuleManager6 :> extensionModuleManager {
        port extensionSlotProxyPort :>> extensionSlotPort;
        port muxDeMuxProxyPort :>> muxDeMuxPort;

        action logicalInitializeExtensionModule : LogicalInitializeExtensionModule {
            in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
            in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
        }
    }
    part extensionModuleManager7 :> extensionModuleManager {
        port extensionSlotProxyPort :>> extensionSlotPort;
        port muxDeMuxProxyPort :>> muxDeMuxPort;

        action logicalInitializeExtensionModule : LogicalInitializeExtensionModule {
            in muxDeMuxPort : ~LogicalModuleCommandPort = muxDeMuxProxyPort;
            in extensionSlotPort : LogicalModuleCommandPort = extensionSlotProxyPort;
        } 
    }

        
}