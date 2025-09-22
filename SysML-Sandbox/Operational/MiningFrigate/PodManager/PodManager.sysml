package PodManager {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part logicalMiningFrigateVentureClass : LogicalMiningFrigateVentureClass {
        part podManager : LogicalPart :>> podManager {
            doc /*
                * Receive asynchronously podCommand items and send shipControl items to shipController
                * Set between the podPort (physical items) and the ShipController (logical items).
                */
            attribute :>> podDocked;
            port :>> podManagerPort;
            port :>> commandNetworkPort;

            action :>> logicalInitializePodManagerServices {
                doc /*
                        * Decrypt incomming commands from the pod and relay to the commandNetwork
                        * Encrypt ship reports and relay to the pod
                        */

                first start;
                then action logicalPowerUpPodManager;
                then fork;
                    then logicalDecryptShipCommands {
                        in encryptedPilotPodCommands = podManagerPort.command;
                        out decryptedShipCommand = commandNetworkPort.shipControl;
                    }
                    then logicalEncryptShipReports {
                        in decryptedShipReport = commandNetworkPort.shipReport;
                        out encryptedShipReport = podManagerPort.shipReport;
                    }
                action logicalDecryptShipCommands {
                    doc /*
                        * Decrypts and Relays commands from the pilotPod to the shipController
                        * The input signals are physical, the output signals are logical. 
                        */
                    in encryptedPilotPodCommands : ShipCommand;
                    out decryptedShipCommand : LogicalControlCommand;
                }
                action logicalEncryptShipReports {
                    doc /*
                        * Collect reports, encrypt them and relay them to the pilotPod 
                        */
                    
                    in decryptedShipReport : LogicalShipReport;
                    out encryptedShipReport : ShipReport;
                }
            }
        }
    }
}