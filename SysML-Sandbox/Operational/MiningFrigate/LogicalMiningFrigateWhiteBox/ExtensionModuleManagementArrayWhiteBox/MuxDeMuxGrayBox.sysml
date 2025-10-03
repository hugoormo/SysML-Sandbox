package MuxDeMuxGrayBox {
    
    private import ExtensionModuleManagementArrayGrayBox::LogicalWhiteBoxMiningFrigateVentureClass::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def ExtensionModulesManagementArrayWhiteBox :> ExtensionModulesManagementArrayGrayBox {

        part muxDeMuxGrayBox :> muxDeMux {

                action logicalInitializeMuxDeMux {
                    in commandNetworkProxyPort : ~LogicalShipCommandPort;
                    in extensionModule1ControlProxyPort : LogicalModuleCommandPort;
                    in extensionModule2ControlProxyPort : LogicalModuleCommandPort;
                    in extensionModule3ControlProxyPort : LogicalModuleCommandPort;
                    in extensionModule4ControlProxyPort : LogicalModuleCommandPort;
                    in extensionModule5ControlProxyPort : LogicalModuleCommandPort;
                    in extensionModule6ControlProxyPort : LogicalModuleCommandPort;
                    in extensionModule7ControlProxyPort : LogicalModuleCommandPort;
                    
                    first start;
                    then perform action logicalPowerUpDeMux;
                    then fork;
                        then relayCommandsAndReports1;
                        then relayCommandsAndReports2;
                        then relayCommandsAndReports3;
                        then relayCommandsAndReports4;
                        then relayCommandsAndReports5;
                        then relayCommandsAndReports6;
                        then relayCommandsAndReports7;

                        perform action relayCommandsAndReports1 : RelayCommandsAndReports {
                            in :>> commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module1ToggleCommand;
                            in :>> extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule1ControlProxyPort;
                        }
                        perform action relayCommandsAndReports2 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module2ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule2ControlProxyPort;
                        }
                        perform action relayCommandsAndReports3 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module3ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule3ControlProxyPort;
                        }
                        perform action relayCommandsAndReports4 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module4ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule4ControlProxyPort;
                        }
                        perform action relayCommandsAndReports5 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module5ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule5ControlProxyPort;
                        }
                        perform action relayCommandsAndReports6 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module6ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule6ControlProxyPort;
                        }
                        perform action relayCommandsAndReports7 : RelayCommandsAndReports {
                            in commandNetworkPort  : LogicalModuleCommandPort = commandNetworkProxyPort.modulesCommandsSubPort.module7ToggleCommand;
                            in extensionModuleControlCommandPort : LogicalModuleCommandPort = extensionModule7ControlProxyPort;
                        }
                }    
                action def RelayCommandsAndReports {          
                    in commandNetworkPort : LogicalModuleCommandPort; 
                    in extensionModuleControlCommandPort : LogicalModuleCommandPort;      

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
    }
}