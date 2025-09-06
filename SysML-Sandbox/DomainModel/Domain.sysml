package DomainPackage {
	
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
    private import StdPortsAndInterfaces::*;
	private import MiningFrigatePackage::*;
	private import CauseAndEffect::*;
    private import CausationConnections::*;
    private import MissionRequirements::*;
    private import COTS::*;
	

    // Root object for the domain
    part def Domain {
        part pilotPod : PilotPod[1..*];
        part asteroidBelt : AsteroidBelt[1..*];
        part hostilePilotPod : HostilePilotPod [0..*];
        part station : Station [0..*];
        part marketHub : Station [1] {
           attribute highSecOreValue : Real; // ISK/m³ (e.g., Veld/Scord/Pyrox/Plag)
           attribute lowSecOreValue : Real; // ISK/m³ (e.g., Hemo/Hed/Jaspet)
           attribute nullSecOreValue : Real; // ISK/m³ (e.g., Spod/Mercoxit)
        }
        part miningCorporation: MiningCorporation [1] {
            attribute buybackPercentage : Real;   // %  instant buy back percentage of the market price

            //the miningCorporation must fulfill the mission reauirements
            satisfy missionRequirementsSpecification;
        }
        part competingMiningCorporation : MiningCorporation [*];
        part drone : Drone[1..*];
    }
    part domain : Domain;

    // Definitions of domain objects
    part def Spaceship :> ImperialStandardShip; //Placeholder for any kind of spaceship not yet specified
  
    part def MiningCorporation {
       
        part highSecCorpMiningFrigate :> highSecMiningFrigate [1..*];
        part lowSecCorpMiningFrigate :> lowSecMiningFrigate [1..*];
        part nullSecCorpMiningFrigate :> nullSecMiningFrigate [1..*];     
        part rorqual : Rorqual [1..*];

        part miningPilotPod : MiningPilotPod;

        part highSecMiningPilotPod :> miningPilotPod [1..*] ordered {
            //Ship and pilot define the combined operational performance.
            //Training of the pilot will also impact the performance of the frigate: Considered only exemplary.
            //The generic spaceship of a Pilot Pod is redefined to be the high sec mining frigate 
            #moe attribute operationalMiningProfitability :>> operationalProfitability;
            #moe attribute operationalMiningRate = 
                highSecCorpMiningFrigate.miningRate *
                highSecMiningPilotPod.skillsSet.miningEfficiency {               // m³/cycle
                    doc /* Definition: The amount of ore extracted per operational cycle (m³/cycle). 
                    * Relevance: High extraction rates correlate with overall profitability. 
                    * Optimization: improve skill set of pilot
                    */
                }
            ref part highSecCorpMiningFrigate : MiningFrigatePackage::highSecMiningFrigate :>> spaceship [1];
        }

        part corpFleet : Fleet [1..*]{
            timeslice fleetCoordinationImproves;
            timeslice downtimeReduces;
	        timeslice survivabilityEnhances;
	        timeslice threatResponseImproves;
	        timeslice operationalEfficiencyIncreases;
	        timeslice oreExtractionEfficiencyIncreases;
	        timeslice profitabilityMaximizes;

            attribute asteroidMiningMobilityEfficiency : Real; // waste ratio applied for moving within the asteroid field.
            attribute logisticEfficency : Real;  // %  efficency of logistics support
            attribute fleetMiningBoost : Real;   //  % Command mining ship boost in percentage
        }
        //further pilots will be required for low anf null sec
        //here partially defined.
        part lowSecMiningPilotPod :> miningPilotPod [1..*] ordered {
            #moe attribute operationalMiningProfitability :>> operationalProfitability;
            #moe attribute operationalMiningRate = 
                lowSecCorpMiningFrigate.miningRate *
                lowSecMiningPilotPod.skillsSet.miningEfficiency {               // m³/cycle
                    doc /* Definition: The amount of ore extracted per operational cycle (m³/cycle). 
                    * Relevance: High extraction rates correlate with overall profitability. 
                    * Optimization: improve skill set of pilot
                    */
                }
            ref part lowSecCorpMiningFrigate : MiningFrigatePackage::lowSecMiningFrigate :>> spaceship [1];
        }
        part nullSecMiningPilotPod :> miningPilotPod [1..*] ordered {
            #moe attribute operationalMiningProfitability :>> operationalProfitability;
            #moe attribute operationalMiningRate = 
                nullSecCorpMiningFrigate.miningRate *
                nullSecMiningPilotPod.skillsSet.miningEfficiency {               // m³/cycle
                    doc /* Definition: The amount of ore extracted per operational cycle (m³/cycle). 
                    * Relevance: High extraction rates correlate with overall profitability. 
                    * Optimization: improve skill set of pilot
                    */
                }
            ref part nullSecCorpMiningFrigate : MiningFrigatePackage::nullSecMiningFrigate :>> spaceship [1];
        }

    }
    
    // parts of the domain
    part def PilotPod {
        attribute skillsSet : SkillsSetPilot;
        attribute controlEfficiency : Real default 0.6;         // Efficiency of command execution (%)
        attribute fleetSize: Integer;
        #moe attribute operationalProfitability : Real;
        port podPort: PodPort;
        ref part spaceship : Spaceship[0..1];
    }

    part def MiningPilotPod :> PilotPod {
        // Cause and Effect Occurrences
        timeslice miningRateIncreases;
        timeslice cargoCapacityIncreases;
        timeslice shieldStrengthIncreases;
        timeslice threatDetectionImproves;
        timeslice droneOperationsImprove;
        timeslice warpSpeedIncreases;
    }

    part def Fleet {
        doc /*A commander Fleet consists fo maximum 8 pilots*/
        ref part fleetCommanderShip : PilotPod  [1] {
            attribute redefines fleetSize = 8;
        }
        ref part fleetShip : PilotPod [1..8];
    }
    
    part def Rorqual :> Spaceship {
        #mop attribute oreStorageCapacity : Real; //Rorquals can tractor and store storage containers
        attribute oreCompressionRatio : Real;
        part oreCompressionUnit : OreCompressionUnit; //Module used to compress Ores
    }
    
    part def OreCompressionUnit {
    	attribute compressionFactor : Real;      // Compression factor
    }    
    
    part def AsteroidBelt {
    	#mop attribute resourceAvailability : Real;      // Total available ore in the belt (m³)
        part asteroids : Asteroid [1..*];
    }

    part def Asteroid {
    	#mop attribute oreContent : Real;                // Quantity of ore available (m³)
        #mop attribute depletionRate : Real;             // Rate at which ore is extracted (m³/hour)
        port asteroidOrePort : AsteroidOrePort;
        timeslice oreYieldIncreases;
    }

    part def HostilePilotPod :> PilotPod {
        #mop attribute attackProbability : Real;         // Probability of engaging the mining frigate (%)
        #mop attribute weaponStrength : Real;            // Damage potential of weapons (DPS)
        attribute threatLevel : String;
        attribute weaponType : String;
        port weaponPort : ThreatPort;
        ref part combatSpaceship :>> spaceship;
    }

    part def Station {
        attribute dockingCapacity : Integer;
        attribute location : String;
        port dockingPort: DockingPort;
    }
    
    part def Drone {
        attribute type : String;
        attribute size : String;
        port droneControlPort: DroneControllerPort;
        port droneThreatPort : ThreatPort;
    }
	
	// Port definitions
	
	port def AsteroidOrePort {
		out item ore : Ore;
	}

	port def ThreatPort {
		out item firePower : FirePower;
	}
	
	port def DroneControllerPort {
		in item droneCommand : DroneCommand;
		out item droneReport : DroneReport;
	}	
	
	// Interfaces definition
    interface def CommandIF {
        end controlSend : PodPort;
        end controlReceive : ~PodPort;
        //flows are defined within the interface
        flow of ShipCommand from controlSend.command to controlReceive.command;
        flow of ShipReport from controlReceive.shipReport to controlSend.shipReport;
    }
    
	interface def PowerDockIF {
        end shipDockingPort : ~DockingPort;
        end stationDockingPort : DockingPort;
        flow of Power : Real from stationDockingPort.charge to shipDockingPort.charge;
        flow of CargoContainer from shipDockingPort.cargo to stationDockingPort.cargo;      
    }
	interface def AsteroidOreIF {
        end shipOrePort : ~AsteroidOrePort;
        end asteroidOrePort : AsteroidOrePort;
        flow of Ore from asteroidOrePort.ore to shipOrePort.ore;     
    }    
	interface def ThreatIF {
        end threadIncomingPort : ~ThreatPort;
        end threatOutgoingPort : ThreatPort;
        flow of FirePower from threatOutgoingPort.firePower to threadIncomingPort.firePower;     
    }
    interface def DroneIF {
        end droneControllerPort : ~DroneControllerPort;
        end droneControllPort : DroneControllerPort;
        flow of DroneCommand from droneControllerPort.droneCommand to droneControllPort.droneCommand;
        flow of DroneReport from droneControllPort.droneReport to droneControllerPort.droneReport;     
    }     
    
    
    // Items that Flow Between Domain Objects
    item def ShipComms;
    
    item def  ActivateMiningLaserCommand :> ShipCommand;
    
    item def  ScanForThreatsCommand :> ShipCommand; 
    
    item def  ExecuteWarpDriveCommand :> ShipCommand{
        attribute signatureCelestial : CelestialSignature;
        attribute warpToDistance : Integer;
    }
    
    item def  SelectDronesForDeploymentCommand :> ShipCommand;
    
    item def  ApproachSignatureCommand :> ShipCommand {
        attribute signatureGrid : GridSignature;
        attribute approachToDistance : Integer;
    }
    
    item def  EngagePropulsionCommand :> ShipCommand {
        attribute TrottlePercentage : Integer;
    }
    
    item def  DetectThreatCommand :> ShipCommand;
    
    item def  EngageDefensesCommand :> ShipCommand{
        attribute signatureGrid : GridSignature;
    }
    
    item def  DockToStation :> ShipCommand {
        attribute signatureCelestial : CelestialSignature;
    }

    item def DroneCommand :> ShipCommand {
        attribute droneID: String;
    }  
    
    item def UndockFromStationCommand :> StationCommand;
    item def TransferOreCommand :> StationCommand;
    item def DockingRequestAccepted :> StationCommand;  

    item def SkillsSetPilot {
        attribute miningEfficiency : Real;
        attribute maxLockedTargets : Integer; 
    }
    
    item def Ore {
        attribute purity : Real;
        attribute quantity : Real;
    }

    item def GravitationalWave;

    item def FirePower {
        attribute type : String;
        attribute strenght : String;
    }  
    
    item def DroneReport :> ShipReport {
    	attribute DroneID: String;
    }
    
    item def Course {
        attribute waypoints: String;
        attribute distance: Real;
    }

    item def CelestialSignature {
        doc /*Large Signatures that are available within the system range*/
        attribute type: String;
        attribute CelestialSignatureID: String;
    }

    item def GridSignature {
        doc /*Small Signatures that are continously refreshed at grid range or 
        *up to a few parsecs using the directional scanner
        */
        attribute type: String;
        attribute GridSignatureID: String;
    }
    
    package ViewsAndViewsDefinition {
        //Views and views definition
        view def 'Domain Structure View'{
            satisfy StakeholderConcerns::FleetProfitabilityConcern;

            filter @SysML::PartUsage;
        }
        view 'Mining Frigate structure Table View' : 'Domain Structure View' {
            expose MiningCorporation::highSecMiningPilotPod::*;
            //render asElementTable;
        }
    }   
}