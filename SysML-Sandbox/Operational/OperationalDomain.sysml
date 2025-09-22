package OperationalDomain {
	
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardInteractionPoints::*;
    private import NaturalEnvironment::*;
    private import Structures::*;
    private import PilotPodsAndSpaceships::*;
	private import MiningFrigateBlackBoxSpecification::**;
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
            ref part highSecCorpMiningFrigate : highSecMiningFrigate :>> spaceship [1];
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
            ref part lowSecCorpMiningFrigate : lowSecMiningFrigate :>> spaceship [1];
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
            ref part nullSecCorpMiningFrigate : nullSecMiningFrigate :>> spaceship [1];
        }

    }
    
    // parts of the domain  

    part def MiningPilotPod :> PilotPod {

        #moe attribute operationalProfitability : Real;

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

    part def HostilePilotPod :> PilotPod {
        #mop attribute attackProbability : Real;         // Probability of engaging the mining frigate (%)
        #mop attribute weaponStrength : Real;            // Damage potential of weapons (DPS)
        attribute threatLevel : String;
        attribute weaponType : String;
        port weaponPort : ThreatPort;
        ref part combatSpaceship :>> spaceship;
    }	
	
	// Interfaces definition
	interface def AsteroidOreIF {
        end shipOrePort : ~AsteroidOrePort;
        end asteroidOrePort : AsteroidOrePort;
        flow of Ore from asteroidOrePort.ore to shipOrePort.ore;     
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