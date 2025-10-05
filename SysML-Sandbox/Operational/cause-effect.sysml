package causeEffect {
	
	private import OperationalDomain::domain;
	private import CauseAndEffect::*;

	//The cause-effect relationships
	//This section is not correctly parsed and needs further corrections
	#causation connect domain.miningCorporation.miningPilotPod.miningRateIncreases to domain.asteroidBelt.asteroids.oreYieldIncreases {
		attribute isSufficient = true; //default is false
	}
	#causation connect domain.miningCorporation.miningPilotPod.shieldStrengthIncreases to domain.miningCorporation.corpFleet.survivabilityEnhances;
	#causation connect domain.miningCorporation.miningPilotPod.threatDetectionImproves to domain.miningCorporation.corpFleet.threatResponseImproves;
	#causation connect domain.miningCorporation.miningPilotPod.droneOperationsImprove to domain.miningCorporation.corpFleet.operationalEfficiencyIncreases;
	#causation connect domain.miningCorporation.miningPilotPod.warpSpeedIncreases to domain.miningCorporation.corpFleet.downtimeReduces;
	
	#multicausation connection {
	    end #cause ::> domain.asteroidBelt.asteroids.oreYieldIncreases;
	    end #cause ::> domain.miningCorporation.corpFleet.downtimeReduces;
	    end #effect ::> domain.miningCorporation.corpFleet.oreExtractionEfficiencyIncreases;
	}
	
	#multicausation connection {
	    end #cause ::> domain.miningCorporation.corpFleet.survivabilityEnhances;
	    end #cause ::> domain.miningCorporation.corpFleet.threatResponseImproves;
	    end #effect ::> domain.miningCorporation.corpFleet.operationalEfficiencyIncreases;
	}
	
	#multicausation connection {
	    end #cause ::> domain.miningCorporation.corpFleet.operationalEfficiencyIncreases;
	    end #cause ::> domain.miningCorporation.corpFleet.oreExtractionEfficiencyIncreases;
	    end #effect ::> domain.miningCorporation.corpFleet.profitabilityMaximizes;
	}	
}