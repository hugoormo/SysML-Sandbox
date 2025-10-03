package ArrayControllerGrayBox {
    
    private import ExtensionModuleManagementArrayGrayBox::LogicalWhiteBoxMiningFrigateVentureClass::*;
    private import ExtensionModuleManagerGrayBox::ExtensionModulesManagementArrayWhiteBox::*;
    private import MuxDeMuxGrayBox::ExtensionModulesManagementArrayWhiteBox::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def ExtensionModulesManagementArrayWhiteBox :> ExtensionModulesManagementArrayGrayBox {
        
        part arrayControllerGrayBox :> arrayController {

            port :>> lowPowerSupplyUnit : ~LogicalLowPowerLinePort;

            perform action :>> logicalInitializeExtensionModulesManagementArray {
                doc /*
                    * Initializes the modules configured in the ship.
                    */
                first start;
                then fork; 
                    then logicalInitializeDeMux;                  
                    then logicalInitializeExtensionModule1;
                    then logicalInitializeExtensionModule2;
                    then logicalInitializeExtensionModule3;
                    then logicalInitializeExtensionModule4;
                    then logicalInitializeExtensionModule5;
                    then logicalInitializeExtensionModule6;
                    then logicalInitializeExtensionModule7;

                    perform muxDeMuxGrayBox.logicalInitializeMuxDeMux;
                    perform extensionModuleManager1GrayBox.logicalInitializeExtensionModule1;
                    perform extensionModuleManager2GrayBox.logicalInitializeExtensionModule2;
                    perform extensionModuleManager3GrayBox.logicalInitializeExtensionModule3;
                    perform extensionModuleManager4GrayBox.logicalInitializeExtensionModule4;
                    perform extensionModuleManager5GrayBox.logicalInitializeExtensionModule5;
                    perform extensionModuleManager6GrayBox.logicalInitializeExtensionModule6;
                    perform extensionModuleManager7GrayBox.logicalInitializeExtensionModule7;
                }
            }
    }
}