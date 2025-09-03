package MiningFrigateActions_logical {
    
    //import packages
    private import DomainPackage::*;
	private import ScalarValues::*;
    private import OperationalActions::*;
    private import COTS::*;

    //action parameters are inherited
    
    
    action def PowerupHighPowerModule {in activateMiningLaser : ShipCommand; out highPowerSupply : Real; }
    action def ActivateLaserTurret {in highPowerSupply : Real; in miningLaserTarget : COTS::ModuleCommand; out minigLaserReport : COTS::ModuleReport; }
    action def ManageReports {in moduleReport : COTS::ModuleReport; out shipReport : ShipReport;}
    //Activate Mining Laser
    action def ActivateMiningLaser_logical :> OperationalActions::ActivateMiningLaser;
    action activateMiningLaser_logical : ActivateMiningLaser_logical {
        bind powerupHighPowerModule.activateMiningLaser = activateMiningLaser;
        action powerupHighPowerModule : PowerupHighPowerModule {in activateMiningLaser : ShipCommand; out highPowerSupply; }
        flow powerupHighPowerModule.highPowerSupply to activateLaserTurret.highPowerSupply;
        action activateLaserTurret : ActivateLaserTurret {in highPowerSupply; in miningLaserTarget; out miningLaserReport; }
        flow activateLaserTurret.miningLaserReport to manageLaserTurretReport.laserModuleReport;
        action manageLaserTurretReport : ManageReports {in laserModuleReport : COTS::ModuleReport; out shipMiningReport : ShipReport;}
        bind manageLaserTurretReport.shipMiningReport = miningCycleReport;
    }

    action def UndockFromStation_logical :> OperationalActions::UndockFromStation;
    action def DockToStation_logical :> OperationalActions::DockToStation;
    action def ExecuteWarpDrive_logical :> OperationalActions::ExecuteWarpDrive;
    action def TransferOre_logical :> OperationalActions::TransferOre;
    action def ScanForThreats_logical :> OperationalActions::ScanForThreats;
    action def PrioritizeThreats_logical :> OperationalActions::PrioritizeThreats;
    action def SelectDronesForDeployment_logical :> OperationalActions::SelectDronesForDeployment;
    action def AcceptDestination_logical :> OperationalActions::AcceptDestination;
    action def PlotOptimalCourse_logical :> OperationalActions::PlotOptimalCourse;
    action def EngagePropulsion_logical :> OperationalActions::EngagePropulsion;
    action def MonitorAndAdjustCourse_logical :> OperationalActions::MonitorAndAdjustCourse;
    action def VerifyCargoTransfer_logical :> OperationalActions::VerifyCargoTransfer;
    action def DetectThreat_logical :> OperationalActions::DetectThreat;
    action def EngageDefenses_logical :> OperationalActions::EngageDefenses;
    action def VerifyResupply_logical :> OperationalActions::VerifyResupply;

}