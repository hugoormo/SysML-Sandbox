package PodManagerGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardInteractionPoints::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardInterfaces::*;

    part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {
        
        part podManagerGrayBox : LogicalPart :> podManager {
            doc /*
                * Asynchronously receive podCommand items and send asynchronously shipControl items to the bus
                * Set between the podPort (physical items) and the controlNetwork (logical items).
                */
            attribute :>> podDockedStatus;
            port podManagerPort : ~PodPort :>> podManagerPort;
            port commandNetworkPort :>> commandNetworkPort;
            port podManagerLowPowerGridPort :>> lowPowerGridPort;

            part commandNetworkBusInterfaceUnit : LogicalPart {

                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort;
                port commandNetworkPort : LogicalShipCommandPort;
                port podCommandsDecoderPort : ~LogicalShipCommandPort;
                port podReportsEncoderPort : ~LogicalShipCommandPort;

            }
            part lowPowerSupplyUnit : LogicalPart {
                
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port podCommandsDecoderPort :>> lowPowerLinePort;
                port podReportsEncoderPort :>> lowPowerLinePort;
                port commandNetworkBusInterfaceUnitPort :>> lowPowerLinePort;
                
                perform logicalInitializePodManagerServices.logicalPowerUpPodManager;
            }
            part podCommandsDecoder : LogicalPart {

                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort; 
                port podPort : ~PodPort;
                port commandNetworkBusInterfaceUnitPort : LogicalShipCommandPort; 

                perform logicalInitializePodManagerServices.logicalDecryptShipCommands {
                    in encryptedPodCommandsPort : ~PodPort = podPort;
                    in decryptedShipCommandsPort : LogicalShipCommandPort = commandNetworkBusInterfaceUnitPort;
                }
            }

            part podReportsEncoder : LogicalPart {

                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort;  
                port podPort : ~PodPort;
                port commandNetworkBusInterfaceUnitPort : LogicalShipCommandPort;

                perform logicalInitializePodManagerServices.logicalEncryptShipReports {
                    in decryptedShipReportPort : LogicalShipCommandPort = commandNetworkBusInterfaceUnitPort;
                    in encryptedShipReportPort : ~PodPort = podPort;
                }
            }

            part lowPowerWiring : LogicalPart {
                ref lowPowerSupplyUnit :>> lowPowerSupplyUnit;
                ref podCommandsDecoder :>> podCommandsDecoder;
                ref podReportsEncoder :>> podReportsEncoder;
                ref commandNetworkBusInterfaceUnit :>> commandNetworkBusInterfaceUnit;
                

                //Low power wiring
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.podCommandsDecoderPort to
                    consumerPort ::> podCommandsDecoder.lowPowerSupplyUnitPort;

                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.podReportsEncoderPort to
                    consumerPort ::> podReportsEncoder.lowPowerSupplyUnitPort;

                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.commandNetworkBusInterfaceUnitPort to
                    consumerPort ::> commandNetworkBusInterfaceUnit.lowPowerSupplyUnitPort;
                
            }

            bind podCommandsDecoder.podPort = podManagerPort;
            bind podReportsEncoder.podPort = podManagerPort;
            bind commandNetworkPort = commandNetworkBusInterfaceUnit.commandNetworkPort;
            bind lowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;

            interface : CommandIF connect
                supplierPort ::> podManagerPort to
                consumerPort ::> podCommandsDecoder.podPort;

            interface : CommandIF connect
                supplierPort ::> podManagerPort to
                consumerPort ::> podReportsEncoder.podPort;

            interface : LogicalControlIF connect
                supplierPort ::> podCommandsDecoder.commandNetworkBusInterfaceUnitPort to
                consumerPort ::> commandNetworkBusInterfaceUnit.podCommandsDecoderPort;

            interface : LogicalControlIF connect
                supplierPort ::> commandNetworkBusInterfaceUnit.podReportsEncoderPort to
                consumerPort ::> podReportsEncoder.commandNetworkBusInterfaceUnitPort;

            

            action :>> logicalInitializePodManagerServices {
                doc /*
                    * Decrypt incomming commands from the pod and relay to the commandNetwork
                    * Encrypt ship reports and relay to the pod
                    */

                in podManagerPort : ~PodPort :>> podManagerPort;
                out commandNetworkPort : LogicalShipCommandPort :>> commandNetworkPort;
                first start;
                then action logicalPowerUpPodManager;
                then fork;
                    then logicalDecryptShipCommands {
                        in encryptedPodCommandsPort : ~PodPort = podManagerPort;
                        in decryptedShipCommandsPort : LogicalShipCommandPort = commandNetworkPort;
                    }
                    then logicalEncryptShipReports {
                        in decryptedShipReportPort  : LogicalShipCommandPort = commandNetworkPort;
                        in encryptedShipReportPort : ~PodPort = podManagerPort;
                    }
                action logicalDecryptShipCommands {
                    doc /*
                        * Decrypts and Relays commands from the pilotPod to the shipController
                        * The input signals are physical, the output signals are logical. 
                        */
                    in encryptedPodCommandsPort : ~PodPort;
                    in decryptedShipCommandsPort : LogicalShipCommandPort;
                }
                action logicalEncryptShipReports {
                    doc /*
                        * Collect reports, encrypt them and relay them to the pilotPod 
                        */
                    
                    in decryptedShipReportPort  : LogicalShipCommandPort;
                    in encryptedShipReportPort : ~PodPort;
                }
            }
        }
    }
}