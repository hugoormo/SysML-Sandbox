package MiningFrigateRequirements {

    private import DomainPackage::*;
    private import ScalarValues::*;
    private import MiningFrigateRequirementsDef::*;
    private import MiningFrigatePackage::*;

    //Mining Frigate Requirement assertions for the Mining Frigates
    // from the calculation in the Analysis.
    requirement <MFRQF01_1> oreExtractionEfficiencyRequirementHighSec : OreExtractionEfficiencyRequirement {
    	subject myMiningFrigate :> highSecMiningFrigate;
        doc /* The Mining Frigate shall extract ore at a minimum rate of 20 m³/minute in High Sec 
            */ 

        require constraint { highSecMiningFrigate.miningRate >= 20.0 }
    }

    requirement <MFRQF01_2> oreExtractionEfficiencyRequirementLowSec : OreExtractionEfficiencyRequirement {
    	subject myMiningFrigate :> lowSecMiningFrigate;
        doc /* The Mining Frigate shall extract ore at a minimum rate of 30 m³/minute in Low Sec 
            */ 
        
        require constraint { lowSecMiningFrigate.miningRate >= 30.0 }
    }

    requirement <MFRQF01_3> oreExtractionEfficiencyRequirementNullSec : OreExtractionEfficiencyRequirement {
    	subject myMiningFrigate :> nullSecMiningFrigate;
        doc /* The Mining Frigate shall extract ore at a minimum rate of 40 m³/minute in Null Sec 
            */  

        require constraint { nullSecMiningFrigate.miningRate >= 40.0 }
    }
    

    //other exemplary requirements that have not been analyzed so far. 
    requirement <MFRQF02_1> cargoCapacityRequirementLowSec : CargoCapacityRequirement {
    	subject myMiningFrigate :> highSecMiningFrigate;
    }

    requirement <MFRQF03_1> survivabilityRequirementLowSec : SurvivabilityRequirement {
    	subject myMiningFrigate :> highSecMiningFrigate;
    }

    requirement <MFRQF04_1> droneOperationsRequirementLowSec : DroneOperationsRequirement {
        subject myMiningFrigate :> highSecMiningFrigate;
    }

    requirement <MFRQF06_1> travelEfficiencyRequirementLowSec : TravelEfficiencyRequirement {
        subject myMiningFrigate :> highSecMiningFrigate;
    }

    requirement <MFRQF07_1> miningTargetRequirementLowSec : MiningTargetRequirement {
        subject myMiningFrigate :> highSecMiningFrigate;
    } 
}