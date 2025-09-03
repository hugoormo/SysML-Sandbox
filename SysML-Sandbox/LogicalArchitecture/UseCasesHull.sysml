package MiningFrigateHullUseCases {

    private import DomainPackage::*;
    private import COTS::*;
    private import MiningFrigateHull::*;

    // **Use Case: Manage Energy Supply and Recharge**
    use case ManageEnergy {
        subject hull : LogicalMiningFrigateHull;
        actor pilotPod : PilotPod;
        actor smallCapBatteryI : SmallCapBatteryI;

        objective {
            doc /*
            * The Mining Frigate Hull shall ensure energy balance through capacitor recharge mechanisms.
            */
        }
    }

    // **Use Case: Detect Threat**
    use case DetectThreat {
        subject hull : LogicalMiningFrigateHull;
        actor pilotPod : PilotPod;

        objective {
            doc /*
            * The Mining Frigate Hull shall scan for incoming threats using onboard sensors 
            * and provide a warning to the pilot.
            */
        }
    }

    // **Use Case: Engage Defenses**
    use case EngageDefenses {
        subject hull : LogicalMiningFrigateHull;
        actor pilotPod : PilotPod;
        actor hostileShip : HostileShip;

        objective {
            doc /*
            * The Mining Frigate Hull shall activate defensive systems to mitigate threats, 
            * including shield hardeners, warp core stabilizers, or evasive maneuvers.
            */
        }
    }

    // **Use Case: Navigate to Destination**
    use case NavigateToDestination {
        subject hull : LogicalMiningFrigateHull;
        actor pilotPod : PilotPod;

        objective {
            doc /*
            * The Mining Frigate Hull shall navigate between waypoints or target destinations 
            * using the ship’s navigation system.
            */
        }
    }

    // **Use Case: Transfer Ore**
    use case TransferOre {
        subject hull : LogicalMiningFrigateHull;
        actor pilotPod : PilotPod;
        actor station : Station;

        objective {
            doc /*
            * The Mining Frigate Hull shall transfer stored ore to a station or hauler for processing or sale.
            */
        }
    }

    // **Use Case: Dock to Station**
    use case DockToStation {
        subject hull : LogicalMiningFrigateHull;
        actor pilotPod : PilotPod;
        actor station : Station;

        objective {
            doc /*
            * The Mining Frigate Hull shall dock at a station or structure to enable refueling, 
            * maintenance, and ore transfer.
            */
        }
    }

    // **Use Case: Resupply Capacitor**
    use case ResupplyCapacitor {
        subject hull : LogicalMiningFrigateHull;
        actor pilotPod : PilotPod;
        actor smallCapBatteryI : SmallCapBatteryI;

        objective {
            doc /*
            * The Mining Frigate Hull shall replenish its capacitor charge using passive recharge or capacitor boosters.
            */
        }
    }

    // **Use Case: Activate Mining Laser**
    use case ActivateMiningLaser {
        subject hull : LogicalMiningFrigateHull;
        actor pilotPod : PilotPod;
        actor miningLaser : MinerI;

        objective {
            doc /*
            * The Mining Frigate Hull shall activate its mining laser to extract ore from asteroids.
            */
        }
    }
}
