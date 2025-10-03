package SystemUseCases {

    // Import the Domain package for referencing actors
    private import NaturalEnvironment::*;
    private import Structures::*;
    private import OperationalDomain::*;
    private import ScalarValues::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;
    private import COTS::*;
    private import PilotPodsAndSpaceships::*;
    private import MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::*;

    //Use Cases of the Mining Frigate. 
    //Define the operational sequence of interactions between the system of interest and the actors
    //The Use Cases are defined for any configuration of mining frigate
    //Main use cases

    use case def MineAsteroids {
        subject highSecMiningFrigate :> MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::highSecMiningFrigate {
            perform action activateMiningLaser [2] {
                accept activateMiningLaserCommand : ModuleToggleCommand;
                then action reportOreHoldStatus {out shipReport : String;}
                if highSecMiningFrigate.cargoHoldStatus == 1 {
                    send reportOreHoldStatus.shipReport to pilotPod; //Mining report
                    then done;} //ore hold is full, interrupt mining.
                //more actions will come here
                then action reportStatusMining {out shipReport : String;}
                then send reportStatusMining.shipReport to pilotPod; //Mining report
            }
        } 
        actor pilotPod : PilotPod {
            event occurrence activateMiningLaserSent [2];
            then event occurrence miningReportReceived;
            then event occurrence oreHoldFullReceived;
        }

        actor asteroid : Asteroid [1..*] {
            event occurrence asteroidDeintegrationSend;
            then event occurrence asteroidDepletionSend;
        }       
        objective {
            doc /* Main Flow:
                  * 1. Activate mining lasers to extract ore.
                  *
                  * Exception Flows:
                  * - If the cargo hold is full, suspend mining and notify the pilot to return to a station for offloading.
                  */
        }

        message of ShipCommand from pilotPod.activateMiningLaserSent to highSecMiningFrigate.activateMiningLaser;
        message of ShipCommand from highSecMiningFrigate.activateMiningLaser to pilotPod.miningReportReceived;
        then message of ShipCommand from highSecMiningFrigate.activateMiningLaser to pilotPod.oreHoldFullReceived;
    }

    use case def MonitorAndDetectThreats {
        subject highSecMiningFrigate ::> MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::highSecMiningFrigate {
            perform action scanSpace {
                then fork;
                    then scanGrid;
                    then directionalScan;
                
                action scanGrid {
                doc /*refreshes continuously the report of the signatures detected in grid*/
                    loop {
                        perform action cycleScanner {out scanReport : String;}
                        then send cycleScanner.scanReport to pilotPod; //grid scan report
                    }
                }
                action directionalScan {in range; in direction; in coneAngle; out scanReport : String;}
                then send directionalScan.scanReport to pilotPod; //directional scan report
            }
        }
        actor pilotPod : PilotPod {
            event occurrence scanGridReportReceived;
            event occurrence directionalScanSent;
            event occurrence directionalScanReceived;
        }
        actor hostilePilotPod : HostilePilotPod [0..*] {
            timeslice signatureEmissionSend; //all bodies emmit constantly gravimetric waves.
            then snapshot destroyed; //if all goes well...
        }

        objective {
            doc /* Main Flow:
                  * 1. Monitor threats within the grid range.
                  * 2. Detect threats beyond the grid range using the directional sensor array.
                  */
        }
        message of GravitationalField from hostilePilotPod.signatureEmissionSend to highSecMiningFrigate.scanSpace.scanGrid;
        message of ShipReport from highSecMiningFrigate.scanSpace.scanGrid to pilotPod.scanGridReportReceived;
        message of ShipReport from pilotPod.directionalScanSent to highSecMiningFrigate.scanSpace.directionalScan;
        then message of GravitationalField from hostilePilotPod.signatureEmissionSend to highSecMiningFrigate.scanSpace.directionalScan;
        message of ShipReport from highSecMiningFrigate.scanSpace.directionalScan to pilotPod.directionalScanReceived;
    }

    use case def DeployDefenseDrones { //needs further detail
        subject highSecMiningFrigate ::> MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::highSecMiningFrigate;
        actor pilotPod : PilotPod;
        actor hostilePilotPod : HostilePilotPod [1..*];
        actor drone : Drone [2];
        objective {
            doc /* Main Flow:
                  * 1. Deploy two controlled drones in space.
                  * 2. Set drones mode
                  * 3. Recall drones to drone bay.
                  *
                * Alternate Flows:
                  * 1. If drones are lost or destroyed, deploy further drones if available in the drone bay.
                  */
        }
        message of ShipCommand from pilotPod.podPort to highSecMiningFrigate.podPort ;
        message of ShipReport from highSecMiningFrigate.podPort to pilotPod.podPort ;
        message of ShipCommand from pilotPod.podPort to highSecMiningFrigate.podPort ;
        message of ShipReport from highSecMiningFrigate.podPort to pilotPod.podPort ;
        message of ShipCommand from pilotPod.podPort to highSecMiningFrigate.podPort ;
        message of ShipReport from highSecMiningFrigate.podPort to pilotPod.podPort ;
    }

    use case def DockToStation {
        subject highSecMiningFrigate ::> MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::highSecMiningFrigate {
            event occurrence dockToStationReceived;
            then perform action approachSignature {
                accept ApproachSignatureCommand;
                //more actions will come here
                then action reportStatusApproach {out shipReport : String;}
                then send reportStatusApproach.shipReport to pilotPod;//Approach in progress
            }
            then perform action dockInStation {
                action requestDockingClearance {out ShipReport : String;}
                then send requestDockingClearance.ShipReport to station;
                then accept DockingRequestAccepted;
                //more actions will come here
                then action reportRequestAccepted {out shipReport : String;}
                then send reportRequestAccepted.shipReport to pilotPod;//Approach in progress 
            }
        }
        actor pilotPod : PilotPod {
            event occurrence dockToStationSent;
            event occurrence approachingStationReceived;
            event occurrence dockingRequestAccepted;
        }
        actor station : Station {
            event occurrence dockingRequestReceived;
            event occurrence dockingApprovalSent;
        }
        objective {
            doc /* Main Flow:
                  * 1. Select station signature
                  * 2. Automatically approach signature and dock in station
                  *
                  * Alternate Flows:
                  * - If station is not in grid ship automatically warps to station, 
                  * approach signature and dock in station
                  */
        }
        message of ShipCommand from pilotPod.dockToStationSent to highSecMiningFrigate.dockToStationReceived;
        message of ShipCommand from highSecMiningFrigate.approachSignature to pilotPod.approachingStationReceived;
        then message of StationCommand from highSecMiningFrigate.dockInStation.requestDockingClearance to station.dockingRequestReceived;
        message of StationCommand from station.dockingApprovalSent to highSecMiningFrigate.dockInStation;
        message of ShipCommand from highSecMiningFrigate.dockInStation.reportRequestAccepted to pilotPod.dockingRequestAccepted;
    }
    
    use case def WarpToCelestial {
        subject highSecMiningFrigate ::> MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::highSecMiningFrigate {        
            event occurrence celestialSignatureReceived;
            perform action executeWarpDrive {
                accept ExecuteWarpDriveCommand;
                //more actions will come here
                then action reportStatusWarpDrive {out shipReport : String;}
                then send reportStatusWarpDrive.shipReport to pilotPod; //warpDrive engaged
                //more actions will come here
                then action reportStatusDestination {out shipReport : String;}
                then send reportStatusDestination.shipReport to pilotPod; //Destination reached
            }       
        }
        actor pilotPod : PilotPod {
            event occurrence warpDriveEngagedReceived;
            event occurrence celestialReachedReceived;
        }
        actor asteroidBelt : AsteroidBelt {
            event occurrence celestialSignatureSent;
        }

        objective {
            doc /* Main Flow:
                  * 1. Accept a celestial destination from the pilot.
                  * 2. Fix the celestial signature
                  * 3. Engage the warp drive to travel along the plotted course.
                  * 4. Notify arrival after arriving to the destination.
                  */
        }
        message of CelestialSignature from asteroidBelt.celestialSignatureSent to highSecMiningFrigate.celestialSignatureReceived;
        message of ShipCommand from highSecMiningFrigate.executeWarpDrive to pilotPod.warpDriveEngagedReceived;
        then message of ShipCommand from highSecMiningFrigate.executeWarpDrive to pilotPod.celestialReachedReceived;
    }

    use case def ApproachSignature {
        subject highSecMiningFrigate ::> MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::highSecMiningFrigate {
            event occurrence asteroidSignatureReceived;
            perform action approachSignature {
                accept ApproachSignatureCommand;
                //more actions will come here
                then action reportStatusApproach {out shipReport : String;}
                then send reportStatusApproach.shipReport to pilotPod;//Approach in progress
            }          
        }
        actor pilotPod : PilotPod {
            event occurrence approachInitiatedReceived;
        }
        actor asteroid : Asteroid [1..*] {
            event occurrence asteroidSignatureSent;
        }
        objective {
            doc /* Main Flow:
                  * 1. Accept a signature destination from the pilot.
                  * 2. Plot the optimal course using the navigation system.
                  * 3. Notify approach to the signature destination.
                  * 4. Engage the engines to travel along the plotted course.
                  */
        }
        message of GridSignature from asteroid.asteroidSignatureSent to highSecMiningFrigate.asteroidSignatureReceived;
        message of ShipCommand from highSecMiningFrigate.approachSignature to pilotPod.approachInitiatedReceived;
    }

    use case def TransferOre { //needs further detail
        subject highSecMiningFrigate ::> MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::highSecMiningFrigate;
        actor pilotPod : PilotPod;
        actor station : Station;
        objective {
            doc /* Main Flow:
                  * 1. Transfer ore or other cargo to the appropriate storage location.
                  * 2. Verify the transfer has been completed successfully.
                  */
        }
    }
    
    use case def UndockFromStation { //needs further detail
        subject configuredMiningFrigate ::> MiningFrigateBlackBoxSpecification::MinigFrigateConfigurations::highSecMiningFrigate;
        actor pilotPod : PilotPod;
        actor station : Station;
        objective {
            doc /* Main Flow:
                  * 1. Request undock from station.
                  * 2. The spaceship is beamed out of station at warp speed in a random
                  * whithin a cone of 10 degrees around the direction of the station docking port.
                  */
        }
    }
}