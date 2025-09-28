package LowPowerSupplyUnitGrayBox {
    
    private import ExtensionModuleManagementArrayWhiteBox::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part lowPowerSupplyUnit : LogicalPart :> extensionModulesManagementArrayGrayBox.lowPowerSupplyUnit {
            
            port :>> lowPowerGridPort : ~LogicalLowPowerGridPort;
            port :>> arrayControllerPort;
            port :>> muxDeMuxPort;
            port :>> extensionModuleManager1Port;
            port :>> extensionModuleManager2Port;
            port :>> extensionModuleManager3Port;
            port :>> extensionModuleManager4Port;
            port :>> extensionModuleManager5Port;
            port :>> extensionModuleManager6Port;
            port :>> extensionModuleManager7Port;
            
            action :>> logicalPowerUpextensionModuleManagerArray;
    }
}