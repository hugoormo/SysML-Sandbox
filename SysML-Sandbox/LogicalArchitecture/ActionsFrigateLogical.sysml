package LogicalActionsMiningFrigate {
    private import LogicalContext::*;
    private import ScalarValues::*;
    private import LogicalMiningFrigate::*;

    action logicalStartUpSequence;
    action logicalShutDownSequence;
    action logicalInitializePowerGrid;
    action logicalInitializeGenerator; 
    action logicalExecuteWarpDrive;
    action logicalInitializeScanSpaceServices {
        in scanSpaceServicesCommandPort : LogicalPodPort;

        action logicalPowerUpSensorSystem;
        action logicalScanGrid {
            action LogicalCycleScanner {out scanReport : String;}
        }
        action logicalPirectionalScan {
            action LogicalScanSpace {out scanReport : String;}
        }

    }
    action logicalInitializeNavigationServices {
        in scanSpaceServicesCommandPort : LogicalPodPort;

        action logicalPowerUpNavigationSystem;
        action logicalApproachSignatureAtRange;
        action logicalOrbitSignatureAtRange;
        action logicalKeepAtRangeSignature;
        action logicalDockInStation;
    }
    action logicalInitializeExtensionModule {
        in moduleServicesCommandPort : LogicalPodPort;
        in module : LogicalImperialStandardModule;

        action logicalConfigureModule {
            in module : LogicalImperialStandardModule; 
            out commandModule : LogicalShipCommand;
            out reportModule : LogicalShipReport;
        }
        action logicalPowerUpModule;
        action logicalDiagnoseModule;
        action logicalEnableModuleServices;
    }
    action logicalUndockFromStation;
    action logicalInitializeDroneServices;
    action logicalTransferOre;
}