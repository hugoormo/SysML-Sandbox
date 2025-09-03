package LogicalMiningFrigateHull {
    
    private import DomainPackage::*;
    private import MiningFrigatePackage::*;
    private import ScalarValues::*;
    private import COTS::*;
    private import StdPortsAndInterfaces::*;
    private import FrigateRollupAnalysis::*;
    private import MiningFrigateActions_logical::*;
    private import ParametersOfInterestMetadata::*;

    //Mining Frigate Hull (Black Box with Ports)
    part def LogicalMiningFrigateHull :> SimpleFrigateComponent, MiningFrigateHull {
        doc /* The Mining Frigate hull includes integrated features such as 
         * a built-in warp core stabilizer, ore hold, and base resistances. */
        
        //Performed actions of the hull (executed by the ship's integrated systems)
       
        perform activateMiningLaser_logical.activateLaserTurret;
        //perform action manageEnergy : MiningFrigateHullActions::ManageEnergy;
        //perform action detectThreat : MiningFrigateHullActions::DetectThreat;
        //perform action engageDefenses : MiningFrigateHullActions::EngageDefenses;
        //perform action navigateToDestination : MiningFrigateHullActions::NavigateToDestination;
        //perform action reportToPilot : MiningFrigateHullActions::ReportToPilot;
        //perform action transferOre : MiningFrigateHullActions::TransferOre;
        //perform action dockToStation : MiningFrigateHullActions::DockToStation;
        //perform action checkAsteroidStatus : MiningFrigateHullActions::CheckAsteroidStatus;
        //perform action resupplyCapacitor : MiningFrigateHullActions::ResupplyCapacitor;

        //Ports for COTS Modules
        port highSlot1 : HighSlotPort;
        port highSlot2 : HighSlotPort;
        port mediumSlot1 : MediumSlotPort;
        port mediumSlot2 : MediumSlotPort;
        port lowSlot1 : LowSlotPort;
        port lowSlot2 : LowSlotPort;

        //Ports bound to the LogicalMiningFrigateConfiguration
        port hullControlPort : ~PodPort;
        port hullDockingPort : ~DockingPort;
        port hullDefensePort : ~ThreatPort;
        port hullDroneControlPort: ~DroneControllerPort;
    }
}