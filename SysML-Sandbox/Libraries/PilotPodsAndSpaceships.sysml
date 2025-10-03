package PilotPodsAndSpaceships {

    private import NaturalEnvironment::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardInteractionPoints::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;  
    private import ScalarValues::*;
    private import COTS::*;
    private import RollupAnalysis::*;
    private import SI::second; 

    part def PilotPod :> EmittingMassiveObject {
        attribute skillsSet : SkillsSetPilot;
        attribute controlEfficiency : Real default 0.6;         // Efficiency of command execution (%)
        attribute fleetSize: Integer;
        port podPort: PodPort;
        port podCommsPort : PodCommsPort;
        ref part spaceship : Spaceship[0..1];

        action undockFromStation { 
            doc /*
                * Undock from a station.
                * The pilotPod communicates with the station. The ship is not initialized.
                */
        }
        action logicalTransferOre {
                doc /*
                    * Unload ship cargo into station.
                    */
        }
    }

    item def SkillsSetPilot {
        attribute miningEfficiency : Real;
        attribute maxLockedTargets : Integer; 
    }

    abstract part def Spaceship :> ImperialStandardShip; //Placeholder for any kind of spaceship not yet specified

    //Imperial ship classification
    enum def VesselType {
        enum Frigate;
        enum Corvette;
        enum Destroyer;
        enum Cruiser;
        enum Battlecruiser;
        enum Battleship;
    }
    part imperialStandardShip : ImperialStandardShip;

    //Imperial Standard Ship Blueprint
    abstract part def ImperialStandardShip :> CompositeSpaceshipComponent, EmittingMassiveObject {

        //Manufacturer and identification
        attribute vesselType : VesselType;
        attribute vesselClass : String;
        attribute manufacturer : String;

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
        attribute podDockedStatus : Boolean;
        attribute shipDockedStatus : Boolean;
        
        //Modules and rigs extension ports
        port highPowerSlot : HighSlotPort[1..8];
        port midPowerSlot : MediumSlotPort[1..5];
        port lowPowerSlot : LowSlotPort[1..8];
        port rigPort : RigPort[3];
        port podPort : ~PodPort[1];
        port dockingPort : ~DockingPort[1];
        port tractorBeamPort : TractorBeamPort;

        //Ship Interaction ports
        port longRangeDirectionalSensorPort : LongRangeSensorDirectionalPort;
        port gridSensorPort : GridSensorPort;
        port xPropulsionPort : MainPropulsionPort[1..*];
        port yPropulsionPort : RotationPropulsionPort[1..*];
        port zPropulsionPort : RotationPropulsionPort[1..*];

        //Ship resilience interactions
        port shieldMitigationPort : ~ThreatPort;
        port armourMitigationPort : ~ThreatPort;
        port structureMitigationPort : ~ThreatPort;
        port warpShieldPort : WarpDriveDisruptionShieldPort;

        //Exhibited or performed behavior of the spaceshihp
        exhibit imperialStandardShipStates {
            in ship = imperialStandardShip;
            in shipCommandPort = podPort;
            in shipWarpBubbleEnd = warpBubbleEnd;
        }
    }

    //Imperial Standard Ship Behavior
    state imperialStandardShipStates {
        doc /* All imperial compliant spaceships share a basic behavior. 
            */
        in ship : ImperialStandardShip;
        in shipCommandPort : PodPort;
        in shipWarpBubbleEnd : Boolean;

        entry action initial;
        then state Parked {
            doc /* The spaceship is parked inside a station and can be boarded. 
            */
        } 	
        state Boarded {
            doc /* The spaceship is boarded inside a station in the docking pad, available for 
                * refitting, resupply, or cargo transfer. 
                */
        }
        state InGrid {
            doc /* The spaceship is in open space, near asteroids, stations, or other celestial objects. 
            */
        }
        state OnWarp {
            doc /* The spaceship is in warp, traveling between locations. 
            */
        }        
        
        transition parked_to_boarded
            first Parked
            accept when imperialStandardShip.podDockedStatus == true
            then Boarded;
        
        transition boarded_to_parked
            first Boarded
            accept when imperialStandardShip.podDockedStatus == false
            then Parked;
        
        transition boarded_to_inGrid
            first Boarded
            accept when imperialStandardShip.shipDockedStatus == false
            do action ::> startUpSequence {in shipServicesCommandPort = shipCommandPort;}
            then InGrid;  		
            
        transition inGrid_to_docked
            first InGrid
            accept pilotPodDockCommandSig : ShipCommand via shipCommandPort
            do action ::> shutDownSequence
            then Boarded;
            
        transition inGrid_to_onWarp
            first InGrid
            accept warpCommandSig : ShipCommand via shipCommandPort
            do action prepareForWarp
            then OnWarp;
    
        transition onWarp_to_inGrid
            first OnWarp
            accept when shipWarpBubbleEnd
            do action restoreFromWarp
            then InGrid;     	   
    } 
    
    //Declaration of the operational actions of a spaceship.
    //Start-up sequence - Initialize generic spaceship
    action startUpSequence {
        doc /*This action initializes the spaceship for the operational services in grid.
            * This action stays active until a state transition terminates it  
            */
        in shipServicesCommandPort : PodPort;

        first start;
        then initializePowerGrid;
        then initializeGenerator;
        then initializeScanSpaceServices {in scanSpaceServicesCommandPort = shipServicesCommandPort;}
        then initializeNavigationServices {in navigationServicesCommandPort = shipServicesCommandPort;}     
    }

    action shutDownSequence { //technology dependent actions will be added by the developers here.
        doc /*This action shuts-down the spaceship's services and systems.
            */
    }

    action initializePowerGrid { //technology dependent actions will be added by the developers here.
        doc /*This action starts the capacitor and the power grid network.
            */
    }

    action initializeGenerator { //technology dependent actions will be added by the developers here.
        doc /*This action starts the generator and the connexion to the capacitor.
            */
    }
    
    action initializeScanSpaceServices {
        doc /* Scan the grid and range space for potential threats. 
        */
        in scanSpaceServicesCommandPort : PodPort;

        first start;
        then action powerUpSensorSystem; //technology dependent actions will be added by the developers here.
        then fork;
            then action scanGrid {
                doc /*refreshes continuously the report of the signatures detected in grid
                */
                accept after 1[s];
                then action cycleScanner {out scanReport : String;} //technology dependent actions will be added by the developers here.
                then send cycleScanner.scanReport via scanSpaceServicesCommandPort; //grid scan report
                then terminate this;
            }

            then action directionalScan {
                doc /*provides directional scan services to the pilot on demand asynchronously.
                */
                accept ScanForThreatsCommand : ShipCommand via scanSpaceServicesCommandPort;
                then action scanSpace {out scanReport : String;} //technology dependent actions will be added by the developers here.
                then send scanSpace.scanReport via scanSpaceServicesCommandPort; //directional scan report
                then terminate this;
            }
    }

    action initializeNavigationServices {
        doc /*Approach a signature using the navigation system.
        */
        in navigationServicesCommandPort : PodPort;

        first start;
        then action powerUpNavigationSystem; //technology dependent actions will be added by the developers here.
        then fork;
            then action approachSignatureAtRange {

                accept ApproachSignatureAtRangeCommand : ShipCommand via navigationServicesCommandPort;
                //technology dependent actions will be added by the developers here.
                then action reportStatusApproach {out shipReport : String;}
                then send reportStatusApproach.shipReport via navigationServicesCommandPort;//Approach in progress        
            }
            then action orbitSignatureAtRange; //technology dependent actions will be added by the developers here.
            then action keepAtRangeSignature; //technology dependent actions will be added by the developers here.
            then action dockInStation {
                doc /*Dock into a station to make repairs, resupply capacitor and support systems.
                */

                accept DockToStation : ShipCommand via navigationServicesCommandPort;
                then action requestDockingClearance {in station : CelestialSignature; out ShipReport : String;}
                //technology dependent actions will be added by the developers here.
                then send requestDockingClearance.ShipReport via navigationServicesCommandPort;
                then accept DockingRequestAccepted : ShipCommand;
                //technology dependent actions will be added by the developers here.
                then action reportRequestAccepted {out shipReport : String;}
                then send reportRequestAccepted.shipReport via navigationServicesCommandPort; //Approach in progress
            }
    }

    //the next behavior need to be configured to each different type of vessel
    abstract action initializeExtensionModule { //technology dependent actions will be added by the developers here.
        doc /* 
            * Activates all service modules in a configured ship
            * Record all installed modules in the configuration of the system and enables them
            */
        in moduleServicesCommandPort : PodPort;
        in module : ImperialStandardModule;

        first start;
        then action configureModule {
            in module : ImperialStandardModule; 
            out commandModule : ShipCommand;
            out reportModule : ShipReport; 
        } //technology dependent actions will be added by the developers here.
        then action powerUpModule; //technology dependent actions will be added by the developers here.
        then action diagnoseModule; //technology dependent actions will be added by the developers here.
        then action enableModuleServices; //technology dependent actions will be added by the developers here.
        then accept configureModule.commandModule;
        then perform action moduleFunction ::> configureModule.module.imperialStandardModuleAction;
        then accept configureModule.reportModule;
        then action reportStatusModule {out shipReport : ShipReport;}
        then send reportStatusModule.shipReport via moduleServicesCommandPort;
    }

    //the next behavior need to be configured to each different type of vessel
    abstract action initializeExtensionRig { //technology dependent actions will be added by the developers here.
        doc /* 
            * Activates all rigs in a configured ship
            * Record all installed rigs in the configuration of the system and enables them
            */
        in shipRig : ImperialStandardRig;

        first start;
            then action configureRig {
                in shipRig : ImperialStandardRig; 
            } //technology dependent actions will be added by the developers here.
            then action powerUpRig; //technology dependent actions will be added by the developers here.
            then action diagnoseRig; //technology dependent actions will be added by the developers here.
            then action enableRig; //technology dependent actions will be added by the developers here.
    }

    action prepareForWarp {
        doc /* Engage the warp drive to travel to a celestial destination. 
        */
        in warpCommandPort : PodPort;
        in warpBubbleEnd : CelestialSignature;
        in atRange : Real;

        accept ExecuteWarpDriveCommand : ShipCommand via warpCommandPort;
        //technology dependent actions will be added by the developers here.
        then action reportStatusWarpDrive {out shipReport : ShipReport;}
        then send reportStatusWarpDrive.shipReport via warpCommandPort; //warpDrive engaged
        //technology dependent actions will be added by the developers here.
        then action reportStatusDestination {out shipReport : String;}
        then send reportStatusDestination.shipReport via warpCommandPort; //Destination reached
    }
            
    
}