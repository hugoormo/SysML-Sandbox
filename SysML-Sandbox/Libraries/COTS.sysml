 package COTS {
 	
 	private import ScalarValues::*;
 	private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardInteractionPoints::*;
 	private import RollupAnalysis::*; 

    //COTS Imperial standrard ship components
    abstract part def ImperialStandardModule :> SimpleSpaceshipComponent {
        action imperialStandardModuleAction {
            in moduleCommand : ModuleToggleCommand;
            out moduleReport : ModuleReport;
        }
        action imperialStandardModuleOverheat {
            out performanceRating : Real;
            out damageReport : ModuleReport;
        }
    }
 
    //COTS Modules Definitions 
    abstract part def MinerModule :> ImperialStandardModule{
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
        action extractOre :>> imperialStandardModuleAction { 
            in :>> moduleCommand = highSlot.moduleControl;
            out :>> moduleReport = highSlot.moduleReport;
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

    part def Afterburner :> ImperialStandardModule {
        doc /* Improves sublight speed by increasing thrust. */
        attribute velocityBonus : Real = 112.5;
        attribute overheatVelocityBonus : Real = 185.0;
        attribute activationCost : Real = 20.0;
        attribute cycleTime : Real = 10.0;
        attribute moduleMass redefines mass = 1000.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 20.0;

        port lowSlot : ~LowSlotPort;

        action boostSpeed :>> imperialStandardModuleAction {
            in :>> moduleCommand = lowSlot.moduleControl;
            out :>> moduleReport = lowSlot.moduleReport;
        }
        action overheat :>> imperialStandardModuleOverheat {
            out :>> performanceRating;
            out :>> damageReport;
        }
    }

    part def SmallShieldExtenderI :> ImperialStandardModule {
        doc /* Increases shield capacity for additional survivability. */
        attribute shieldHPBonus : Real = 262.0;
        attribute signatureRadiusIncrease : Real = 12.0;
        attribute moduleMass redefines mass = 1500.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 5.0;

        port mediumSlot : ~MediumSlotPort;

        action extendShield :>> imperialStandardModuleAction {
            in :>> moduleCommand = mediumSlot.moduleControl;
            out :>> moduleReport = mediumSlot.moduleReport;
        }
    }

    part def SmallCapBatteryI :> ImperialStandardModule {
        doc /* Improves capacitor recharge and overall energy stability. */
        attribute capacitorBonus : Real = 125.0;
        attribute rechargeMultiplier : Real = 1.2;
        attribute moduleMass redefines mass = 800.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 0.0;

        port mediumSlot : ~MediumSlotPort;

        //this is a passive module and has no actions that can be called upon.

    }

    part def SurveyScannerI :> ImperialStandardModule {
        doc /* Scans asteroids to determine ore content before mining. */
        attribute scanRange : Real = 15000.0;
        attribute cycleTime : Real = 5.0;
        attribute moduleMass redefines mass = 500.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 2.0;

        port mediumSlot : ~MediumSlotPort;

        action scanAsteroid :>> imperialStandardModuleAction {
            in :>> moduleCommand = mediumSlot.moduleControl;
            out :>> moduleReport = mediumSlot.moduleReport;
        }
    }

    part def WarpCoreStabilizerI :> ImperialStandardModule {
        doc /* Improves resistance against warp disruption (scramblers and disruptors). */
        attribute warpCoreStrengthBonus : Integer = 1;
        attribute targetingPenalty : Real = -40.0;
        attribute scanResolutionPenalty : Real = -10.0;
        attribute moduleMass redefines mass = 2000.0; // Mass in kg
        attribute modulePowerUsage redefines powerGridUsage = 0.0;

        port lowSlot : ~LowSlotPort;
    }

    part def DroneLinkAugmentor :> ImperialStandardModule {
        doc /* These modules extend your drone control range. Drone Link Augmentors 
        * can be useful for drone ships and ships with nothing else to fit in their spare highslots. */

        port highSlot : ~HighSlotPort;
    }

    //COTS Imperial standard Drones
    part def Drone {
        attribute type : String;
        attribute size : String;
        port droneControlPort: DroneControllerPort;
        port droneThreatPort : ThreatPort;
    }

    //COTS Imperial standard rigs
    part def ImperialStandardRig;

    
}