package ScannersGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {

        part longRangeDirectionalSensorGrayBox : LogicalPart :> longRangeDirectionalSensor {
            attribute gravimetricDirectionalSensorStrength :>> gravimetricDirectionalSensorStrength default 4;
            
            port :>> longRangeDirectionalSensorPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;
            port powerGridLowPowerGridPort :>> lowPowerGridPort; 

            part lowPowerSupplyUnit : LogicalPart {
                
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port directionalScanner :>> lowPowerLinePort;
                port directionalScannerManager :>> lowPowerLinePort;
                
                perform logicalInitializeLongRangeScanServices.logicalPowerUpDirectionalSensorSystem;
            }

            part directionalScanner : LogicalPart {
                attribute gravimetricDirectionalSensorStrength :>> gravimetricDirectionalSensorStrength default 4;

                port :>> longRangeDirectionalSensorPort;
                port scannerControlsPort : ~LogicalAnalogPort :>> analogLinePort;
                port scannerReadingsPort : LogicalAnalogPort :>> analogLinePort;
                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort;
                
                perform logicalInitializeLongRangeScanServices.logicalDirectionalScan.logicalDirectionalScanSpace {
                    //here we see a pin-out specification
                    in range = scannerControlsPort.logicalAnalogSignal1;
                    in direction = scannerControlsPort.logicalAnalogSignal2;
                    in coneAngle = scannerControlsPort.logicalAnalogSignal2;
                    out sensorReading : LogicalAnalogSignal = scannerReadingsPort.logicalAnalogSignal1;
                }
            }

            part directionalScannerManager : LogicalPart {
                port lowPowerSupplyUnitPort :>> lowPowerLinePort;
                port commandNetworkProxyPort : ~LogicalShipCommandPort :>> commandNetworkPort;
                port scannerControlsPort : LogicalAnalogPort :>> analogLinePort;
                port scannerReadingsPort : ~LogicalAnalogPort :>> analogLinePort;

                perform logicalInitializeLongRangeScanServices.logicalDirectionalScan {
                    in scanSpaceServicesCommandProxyPort : LogicalShipCommandPort = commandNetworkProxyPort;
                }
            }

            part lowPowerWiring : LogicalPart {
                ref lowPowerSupplyUnit :>> lowPowerSupplyUnit;
                ref directionalScanner :>> directionalScanner;
                ref directionalScannerManager :>> directionalScannerManager;

                //Low power wiring
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.directionalScanner to
                    consumerPort ::> directionalScanner.lowPowerSupplyUnitPort; 
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.directionalScannerManager to
                    consumerPort ::> directionalScannerManager.lowPowerSupplyUnitPort;       
            }

            bind longRangeDirectionalSensorPort = directionalScanner.longRangeDirectionalSensorPort;
            bind commandNetworkPort = directionalScannerManager.commandNetworkProxyPort;
            bind powerGridLowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;

            interface : LogicalAnalogSignalIF connect
                supplierPort ::> directionalScannerManager.scannerControlsPort to
                consumerPort ::> directionalScanner.scannerControlsPort;
            interface : LogicalAnalogSignalIF connect
                supplierPort ::> directionalScanner.scannerReadingsPort to
                consumerPort ::> directionalScannerManager.scannerReadingsPort;

            action :>> logicalInitializeLongRangeScanServices {
                doc /*
                    * Enable long range scanner
                    */
                in scanSpaceServicesCommandPort : LogicalShipCommandPort;

                first start;
                
                then action logicalPowerUpDirectionalSensorSystem;
                then action logicalDirectionalScan {
                    in scanSpaceServicesCommandProxyPort : LogicalShipCommandPort;
                    action acceptCommand accept scanForThreatsCommand : LogicalDirectionalScanCommand via scanSpaceServicesCommandProxyPort;
                    then action logicalDirectionalScanSpace {
                        in range : LogicalAnalogSignal;
                        in direction : LogicalAnalogSignal;
                        in coneAngle : LogicalAnalogSignal;
                        out sensorReading : LogicalAnalogSignal;

                        first start;
                        then action setUpFilter {in scanRange = range;}
                        then action positionScanner {in scannDirection = direction;}
                        then action activateRotation {in scannConeAngle = coneAngle;}
                        then action activateSensor {out sensorReading : LogicalAnalogSignal;}
                        then terminate this;
                    }
                    then action generateReport {in sensorReading = logicalDirectionalScanSpace.sensorReading; out scanReport : LogicalScanReport;}
                    then send generateReport.scanReport via scanSpaceServicesCommandProxyPort;
                }
            }
        }
        part gridSensorGrayBox : LogicalPart :> gridOmnidirectionalSensor {
            attribute gravimetricOmnidirectionalSensorStrength :>> gravimetricOmnidirectionalSensorStrength default 4;

            port :>> gridOmnidirectionalSensorPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;

            part lowPowerSupplyUnit : LogicalPart {
                
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port powerGridNetworkPort :>> lowPowerLinePort;
                
                perform logicalInitializeGridScanServices.logicalPowerUpGridSensorSystem;
            }

            part omniDirectionalScanner : LogicalPart {
                attribute gravimetricOmnidirectionalSensorStrength :>> gravimetricSensorStrength default 4;

                port :>> gridOmnidirectionalSensorPort;
                port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;
                port scannerReportPort : LogicalAnalogPort :>> analogLinePort;
                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort;

                perform logicalInitializeGridScanServices.logicalScanGrid {
                    in scanSpaceServicesCommandPort : LogicalShipCommandPort = commandNetworkPort;
                }
            }

            action :>> logicalInitializeGridScanServices {
                doc /*
                    * Enable grid scanner
                    */
                in scanSpaceServicesCommandPort : LogicalShipCommandPort;

                first start;
                then action logicalPowerUpGridSensorSystem;
                then action logicalScanGrid {
                    in scanSpaceServicesCommandPort : LogicalShipCommandPort;
                    
                    accept after 1[s];
                    then action logicalCycleScanner {out scanReport : LogicalShipReport;}
                    then send logicalCycleScanner.scanReport via scanSpaceServicesCommandPort;
                }
            }
        }

    }
}