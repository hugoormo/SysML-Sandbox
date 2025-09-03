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
	
	private import DomainPackage::*;
	private import ScalarValues::*;
	private import StakeholderConcerns::*;
	    
	// Mission Requirements Definition.
    requirement def FleetProfitabilityRequirement { 
        doc /* A corporation in Eve Online shall guarantee a slightly over the average 
		 * profitability in order to provide suficcient incentive to pilots to work
         * for the corporation.
		 * This value is inferred from market analysis results outside of this model. 
         */      
        subject miningCorporation : MiningCorporation;
        attribute profitabilityHS : Real;
		attribute profitabilityLS : Real;
		attribute profitabilityNS : Real;
		attribute situationalAwarenessHS : Real;
		attribute situationalAwarenessLS : Real;
		attribute situationalAwarenessNS : Real;
		attribute exposedEnvironentRiskHS : Real;
		attribute exposedEnvironentRiskLS : Real;
		attribute exposedEnvironentRiskNS : Real;
		attribute highSecOreValue : Real;
		attribute lowSecOreValue : Real;
		attribute nullSecOreValue : Real;
		assume constraint {situationalAwarenessHS = 1.0;}  //no need for operational security
		assume constraint {situationalAwarenessLS = 0.6;}  //no need for scout fleet
		assume constraint {situationalAwarenessLS = 0.4;}  //need in-system scout fleet
		assume constraint {exposedEnvironentRiskHS = 98.0;}  //Very safe in high sec systems
		assume constraint {exposedEnvironentRiskHS = 75.0;}  // Increased risk of ship loss
		assume constraint {exposedEnvironentRiskNS = 50.0;}  // Very high risk, frequent losses
		assume constraint {highSecOreValue : Real = 200.0;}   // ISK/m³ (e.g., Veldspar, Scordite)
        require constraint {profitabilityHS >= 25000 } //ISK/hour
		require constraint {profitabilityLS >= 35000 } //ISK/hour
		require constraint {profitabilityNS >= 50000 } //ISK/hour
        
		//This requirement frames specifically the concerns here referred.
        frame concern fleetProfitabilityConcern : FleetProfitabilityConcern{
			:>> fleetProfitabilityHS = FleetProfitabilityRequirement::profitabilityHS;
			:>> fleetProfitabilityLS = FleetProfitabilityRequirement::profitabilityLS;
			:>> fleetProfitabilityNS = FleetProfitabilityRequirement::profitabilityNS;
		}
    }
    requirement <MR01> fleetProfitabilityRequirementHS : FleetProfitabilityRequirement {
    	subject alphaMiningCorporation;
    	attribute :>> profitabilityHS = alphaMiningCorporation.minimumProfitHS;
    }

	requirement <MR02> fleetProfitabilityRequirementLS : FleetProfitabilityRequirement {
    	subject alphaMiningCorporation;
    	attribute :>> profitabilityLS = alphaMiningCorporation.minimumProfitLS;
    }

	requirement <MR03> fleetProfitabilityRequirementNS : FleetProfitabilityRequirement {
    	subject alphaMiningCorporation;
    	attribute :>> profitabilityNS = alphaMiningCorporation.minimumProfitNS;
    }	
	//More requirements for the operational safety and the sustainment of operations ought to be defined.
}
package OperationalConcept {

	private import DomainPackage::*;
	private import ScalarValues::*;

	doc /*Overview: 
		* The Mining Corporation's fleet of mining frigates operates in High-Security (High Sec), Low-Security (Low Sec), 
		* Null-Security (Null Sec), and Wormhole Space (W-Space). Operations are coordinated from a central command, with pilots 
		* executing mining tasks and returning the ore to stations for processing.
		*/
	
	//Use cases are used to define the OpsCon.
	use case def HighSecMiningMission {  
		subject minerPilotPod : PilotPod [1..8] {
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
		actor miningfleetCommander : PilotPod {
			event occurrence targetAsteroidBeltSent [1];
            event occurrence targetAsteroidSent [1..5] ordered;
			event occurrence threatDetectedReceived;
			perform action assessHostileForce;
			event occurrence threatNeutralizeSent;
			event occurrence transportHoldFullReceived;
			event occurrence transportReturnSent;
		}
		actor logisticsPilotPod : PilotPod[1]{
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

        message of ShipComms from miningfleetCommander.targetAsteroidBeltSent to minerPilotPod.targetAsteroidBeltReceived; 
        then message of ShipComms from miningfleetCommander.targetAsteroidSent to minerPilotPod.targetAsteroidReceived;
        message of ShipComms from minerPilotPod.threatDetectedSent to miningfleetCommander.threatDetectedReceived;
        message of ShipComms from miningfleetCommander.threatNeutralizeSent to minerPilotPod.threatNeutralizeReceived;
        message of ShipComms from minerPilotPod.canOutSend to logisticsPilotPod.canOutReceived;
		message of ShipComms from logisticsPilotPod.transportHoldFullSent to miningfleetCommander.transportHoldFullReceived;
		message of ShipComms from miningfleetCommander.transportReturnSent to logisticsPilotPod.transportReturnReceived;
	}
	
	//other use cases would be required for Low Sec, Null Sec and W-Space.
	use case def LowSecMiningMission; //a second fleet will be required to guard the gates and warn from reds in system.
	use case def NullSecMiningMission; //same as Low Sec. Only possible if NPC stations are available.
	use case def WSpaceMiningMission; //way complicated!
}