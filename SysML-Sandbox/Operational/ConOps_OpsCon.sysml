package ConOps {

	part conOps {
		doc /*The Alpha corporation in Eve Online aims to reach a sustainable size of 100 active corporation members.
		 * To provide attractive income to corporation memebers and thus retain them, the Alpha corporation operates 
		 * fleets of mining frigates to extract valuable ore from asteroid belts and wormholes, refine it in fleet
		 * or in nearby stations, and deliver it to market hubs for resale.
		 * Weatlthy memebers can invest in combat ships and can therfore contribute to the security of the operations.
		 * The enterprise phases and capability resource configurations required to achive this goal are not in the scope of this model.
		 * These would be in a UAF Model that would provide the perspective of the enterprise.
		 * A limited scope of the capbilitiy resource configurations is modeled here in order to characterise the problem space.
		 * To reach the set goal the objectives are: 
		 * 1) Maximize Profitability: 
		 *    Extract the most valuable ores. Optimize mining efficiency and reduce operational costs. 
		 * 2) Ensure Operational Safety: 
		 *    Protect mining frigates, pilots, and assets from hostile threats. Minimize downtime caused by losses or disruptions. 
		 * 3) Sustain Long-Term Operations: 
		 *    Maintain a steady flow of resources. Minimize interruptions by ensuring logistics efficiency.
		 */
	}
}
package MissionRequirements {
	
	private import NaturalEnvironment::*;
	private import Structures::*;
	private import OperationalDomain::*;
	private import ScalarValues::*;
	private import StakeholderConcerns::*;
	    
	// Mission Requirements Definition.
    requirement def PilotProfitabilityRequirement { 
        doc /* A corporation in Eve Online shall guarantee a slightly over the average 
		 * profitability in order to provide suficcient incentive to pilots to work
         * for the corporation.
		 * This value is inferred from market analysis results outside of this model. 
         */      
        subject miningCorporation : MiningCorporation;
        attribute profitability : Real;
		attribute situationalAwareness : Real;
		attribute exposedEnvironentRisk : Real;
		attribute OreValue : Real;	  
    }

	//Mission Requiremnts Specification

	requirement missionRequirementsSpecification {
		doc /*
		* Mission Requirements Specification
		*/
		subject miningCorproration : MiningCorporation;

		require pilotProfitabilityRequirementHS;
		require pilotProfitabilityRequirementLS;
		require pilotProfitabilityRequirementNS;
	}

    requirement <MR01> pilotProfitabilityRequirementHS : PilotProfitabilityRequirement {
    	subject miningCorporation : MiningCorporation;
    	attribute :>> profitability = miningCorporation.highSecMiningPilotPod.operationalMiningProfitability;
		attribute :>> situationalAwareness = 1.0;
		attribute :>> exposedEnvironentRisk = 98.0;
		attribute :>> OreValue = 200.0;
		require constraint {profitability >= 7000000.0 } //ISK/hour

		//This requirement frames specifically the concerns here referred.
        frame PilotPodProfitabilityConcern;
    }

	requirement <MR02> pilotProfitabilityRequirementLS : PilotProfitabilityRequirement {
    	subject miningCorporation : MiningCorporation;
    	attribute :>> profitability = miningCorporation.lowSecMiningPilotPod.operationalMiningProfitability;
		attribute :>> situationalAwareness = 0.6;
		attribute :>> exposedEnvironentRisk = 75.0;
		attribute :>> OreValue = 500.0; 
		require constraint {profitability >= 14000000.0   } //ISK/hour

		//This requirement frames specifically the concerns here referred.
        frame PilotPodProfitabilityConcern;
    }

	requirement <MR03> pilotProfitabilityRequirementNS : PilotProfitabilityRequirement {
    	subject miningCorporation : MiningCorporation;
    	attribute :>> profitability = miningCorporation.nullSecMiningPilotPod.operationalMiningProfitability;
		attribute :>> situationalAwareness = 0.4;
		attribute :>> exposedEnvironentRisk = 50.0;
		attribute :>> OreValue = 700.0; 
		require constraint {profitability >= 20000000.0 } //ISK/hour

		//This requirement frames specifically the concerns here referred.
        frame PilotPodProfitabilityConcern;
    }	
	//More requirements for the operational safety and the sustainment of operations ought to be defined.
}
package OperationalConcept {

	private import OperationalDomain::*;
	private import ScalarValues::*;
	private import NaturalEnvironment::*;
	private import Structures::*;
	private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

	doc /*Overview: 
		* The Mining Corporation's fleet of mining frigates operates in High-Security (High Sec), Low-Security (Low Sec), 
		* Null-Security (Null Sec), and Wormhole Space (W-Space). Operations are coordinated from a central command, with pilots 
		* executing mining tasks and returning the ore to stations for processing.
		*/
	
	//Use cases are used to define the OpsCon.
	use case def HighSecMiningMission {  
		subject minerPilotPod : PilotPodsAndSpaceships::PilotPod [1..8] {
			event occurrence targetAsteroidBeltReceived [1];
			then perform action warpToCelestialOperationalProcedure;  
            event occurrence targetAsteroidReceived [1..5] ordered;
            then perform action approachAsteroidOperationalProcedure;
            then perform action mineAsteroidOperationalProcedure;
			perform action monitorAndDetectThreats;
			event occurrence threatDetectedSent;
			event occurrence threatNeutralizeReceived;
			perform action deployDefenseDrones;
            then event occurrence canOutSend; //the pilot releases a container (can) loaded with ore.
        }
		actor miningfleetCommander : PilotPodsAndSpaceships::PilotPod {
			event occurrence targetAsteroidBeltSent [1];
            event occurrence targetAsteroidSent [1..5] ordered;
			event occurrence threatDetectedReceived;
			perform action assessHostileForce;
			event occurrence threatNeutralizeSent;
			event occurrence transportHoldFullReceived;
			event occurrence transportReturnSent;
		}
		actor logisticsPilotPod : PilotPodsAndSpaceships::PilotPod[1]{
			event occurrence canOutReceived [1..*];
			then perform action beamCanOperationalProcedure [1..*] ordered;		
			then occurrence transportHoldFullSent;
			event occurrence transportReturnReceived;
			then perform action unloadAndReturnOperationalProcedure;
		}
        actor asteroidBelt : AsteroidBelt; 
		//the asteroid is part of the asteroid belt but in the context of the use case they are not "acting" in the same timeslice.
        actor asteroid : Asteroid [1..*] {
            event occurrence asteroidDeintegrationSend;
            then event occurrence asteroidDepletionSend;
        }       
        objective {
            doc /* Operational Workflow Deployment: 
				* Mining frigates are dispatched to asteroid belts or wormholes based on the availability of resources and risk levels.
				* Frigates extract ore using mining lasers, refine it onboard (if applicable), and store it in their cargo holds.
				* Hostile threats are neutralized using defense drones.
				* Processed ore is delivered to nearby stations or POS for storage or sale.  
                */
        }

        message of PodComms from miningfleetCommander.targetAsteroidBeltSent to minerPilotPod.targetAsteroidBeltReceived; 
        then message of PodComms from miningfleetCommander.targetAsteroidSent to minerPilotPod.targetAsteroidReceived;
        message of PodComms from minerPilotPod.threatDetectedSent to miningfleetCommander.threatDetectedReceived;
        message of PodComms from miningfleetCommander.threatNeutralizeSent to minerPilotPod.threatNeutralizeReceived;
        message of PodComms from minerPilotPod.canOutSend to logisticsPilotPod.canOutReceived;
		message of PodComms from logisticsPilotPod.transportHoldFullSent to miningfleetCommander.transportHoldFullReceived;
		message of PodComms from miningfleetCommander.transportReturnSent to logisticsPilotPod.transportReturnReceived;
	}
	
	//other use cases would be required for Low Sec, Null Sec and W-Space.
	use case def LowSecMiningMission; //a second fleet will be required to guard the gates and warn from reds in system.
	use case def NullSecMiningMission; //same as Low Sec. Only possible if NPC stations are available.
	use case def WSpaceMiningMission; //way complicated!
}