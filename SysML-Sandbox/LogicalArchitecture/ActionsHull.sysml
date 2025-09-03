package MiningFrigateHullActions {

    private import DomainPackage::*;
    private import MiningFrigateActions_logical::*;
    private import COTS::*;
    
    // **Action: Activate Mining Laser**
    action def PowerupHighPowerModule :> MiningFrigateActions_logical::PowerupHighPowerModule { 
        in miningCommand : ShipCommand; 
        out miningStatus : ShipReport;
    }
    
    // **Action: Manage Energy Supply and Recharge**
    action def ManageEnergy { 
        in rechargeCommand : ShipCommand; 
        out rechargeStatus : ShipReport;

        bind resupplyCapacitor.rechargeCommand = rechargeCommand;
        action resupplyCapacitor : ResupplyCapacitor { in rechargeCommand; out rechargeStatus; }
        bind resupplyCapacitor.rechargeStatus = rechargeStatus;
    }
    
    // **Action: Detect Threat**
    action def DetectThreat { 
        in scanCommand : ShipCommand; 
        out scanReport : ShipReport; 
    }

    // **Action: Engage Defenses**
    action def EngageDefenses { 
        in engageCommand : ShipCommand; 
        out defenseStatus : ShipReport; 
    }

    // **Action: Navigate to Destination**
    action def NavigateToDestination { 
        in destinationCommand : ShipCommand; 
        out navigationStatus : ShipReport; 
    }

    // **Action: Transfer Ore**
    action def TransferOre { 
        in transferCommand : ShipCommand; 
        out transferStatus : ShipReport; 
    }

    // **Action: Dock at Station**
    action def DockToStation { 
        in dockingCommand : ShipCommand; 
        out dockingStatus : ShipReport; 
    }

    // **Action: Resupply Capacitor**
    action def ResupplyCapacitor { 
        in rechargeCommand : ShipCommand; 
        out rechargeStatus : ShipReport; 
    }

    // **Action: Check Asteroid Status**
    action def CheckAsteroidStatus { 
        in miningCommand : ShipCommand; 
        out asteroidStatus : ShipReport; 
    }

    // **Action: Report Asteroid Depletion to Pilot**
    action def ReportToPilot { 
        in asteroidStatus : ShipReport; 
        out report : ShipReport; 
    }
}
