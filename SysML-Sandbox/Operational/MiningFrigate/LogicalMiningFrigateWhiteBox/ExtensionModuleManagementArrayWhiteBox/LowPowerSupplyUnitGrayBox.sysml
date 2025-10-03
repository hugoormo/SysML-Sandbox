package LowPowerSupplyUnitGrayBox {
    
    private import ExtensionModuleManagementArrayGrayBox::LogicalWhiteBoxMiningFrigateVentureClass::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def ExtensionModulesManagementArrayWhiteBox :> ExtensionModulesManagementArrayGrayBox {

        part lowPowerSupplyUnitGrayBox : LogicalPart :> lowPowerSupplyUnit {
                
                port  lowPowerSupplyGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port :>> arrayControllerPort;
                port :>> muxDeMuxPort;
                port :>> extensionModuleManager1Port;
                port :>> extensionModuleManager2Port;
                port :>> extensionModuleManager3Port;
                port :>> extensionModuleManager4Port;
                port :>> extensionModuleManager5Port;
                port :>> extensionModuleManager6Port;
                port :>> extensionModuleManager7Port;
                
                perform action :>> logicalPowerUpextensionModuleManagerArray;
        }
    }
}