package CommandNetwork {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part logicalMiningFrigateVentureClass : LogicalMiningFrigateVentureClass {
        part commandNetwork : LogicalPart :>> commandNetwork{
            doc /*
                * Routes all shipCommand items between the ship parts.  
                */

            port podManagerPort : ~LogicalShipCommandPort :>> podManagerPort;
            port :>> gridSensorCommandPort;
            port :>> longRangeDirectionalSensorCommandPort;
            port :>> navigationManagerCommandPort;
            port :>> extensionModulesManagementArrayPort;
            port :>> droneManagerCommandPort;

            action :>> logicalInitializecommandNetwork {
                doc /*
                    * Start services of the control network. 
                    */

                first start;
                then action logicalPowerUpcommandNetwork;
                then action relayControlCommands {
                    doc/*
                        * Relay signals received from the podManager to all parts in the control network
                        */
                    in relayControlCommandsPort1 : ~LogicalShipCommandPort = podManagerPort;
                    in shipControllerControlCommand : LogicalControlCommand = podManagerPort.shipControl;        
                    
                    action verifyControlCommand {
                        in command = shipControllerControlCommand;
                        out verifiedCommand;
                    }
                    then send verifyControlCommand.verifiedCommand via relayControlCommandsPort1;
                }
                then action relayShipReports {
                    doc/*
                        * Collect reports from all parts in the control network
                        * Send reports to the podManager
                        */
                    in relayControlCommandsPort : ~LogicalShipCommandPort = podManagerPort;
                    out shipControllerShipReport : LogicalShipReport = podManagerPort.shipReport;

                    action acceptShipReport accept commandNetworkShipReport : LogicalControlCommand via relayControlCommandsPort;
                    then action verifyReport {
                        in report = acceptShipReport.commandNetworkShipReport;
                        out verifiredReport = shipControllerShipReport;
                    }
                }    
            }
        }

    }
}