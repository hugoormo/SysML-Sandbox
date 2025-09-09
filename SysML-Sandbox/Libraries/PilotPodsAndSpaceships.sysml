package PilotPodsAndSpaceships {

    private import StdPortsAndInterfaces::ImperialTechnology::*;
    private import ScalarValues::*;
    private import COTS::*;
    private import RollupAnalysis::*; 

    part def PilotPod {
        attribute skillsSet : SkillsSetPilot;
        attribute controlEfficiency : Real default 0.6;         // Efficiency of command execution (%)
        attribute fleetSize: Integer;
        port podPort: PodPort;
        ref part spaceship : Spaceship[0..1];
    }

    item def SkillsSetPilot {
        attribute miningEfficiency : Real;
        attribute maxLockedTargets : Integer; 
    }

    abstract part def Spaceship :> ImperialStandardShip; //Placeholder for any kind of spaceship not yet specified

    //Imperial Standard Ship Blueprint
    abstract part def ImperialStandardShip :> CompositeSpaceshipComponent {

        //these attributes redefine the attributs of the roll up calculation
        //the ship provides grid, capacitor and CPU hence usage is set to 0.
        attribute massShip :>> mass : Real;
        attribute :>> totalMass : Real;
        attribute suppliedPowerGrid : Real;
        attribute :>> powerGridUsage : Real = 0;
        attribute :>> totalPowerGridUsage : Real;
        attribute suppliedCapacitor : Real;
        attribute :>> capacitorUsage : Real = 0;
        attribute :>> totalCapacitorUsage : Real;
        attribute suppliedCpu : Real;
        attribute :>> cpuUsage : Real = 0;
        attribute :>> totalCpuUsage : Real;
        
        //attributes that do not participate in the roll up calculation
        attribute hullStatus : Real;
        attribute armorStatus : Real;
        attribute shieldStatus : Real;
        attribute maxVelocity : Real;
        attribute warpSpeed : Real; 
        attribute warpBubbleEnd : Boolean;
        attribute alignTime : Real; 
        attribute structureStrength : Real;
        attribute armorStrength : Real;   
        attribute shieldStrength : Real; 
        attribute cargoHoldCapacity : Real;
        attribute cargoHoldStatus : Real;  
        attribute warpCoreStrength : Integer;
        attribute maxLockedTargets : Integer;
        attribute sensorStrength : Integer;

        //Modules and rigs extension ports
        port highPowerSlot : HighSlotPort[1..8];
        port midPowerSlot : MediumSlotPort[1..5];
        port lowPowerSlot : LowSlotPort[1..8];
        port rigPort : RigPort[3];
        port podPort : ~PodPort[1];
        port dockingPort : ~DockingPort[1];

        //Ship Interaction ports
        port longRangeDirectionalSensorAntenna : LongRangeSensorDirectionalAntenna;
        port gridSensorAntenna : GridSensorAntenna;
        port shipComms : ShipCommsPort;
        port zPropulsion : MainPropulsion[1..*];
        port xPropulsion : DirectionalPropulsion[1..*];
        port yPropulsion : DirectionalPropulsion[1..*];

        //Ship resilience interactions
        port shieldMitigationPort : ~ThreatPort;
        port armourMitigationPort : ~ThreatPort;
        port structureMitigationPort : ~ThreatPort;
        port warpShield : WarpDriveDisruptionShield;

        state states {

            entry action initial;
            then state Parked {
                doc /* The mining frigate is parked inside a station and can be boarded. */
            } 	
            state Boarded {
                doc /* The mining frigate is boarded inside a station in the docking pad, available for 
                    * refitting, resupply, or cargo transfer. */
                exit action ::> undockFromStation;
            }
            state InGrid {
                doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
            }
            state OnWarp {
                doc /* The mining frigate is in warp, traveling between locations. */
                entry action ::> initializeGridServices.executeWarpDrive;
            }        
            
            transition parked_to_boarded
                first Parked
                accept boardShip : StationCommand via podPort
                then Boarded;
            
            transition boarded_to_parked
                first Boarded
                accept unboardShip : StationCommand via podPort
                then Parked;
            
            transition boarded_to_inGrid
                first Boarded
                accept pilotPodUndockCommandSig : ShipCommand via podPort
                do action ::> initializeGridServices
                then InGrid;  		
                
            transition inGrid_to_docked
                first InGrid
                accept pilotPodDockCommandSig : ShipCommand via podPort
                then Boarded;
                
            transition inGrid_to_onWarp
                first InGrid
                accept warpCommandSig : ShipCommand via podPort
                then OnWarp;
        
            transition onWarp_to_inGrid
                first OnWarp
                accept when warpBubbleEnd
                then InGrid;     	   
        } 

        //Declaration of the operational actions of a spaceship.
        action initializeGridServices {
            doc /*This action initializes the spaceship for the operational services in grid.
                * The actions do not end of themselves but will be terminated by the transition on the state. 
                    */
            first start;
            then fork;
                then initializeScanSpaceServices;
                then initializeNavigationServices;
                then dockInStation;
                then initializeExtensionModulesAndRigs;
            
            action initializeScanSpaceServices {
                doc /* Scan the grid and range space for potential threats. */
                first start;
                then fork;
                    then scanGrid;
                    then directionalScan;
                
                action scanGrid {
                    doc /*refreshes continuously the report of the signatures detected in grid*/
                    loop {
                        action cycleScanner {out scanReport : String;}
                        then send ShipReport(cycleScanner.scanReport) via podPort; //grid scan report
                    }
                }
                action directionalScan {
                    out scanReport : String;
                    accept ScanForThreatsCommand via podPort;
                    //more actions will come here
                    then send ShipReport(directionalScan.scanReport) via podPort; //directional scan report
                }
            }

            action initializeNavigationServices {
                doc /*Approach a signature using the navigation system.*/
                first start;
                then fork;
                    then approachSignatureAtRange;
                    then orbitSignatureAtRange;
                    then keepAtRangeSignature;

                action approachSignatureAtRange {
                    accept ApproachSignatureAtRangeCommand via podPort;
                    //more actions will come here
                    then action reportStatusApproach {out shipReport : String;}
                    then send ShipCommand(reportStatusApproach.shipReport) via podPort;//Approach in progress        
                }
                action orbitSignatureAtRange; //more actions will come here
                action keepAtRangeSignature; //more actions will come here
            }

            action executeWarpDrive {
                doc /* Engage the warp drive to travel to the destination. */
                    accept ExecuteWarpDriveCommand via podPort;
                    //more actions will come here
                    then action reportStatusWarpDrive {out shipReport : String;}
                    then send ShipCommand(reportStatusWarpDrive.shipReport) via podPort; //warpDrive engaged
                    //more actions will come here
                    then action reportStatusDestination {out shipReport : String;}
                    then send ShipCommand(reportStatusDestination.shipReport) via podPort; //Destination reached
            }
            
            action dockInStation {
                doc /*Dock into a station to make repairs, resupply capacitor and support systems.*/
                
                action requestDockingClearance {out ShipReport : String;}
                then send ShipCommand(requestDockingClearance.ShipReport) via podPort;
                then accept DockingRequestAccepted;
                //more actions will come here
                then action reportRequestAccepted {out shipReport : String;}
                then send ShipCommand(reportRequestAccepted.shipReport) via podPort; //Approach in progress
            }
            
            action initializeExtensionModulesAndRigs {
                doc /* 
                    * Activates all service modules in a configured ship
                    * Record all installed modules in the configuration of the system and enables them
                    */
            }   
        }
        
        action undockFromStation {
            doc /*Undock from a station.*/
    
        }
            
    }
}