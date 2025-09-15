package MiningFrigateRequirementsDef {

    private import OperationalDomain::*;
    private import ScalarValues::*;
    private import StakeholderConcerns::*;
    private import MiningFrigateBlackBoxSpecification::**;
    
    // System Requirements Definition. These are a managed as a Configuration item.
    requirement def <MFRQ01> OreExtractionEfficiencyRequirement { 
             
        subject miningFrigate : MiningFrigateVentureClass;
        doc /* The Mining Frigate shall extract ore at a minimum rate appropriate for
            * the security status of the operation system. 
            */ 
        frame concern OreYieldConcern;
    }

    //other exemplary requirements that have not been analyzed so far. 
    requirement def <MFRQ02> CargoCapacityRequirement {
        doc /* The Mining Frigate shall have a cargo capacity of at least 5,000 m³ (expandable by modules). */
        subject miningFrigate : MiningFrigateVentureClass;
        require constraint { highSecMiningFrigate.cargoHoldCapacity >= 5000.0 } // m³
        
        frame concern TotalProfitabilityConcern;
    }

    requirement def <MFRQ03> SurvivabilityRequirement {
        doc /* The Mining Frigate shall withstand at least 200 DPS in High Sec and 400 DPS 
            */
		subject miningFrigate : MiningFrigateVentureClass;
        require constraint { highSecMiningFrigate.shieldStrength >= 200.0 } // High Sec (DPS)
        
        frame concern SecurityConcern ;
        frame concern SurvivabilityConcern;
    }

    requirement def <MFRQ04> DroneOperationsRequirement {
        doc /* The Mining Frigate shall support the deployment of at least 5 drones for 
              mining and combat operations. */
        subject miningFrigate : MiningFrigateVentureClass;
        require constraint { highSecMiningFrigate.droneCapacity >= 5 } // Minimum number of drones
        
        frame concern ThreatNeutralizationConcern;
        frame concern OreYieldConcern;
    }

    requirement def <MFRQ06> TravelEfficiencyRequirement {
        doc /* The Mining Frigate shall have a warp speed of at least 5 AU/second 
              and an align time of less than 3 seconds. */
        subject miningFrigate : MiningFrigateVentureClass;
        require constraint { highSecMiningFrigate.warpSpeed >= 5.0 } // Warp speed (AU/second)
        require constraint { highSecMiningFrigate.alignTime <= 3.0 } // Align time (seconds)
        
        frame concern DeploymentEfficiencyConcern;
    }

    requirement def <MFRQ07> MiningTargetRequirement {
        doc /* The Mining Frigate shall lock and mine up to 3 asteroid targets simultaneously. */
        subject miningFrigate : MiningFrigateVentureClass;
        require constraint { domain.miningCorporation.highSecMiningPilotPod.highSecCorpMiningFrigate.maxLockedTargets >= 3 } // Maximum asteroid targets
        
        frame concern OreYieldConcern;
    }
}

package MiningFrigateRequirements {

    private import OperationalDomain::*;
    private import ScalarValues::*;
    private import MiningFrigateRequirementsDef::*;
    private import MiningFrigateBlackBoxSpecification::**;

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
}