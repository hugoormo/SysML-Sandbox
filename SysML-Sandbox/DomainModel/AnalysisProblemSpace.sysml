package analysisProblemSpace {
	doc /*Analysis in the context of the problem space */
	
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import DomainPackage::*;
	private import MiningFrigatePackage::*;
	private import MiningFrigateRequirements::*;

    // **General Analysis Definition: Risk-Adjusted Profitability Calculation**
    analysis def PilotOperationalProfitability {

        subject analysisDomain : Domain;
        return pilotPodProfitability = calculatePilotPodProfitablity.calculatedPilotPodProfitablity;

        objective {
            doc /* Evaluates pilot profitability by considering ore value, buyout price,  
                * and mining efficency in asteroid belts.
                */
            
            assume constraint {domain.marketHub.highSecOreValue == 200.0}
            assume constraint {domain.marketHub.lowSecOreValue == 500.0}
            assume constraint {domain.marketHub.nullSecOreValue == 750.0}
            assume constraint {domain.alphaMiningCorporation.buybackPerentage == 0.85}
            assume constraint {domain.alphaMiningCorporation.corpFleet.asteroidMiningMobilityEfficiency == 0.95}
            assume constraint {domain.alphaMiningCorporation.corpFleet.logisticEfficency == 0.90}
            assume constraint {domain.alphaMiningCorporation.corpFleet.fleetMiningBoost == 0.80}
        }

        in pilotPodMiningRate : Real;       // m³/hour pilot pod technical mining rate 
        in oreMarketRetailValue : Real;           // ISK/m³ average market buy price
        in buybackPercentage : Real;   // %  instant buy back percentage of the market price
        in asteroidMiningEfficiency : Real;   // %  efficiency of mining in an asteroid belt in percentage
        in boost : Real;     //  % Command ship boost in percentage
        in logisticsEfficency : Real;   // %  efficency of logistics support 

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
	        
	        subject pilotPodMiner ::> domain.alphaMiningCorporation.highSecMiningPilotPod;
	        in pilotPodMiningRate = pilotPodMiner.highSecCorpMiningFrigate.operationalMiningRate;
            in buybackPercentage = domain.alphaMiningCorporation.buybackPerentage;
            in asteroidMiningEfficiency = domain.alphaMiningCorporation.corpFleet.asteroidMiningMobilityEfficiency;
	        in boost = domain.alphaMiningCorporation.corpFleet.fleetMiningBoost;   
            in logisticsEfficiency = domain.alphaMiningCorporation.corpFleet.logisticEfficency;
	    }
	
	    analysis lowSecProfitability : PilotOperationalProfitability {
	        
	        subject pilotPodMiner ::> domain.alphaMiningCorporation.lowSecMiningPilotPod;
	        in pilotPodMiningRate = pilotPodMiner.lowSecCorpMiningFrigate.operationalMiningRate;
            in buybackPercentage = domain.alphaMiningCorporation.buybackPerentage;
            in asteroidMiningEfficiency = domain.alphaMiningCorporation.corpFleet.asteroidMiningMobilityEfficiency;
	        in boost = domain.alphaMiningCorporation.corpFleet.fleetMiningBoost;   
            in logisticsEfficiency = domain.alphaMiningCorporation.corpFleet.logisticEfficency;
	    }

	    analysis nullSecProfitability : PilotOperationalProfitability {
	        
	        subject pilotPodMiner ::> domain.alphaMiningCorporation.nullSecMiningPilotPod;
	        in pilotPodMiningRate = pilotPodMiner.nullSecCorpMiningFrigate.operationalMiningRate;
            in buybackPercentage = domain.alphaMiningCorporation.buybackPerentage;
            in asteroidMiningEfficiency = domain.alphaMiningCorporation.corpFleet.asteroidMiningMobilityEfficiency;
	        in boost = domain.alphaMiningCorporation.corpFleet.fleetMiningBoost; 
            in logisticsEfficiency = domain.alphaMiningCorporation.corpFleet.logisticEfficency;
	    }
	    
	}  
}