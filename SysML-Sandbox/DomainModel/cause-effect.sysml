package causeEffect {
	
	private import DomainPackage::domain;
	private import CauseAndEffect::*;

	//The cause-effect relationships
	//This section is not correctly parsed and needs further corrections
	#causation connect domain.alphaMiningCorporation.highSecMiningPilotPod.miningRateIncreases to domain.asteroidBelt.asteroids.oreYieldIncreases;
	#causation connect domain.alphaMiningCorporation.highSecMiningPilotPod.cargoCapacityIncreases to domain.alphaMiningCorporation.corpFleet.downtimeReduces;
	#causation connect domain.alphaMiningCorporation.highSecMiningPilotPod.shieldStrengthIncreases to domain.alphaMiningCorporation.corpFleet.survivabilityEnhances;
	#causation connect domain.alphaMiningCorporation.highSecMiningPilotPod.threatDetectionImproves to domain.alphaMiningCorporation.corpFleet.threatResponseImproves;
	#causation connect domain.alphaMiningCorporation.highSecMiningPilotPod.droneOperationsImprove to domain.alphaMiningCorporation.corpFleet.operationalEfficiencyIncreases;
	#causation connect domain.alphaMiningCorporation.highSecMiningPilotPod.warpSpeedIncreases to domain.alphaMiningCorporation.corpFleet.downtimeReduces;
	#causation connect domain.alphaMiningCorporation.corpFleet.fleetCoordinationImproves to domain.alphaMiningCorporation.corpFleet.operationalEfficiencyIncreases;
	
	#multicausation connection {
	    end #cause ::> domain.asteroidBelt.asteroids.oreYieldIncreases;
	    end #cause ::> domain.alphaMiningCorporation.corpFleet.downtimeReduces;
	    end #effect ::> domain.alphaMiningCorporation.corpFleet.oreExtractionEfficiencyIncreases;
	}
	
	#multicausation connection {
	    end #cause ::> domain.alphaMiningCorporation.corpFleet.survivabilityEnhances;
	    end #cause ::> domain.alphaMiningCorporation.corpFleet.threatResponseImproves;
	    end #effect ::> domain.alphaMiningCorporation.corpFleet.operationalEfficiencyIncreases;
	}
	
	#multicausation connection {
	    end #cause ::> domain.alphaMiningCorporation.corpFleet.operationalEfficiencyIncreases;
	    end #cause ::> domain.alphaMiningCorporation.corpFleet.oreExtractionEfficiencyIncreases;
	    end #effect ::> domain.alphaMiningCorporation.corpFleet.profitabilityMaximizes;
	}	
}