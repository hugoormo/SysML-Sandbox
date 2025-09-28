package ArrayControllerGrayBox {
    
    private import ExtensionModuleManagementArrayWhiteBox::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part extensionModulesManagementArray : LogicalPart :> extensionModulesManagementArray {
        part arrayControllerGrayBox : LogicalPart :> extensionModulesManagementArrayGrayBox.arrayController {

            port :>> lowPowerSupplyUnit : ~LogicalLowPowerLinePort;

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
    }
}