package analysisProblemSpace {
	doc /*Analysis in the context of the problem space */
	
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import OperationalDomain::*;
	private import MiningFrigateBlackBoxSpecification::*;
	private import MiningFrigateRequirements::*;

    // **General Analysis Definition: Risk-Adjusted Profitability Calculation**
    analysis def PilotOperationalProfitability {

        subject analysisDomain : Domain;
        return pilotPodProfitability = calculatePilotPodProfitablity.calculatedPilotPodProfitablity;

        objective {
            doc /* Evaluates pilot profitability by considering ore value, buyout price,  
                * and mining efficency in asteroid belts.
                */
        }

        in pilotPodMiningRate : Real;       // m³/hour pilot pod technical mining rate 
        in oreMarketRetailValue : Real;           // ISK/m³ average market buy price
        in buybackPercentage : Real;   // %  instant buy back percentage of the market price
        in asteroidMiningEfficiency : Real;   // %  efficiency of mining in an asteroid belt in percentage
        in boost : Real;     //  % Command ship boost in percentage
        in logisticsEfficency : Real;   // %  efficency of logistics support. 1 for transport logistics provided.

        //Calculation Execution
        calc calculateEffectivePilotPodMiningRate : CalcEffectivePilotPodMiningRate {
            in pilotPodMiningRate;
            return calculatedEffectivePilotPodMiningRate;
        }
        calc calculatePilotPodProfitablity : CalcPilotPodProfitability {
            in effectivePilotPodMiningRate = calculateEffectivePilotPodMiningRate.calculatedEffectivePilotPodMiningRate;
            in buybackPercentage;
            in oreMarketRetailValue;
            return calculatedPilotPodProfitablity;
        }
        
        //Calculation definitions
	    calc def CalcEffectivePilotPodMiningRate {
	        in pilotPodMiningRate;
            in boost;
            in logisticsEfficency;
	        return : Real;  // Performance asteroid belt operational ratio      
	
	        pilotPodMiningRate * boost * logisticsEfficency * asteroidMiningEfficiency
	    }
	    calc def CalcPilotPodProfitability {
	        in effectivePilotPodMiningRate;
	        in buybackPercentage;
            in oreMarketRetailValue;
	        return : Real;  // ISK/hour
	
	        effectivePilotPodMiningRate * buybackPercentage * oreMarketRetailValue
	    }
    }

    // **Scenario-Specific Uses of Profitability Analysis**
    part pilotPodProfitabilityAnalysisContext {
    
	    
	    analysis highSecPilotPodProfitability : PilotOperationalProfitability {
	        
	        subject pilotPodMiner ::> domain.miningCorporation.highSecMiningPilotPod;
	        in pilotPodMiningRate = domain.miningCorporation.highSecMiningPilotPod.operationalMiningRate;
            in buybackPercentage = domain.miningCorporation.buybackPercentage;
            in asteroidMiningEfficiency = domain.miningCorporation.corpFleet.asteroidMiningMobilityEfficiency;
	        in boost = domain.miningCorporation.corpFleet.fleetMiningBoost;   
            in logisticsEfficiency = domain.miningCorporation.corpFleet.logisticEfficency;
	    }
	
	    analysis lowSecProfitability : PilotOperationalProfitability {
	        
	        subject pilotPodMiner ::> domain.miningCorporation.lowSecMiningPilotPod;
	        in pilotPodMiningRate = domain.miningCorporation.lowSecMiningPilotPod.operationalMiningRate;
            in buybackPercentage = domain.miningCorporation.buybackPercentage;
            in asteroidMiningEfficiency = domain.miningCorporation.corpFleet.asteroidMiningMobilityEfficiency;
	        in boost = domain.miningCorporation.corpFleet.fleetMiningBoost;   
            in logisticsEfficiency = domain.miningCorporation.corpFleet.logisticEfficency;
	    }

	    analysis nullSecProfitability : PilotOperationalProfitability {
	        
	        subject pilotPodMiner ::> domain.miningCorporation.nullSecMiningPilotPod;
	        in pilotPodMiningRate = domain.miningCorporation.nullSecMiningPilotPod.operationalMiningRate;
            in buybackPercentage = domain.miningCorporation.buybackPercentage;
            in asteroidMiningEfficiency = domain.miningCorporation.corpFleet.asteroidMiningMobilityEfficiency;
	        in boost = domain.miningCorporation.corpFleet.fleetMiningBoost; 
            in logisticsEfficiency = domain.miningCorporation.corpFleet.logisticEfficency;
	    }
	    
	}  
}