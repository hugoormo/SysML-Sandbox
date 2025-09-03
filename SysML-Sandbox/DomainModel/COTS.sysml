 package COTS {
 	
 	private import ScalarValues::*;
 	private import StdPortsAndInterfaces::*;
 	private import RollupAnalysis::*;
 	
    //COTS Imperial Standard Ship
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

        port highPowerSlot : HighSlotPort[1..8];
        port midPowerSlot : MediumSlotPort[1..5];
        port lowPowerSlot : LowSlotPort[1..8];
        port rigPort : RigPort[3];
        port podPort : ~PodPort[1];
        port dockingPort : ~DockingPort[1];

        state states {

            entry action initial;
            then state Parked {
                doc /* The mining frigate is parked inside a station and can be boarded. */
            } 	
            state Boarded {
                doc /* The mining frigate is boarded inside a station in the docking pad, available for 
                     * refitting, resupply, or cargo transfer. */
                exit action undockFromStation;
            }
            state InGrid {
                doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
            }
            state OnWarp {
                doc /* The mining frigate is in warp, traveling between locations. */
                entry action executeWarpDrive;
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
                do action initializeGridServices
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
                    then scanSpace;
                    then approachSignature;
                    then dockInStation;
                    then executeWarpDrive;
                    then updateSystemConfiguration;
                
                action scanSpace {
                    doc /* Scan the grid and range space for potential threats. */
                }

                action approachSignature {
                    doc /*Approach a signature using the navigation system.*/
                }
                
                action dockInStation {
                    doc /*Dock into a station to make repairs, resupply capacitor and support systems.*/
                }
                
                action executeWarpDrive {
                    doc /* Engage the warp drive to travel to the destination. */
                }
                
                action updateSystemConfiguration {
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
     
    //COTS Imperial standrard ship components
    abstract part def ImperialStandardComponent :> SimpleSpaceshipComponent;
    
    //COTS items
    item def ModuleCommand {
        attribute type: String;
    }
    item def ModuleReport {
        attribute type: String;
    }
 
    // COTS Module Definitions with Conjugated Ports**   
    abstract part def MinerModule :> ImperialStandardComponent{
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        attribute miningYield : Real;
        attribute cycleTime : Real;
        attribute range : Real;
        attribute moduleMass redefines mass;
        attribute modulePowerUsage redefines powerGridUsage;
        attribute capacitorUsage redefines capacitorUsage;

        port highSlot : ~HighSlotPort;
        port laserBeam;
        
        // **Action: Extract Ore
        action extractOre { 
            in miningLaserPowerSupply = highSlot.power;
            in miningLaserTarget = highSlot.control;
            out miningLaserStatus = highSlot.control; 
        }
    }

    part def 'EP-S Gaussian Scoped Mining Laser' :> MinerModule {
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        attribute redefines miningYield = 50.0;
        attribute redefines cycleTime = 60.0;
        attribute redefines capacitorUsage = 5.0;
        attribute redefines range = 16.0;
        attribute redefines moduleMass = 500.0; // Mass in kg
        attribute redefines modulePowerUsage = 3.0;
    }
    part 'Mining Laser EP-S Gaussian Scoped' : 'EP-S Gaussian Scoped Mining Laser';

    part def MinerI :> MinerModule {
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        attribute redefines miningYield : Real = 40.0;
        attribute redefines cycleTime : Real = 60.0;
        attribute redefines capacitorUsage : Real = 5.0;
        attribute redefines range : Real = 10.0;
        attribute redefines moduleMass = 500.0; // Mass in kg
        attribute redefines modulePowerUsage = 2.0;
    }
    part minerI : MinerI;

    part def 'Particle Bore Compact Mining Laser' :> MinerModule {
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        attribute redefines miningYield : Real = 50.0;
        attribute redefines cycleTime : Real = 60.0;
        attribute redefines capacitorUsage : Real = 5.0;
        attribute redefines range : Real = 11.0;
        attribute redefines moduleMass = 500.0; // Mass in kg
        attribute redefines modulePowerUsage = 2.0;
    }
    part 'Mining Laser Particle Bore Compact' : 'Particle Bore Compact Mining Laser';

    part def Afterburner :> ImperialStandardComponent {
        doc /* Improves sublight speed by increasing thrust. */
        attribute velocityBonus : Real = 112.5;
        attribute activationCost : Real = 20.0;
        attribute cycleTime : Real = 10.0;
        attribute moduleMass redefines mass = 1000.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 20.0;

        port lowSlot : ~LowSlotPort;

        action boostSpeed;
    }

    part def SmallShieldExtenderI :> ImperialStandardComponent {
        doc /* Increases shield capacity for additional survivability. */
        attribute shieldHPBonus : Real = 262.0;
        attribute signatureRadiusIncrease : Real = 12.0;
        attribute moduleMass redefines mass = 1500.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 5.0;

        port mediumSlot : ~MediumSlotPort;

        action extendShield;
    }

    part def SmallCapBatteryI :> ImperialStandardComponent {
        doc /* Improves capacitor recharge and overall energy stability. */
        attribute capacitorBonus : Real = 125.0;
        attribute rechargeMultiplier : Real = 1.2;
        attribute moduleMass redefines mass = 800.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 0.0;

        port mediumSlot : ~MediumSlotPort;

        //this is a passive module and has no actions that can be called upon.

    }

    part def SurveyScannerI :> ImperialStandardComponent {
        doc /* Scans asteroids to determine ore content before mining. */
        attribute scanRange : Real = 15000.0;
        attribute cycleTime : Real = 5.0;
        attribute moduleMass redefines mass = 500.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 2.0;

        port mediumSlot : ~MediumSlotPort;

        action scanAsteroid;
    }

    part def WarpCoreStabilizerI :> ImperialStandardComponent {
        doc /* Improves resistance against warp disruption (scramblers and disruptors). */
        attribute warpCoreStrengthBonus : Integer = 1;
        attribute targetingPenalty : Real = -40.0;
        attribute scanResolutionPenalty : Real = -10.0;
        attribute moduleMass redefines mass = 2000.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 0.0;

        port lowSlot : ~LowSlotPort;
    }

    part def DroneLinkAugmentor :> ImperialStandardComponent {
        doc /* These modules extend your drone control range. Drone Link Augmentors 
        * can be useful for drone ships and ships with nothing else to fit in their spare highslots. */

        port highSlot : ~HighSlotPort;
    }
}