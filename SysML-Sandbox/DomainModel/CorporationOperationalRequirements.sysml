package corporationOperationalRequirements {

    private import DomainPackage::*;
    private import ScalarValues::*;
    private import CorporationOperationalRequirementsDef::*;

    // from the calculation in the Analysis.
    requirement <OPRQF01_1> corporationPilotProfitabilityHighSec : PilotPodProfitability {
    	subject corporationPilotPod :> domain.alphaMiningCorporation.highSecMiningPilotPod;
        doc /* The Mining pilot shall earn in average ISK/hour in High Sec space 
            */ 

        require constraint { domain.alphaMiningCorporation.highSecMiningPilotPod.operationalMiningProfitability >= 7000000.0 }
    }
    requirement <OPRQF01_2> corporationPilotProfitabilityLowSec : PilotPodProfitability {
    	subject corporationPilotPod :> domain.alphaMiningCorporation.lowSecMiningPilotPod;
        doc /* The Mining pilot shall earn in average ISK/hour in Low Sec space 
            */ 

        require constraint { domain.alphaMiningCorporation.lowSecMiningPilotPod.operationalMiningProfitability >= 14000000.0 }
    }
    requirement <OPRQF01_3> corporationPilotProfitabilityNullSec : PilotPodProfitability {
    	subject corporationPilotPod :> domain.alphaMiningCorporation.nullSecMiningPilotPod;
        doc /* The Mining pilot shall earn in average ISK/hour in Null Sec space 
            */ 

        require constraint { domain.alphaMiningCorporation.nullSecMiningPilotPod.operationalMiningProfitability >= 20000000.0 }
    }

}