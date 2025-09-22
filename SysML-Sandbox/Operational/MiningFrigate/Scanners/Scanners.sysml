package NScanners {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part logicalMiningFrigateVentureClass : LogicalMiningFrigateVentureClass {

        part longRangeDirectionalSensor : LogicalPart :>> longRangeDirectionalSensor {
            port :>> longRangeDirectionalSensorPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;

            action :>> logicalInitializeLongRangeScanServices {
                doc /*
                    * Enable long range scanner
                    */
                in scanSpaceServicesCommandPort : LogicalShipCommandPort;

                first start;
                
                then action logicalPowerUpDirectionalSensorSystem;
                then action logicalDirectionalScan {
                    action acceptCommand accept scanForThreatsCommand : LogicalDirectionalScanCommand via scanSpaceServicesCommandPort;
                    then action logicalDirectionalScanSpace {
                        in range = acceptCommand.scanForThreatsCommand.range;
                        in direction = acceptCommand.scanForThreatsCommand.direction;
                        in coneAngle = acceptCommand.scanForThreatsCommand.coneAngle;
                        out scanReport : LogicalShipReport;
                    }
                    then send logicalDirectionalScanSpace.scanReport via scanSpaceServicesCommandPort;
                }
            }
        }
        part gridSensor : LogicalPart :>> gridSensor {
            port :>> gridSensorPort;
            port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;

            action :>> logicalInitializeGridScanServices {
                doc /*
                    * Enable grid scanner
                    */
                in scanSpaceServicesCommandPort : LogicalShipCommandPort;

                first start;
                then action logicalPowerUpGridSensorSystem;
                then action logicalScanGrid {
                    accept after 1[s];
                    then action logicalCycleScanner {out scanReport : LogicalShipReport;}
                    then send logicalCycleScanner.scanReport via scanSpaceServicesCommandPort;
                }
            }
        }

    }
}