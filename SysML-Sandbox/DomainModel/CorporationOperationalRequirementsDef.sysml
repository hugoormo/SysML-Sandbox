package CorporationOperationalRequirementsDef {

    private import DomainPackage::*;
    private import ScalarValues::*;
    private import StakeholderConcerns::*;
    
    // System Requirements Definition. These are a managed as a Configuration item.
    requirement def <OPRQ01> PilotPodProfitability {
             
        subject corporationPilotPod : PilotPod;
        doc /* The Mining pilot shall achieve a mining profitability 
            * appropriate for different security spaces 
            */
        
        frame concern PilotPodProfitabilityConcern;
    }
}
