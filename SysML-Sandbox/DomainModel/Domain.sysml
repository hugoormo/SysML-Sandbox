package DomainPackage {
	
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
    private import StdPortsAndInterfaces::*;
	private import MiningFrigatePackage::*;
	private import CauseAndEffect::*;
    private import CausationConnections::*;
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
        part alphaMiningCorporation: MiningCorporation [1] {
            attribute buybackPerentage : Real;   // %  instant buy back percentage of the market price
        }
        part competingMiningCorporation : MiningCorporation [*];
        part drone : Drone[1..*];
    }
    part domain : Domain;

    // Definitions of domain objects
    part def Spaceship :> ImperialStandardShip; //Placeholder for any kind of spaceship not yet specified
  
    part def MiningCorporation {
         #moe attribute minimumProfitHS : Real {
            doc /* Definition: Total ISK/hour earned after deducting operational costs in High Sec 
             * (e.g., ship losses, resupply, and maintenance). 
             * Relevance: Profitability is the ultimate measure of success for the corporation. 
             * Optimization: Operate in areas with the best risk-reward balance 
             * (e.g., High Sec for safety, Wormholes or Null Sec for high-value ores). 
             * Avoid overfitting ships in areas with high loss probability 
             * (e.g., Ventures in Wormholes or Low Sec).
             */
        }          // ISK/hour

        #moe attribute minimumProfitLS : Real {
            doc /* Definition: Total ISK/hour earned after deducting operational costs in Low Sec
            */
        }  // ISK/hour

        #moe attribute minimumProfitNS : Real {
            doc /* Definition: Total ISK/hour earned after deducting operational costs in Null Sec
            */
        }  // ISK/hour

        #moe attribute fleetUtilization : Real {
            doc /* Definition: The percentage of operational mining frigates deployed per cycle.
             * Relevance: Higher fleet utilization ensures better efficiency and revenue. 
             * Optimization: Maintain an 80%+ utilization rate by minimizing downtime 
             * (e.g., ensure refitting cycles do not overlap with peak mining hours).
             */
        }          // %

        #moe attribute oreExtractionEfficiency : Real {
            doc /* Definition: The amount of ore extracted per operational cycle (m³/cycle). 
             * Relevance: High extraction rates correlate with overall profitability. 
             * Optimization: Use appropriate mining lasers, max fleet bonuses, and optimize asteroid selection.
             */
        }          // m³/cycle

        #moe attribute oreDeliveryEfficiency : Real {
            doc /* Definition: The average delivery time per batch of ore transported (seconds). 
             * Relevance: Faster deliveries reduce market price exposure and downtime. 
             * Optimization: Optimize mining locations closer to station hubs or Rorquals for compression.
             */
        }          // seconds

        #moe attribute storageCapacityUtilization : Real {
            doc /* Definition: The percentage of ore storage capacity currently utilized.
             * Relevance: Ensures effective planning of mining operations to avoid overloading or idling. 
             * Optimization: Expand storage or increase delivery frequency based on utilization rates.
             */
        }          // %

        #moe attribute fleetSizeEffectiveness : Integer {
            doc /* Definition: Measures how effectively fleet size contributes to mining efficiency.
             * Relevance: Avoids over-scaling, which could increase operational costs.
             * Optimization: Balance fleet size with profit margins, avoiding unnecessary ship deployment.
             */
        }          // Fleet utilization metric

        #moe attribute securityCoverageEffectiveness : Real {
            doc /* Definition: The percentage of mining operations that have security escort coverage.
             * Relevance: Essential for safe mining in Low Sec, Null Sec, and Wormholes. 
             * Optimization: Maintain at least 30% security coverage in high-risk areas.
             */
        }          // %

        #moe attribute threatResponseEffectiveness : Real {
            doc /* Definition: The average response time to threats during mining operations (seconds).
             * Relevance: Faster response times improve fleet survivability. 
             * Optimization: Deploy scouts and maintain emergency warp-out procedures.
             */
        }          // seconds

        #moe attribute operationalUptime : Real {
            doc /* Definition: The percentage of time the corporation is actively mining and generating revenue.
             * Relevance: Maximizing uptime directly increases profitability.
             * Optimization: Reduce transition times between mining and logistics.
             */
        }          // %

        #moe attribute deploymentEfficiency : Real {
            doc /* Definition: The percentage of planned mining deployments that are executed successfully.
             * Relevance: Higher efficiency reduces logistical delays and improves ROI.
             * Optimization: Standardize deployment protocols and improve scheduling coordination.
             */
        }          // %

        #moe attribute costEfficiency : Real {
            doc /* Definition: The ratio of ISK spent per ISK earned in mining operations.
             * Relevance: Determines operational sustainability and long-term growth. 
             * Optimization: Reduce unnecessary ship/module expenditures while maximizing income sources.
             */
        }          // ISK spent per ISK earned

        #moe attribute marketAdaptability : Real {
            doc /* Definition: The corporation's ability to adapt mining operations to fluctuating ore market prices.
             * Relevance: Avoids mining low-value ores and improves revenue optimization.
             * Optimization: Adjust operations dynamically based on real-time market data.
             */
        }          // %
        
        part highSecCorpMiningFrigate :> highSecMiningFrigate [1..*];
        part lowSecCorpMiningFrigate :> lowSecMiningFrigate [1..*];
        part nullSecCorpMiningFrigate :> nullSecMiningFrigate [1..*];
        
        part rorqual : Rorqual [1..*];

        part highSecMiningPilotPod : PilotPod [1..*] ordered {
            //Ship and pilot define the combined operational performance.
            //Training of the pilot will also impact the performance of the frigate: Considered only exemplary.
            //The generic spaceship of a Pilot Pod is redefined to be the high sec mining frigate 
            attribute operationalMiningProfitability :>> operationalProfitability;
            ref part highSecCorpMiningFrigate : MiningFrigatePackage::highSecMiningFrigate :>> spaceship [1] {
                #mop attribute operationalMiningRate = 
                miningRate *
                highSecMiningPilotPod.skillsSet.miningEfficiency;
            }
            // Cause and Effect Occurrences
	        timeslice miningRateIncreases;
	        timeslice cargoCapacityIncreases;
	        timeslice shieldStrengthIncreases;
	        timeslice threatDetectionImproves;
	        timeslice droneOperationsImprove;
	        timeslice warpSpeedIncreases;
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
        part lowSecMiningPilotPod : PilotPod [1..*] ordered {
            attribute operationalMiningProfitability :>> operationalProfitability;
            ref part lowSecCorpMiningFrigate : MiningFrigatePackage::lowSecMiningFrigate :>> spaceship [1] {
                #mop attribute operationalMiningRate = 
                miningRate *
                lowSecMiningPilotPod.skillsSet.miningEfficiency;
            }
        }
        part nullSecMiningPilotPod : PilotPod [1..*] ordered {
            attribute operationalMiningProfitability :>> operationalProfitability;
            ref part nullSecCorpMiningFrigate : MiningFrigatePackage::nullSecMiningFrigate :>> spaceship [1] {
                #mop attribute operationalMiningRate = 
                miningRate *
                nullSecMiningPilotPod.skillsSet.miningEfficiency;
            }
        }

    }
    
    // parts of the domain
    part def PilotPod {
        attribute skillsSet : SkillsSetPilot;
        attribute controlEfficiency : Real default 0.6;         // Efficiency of command execution (%)
        attribute fleetSize: Integer;
        attribute operationalProfitability : Real;
        port podPort: PodPort;
        ref part spaceship : Spaceship[0..1];
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