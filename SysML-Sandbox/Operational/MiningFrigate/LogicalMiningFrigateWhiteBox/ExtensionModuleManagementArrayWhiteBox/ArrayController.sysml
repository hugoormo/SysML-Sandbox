package ArrayControllerGrayBox {
    
    private import ExtensionModuleManagementArrayGrayBox::LogicalWhiteBoxMiningFrigateVentureClass::*;
    private import ExtensionModuleManagerGrayBox::*;
    private import MuxDeMuxGrayBox::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def ExtensionModulesManagementArrayWhiteBox :> ExtensionModulesManagementArrayGrayBox {
        
        part arrayControllerGrayBox :> arrayController {

            port :>> lowPowerSupplyUnit : ~LogicalLowPowerLinePort;

            action :>> logicalInitializeExtensionModulesManagementArray {
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

                    perform MuxDeMuxGrayBox::ExtensionModulesManagementArrayWhiteBox::muxDeMuxGrayBox::logicalInitializeDeMux;
                    perform ExtensionModuleManagerGrayBox::ExtensionModulesManagementArrayWhiteBox::extensionModuleManager1GrayBox.logicalInitializeExtensionModule1;
                    perform ExtensionModuleManagerGrayBox::ExtensionModulesManagementArrayWhiteBox::extensionModuleManager2GrayBox.logicalInitializeExtensionModule2;
                    perform ExtensionModuleManagerGrayBox::ExtensionModulesManagementArrayWhiteBox::extensionModuleManager3GrayBox.logicalInitializeExtensionModule3;
                    perform ExtensionModuleManagerGrayBox::ExtensionModulesManagementArrayWhiteBox::extensionModuleManager4GrayBox.logicalInitializeExtensionModule4;
                    perform ExtensionModuleManagerGrayBox::ExtensionModulesManagementArrayWhiteBox::extensionModuleManager5GrayBox.logicalInitializeExtensionModule5;
                    perform ExtensionModuleManagerGrayBox::ExtensionModulesManagementArrayWhiteBox::extensionModuleManager6GrayBox.logicalInitializeExtensionModule6;
                    perform ExtensionModuleManagerGrayBox::ExtensionModulesManagementArrayWhiteBox::extensionModuleManager7GrayBox.logicalInitializeExtensionModule7;
                }
            }
    }
}