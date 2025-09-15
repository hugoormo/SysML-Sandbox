package StakeholdersDef {

    // Stakeholder Definitions
    part def MiningCEO {
        doc /* The Mining CEO is responsible for ensuring profitability, managing overall 
               corporate strategy, and balancing operational risks with rewards. */
    }

    part def OperationsManager {
        doc /* The Operations Manager is responsible for minimizing operational costs, 
               optimizing deployment efficiency, and ensuring smooth ore delivery processes. */
    }

    part def FleetCommander {
        doc /* The Fleet Commander is responsible for managing fleet operations, ensuring 
               scalability, fleet survivability, and neutralizing threats in hostile environments. */
    }

    part def ShipEngineer {
        doc /* The Ship Engineer focuses on ship survivability, performance optimization, 
               and ensuring Mining Frigates can handle hostile environments effectively. */
    }

    part def MarketAnalyst {
        doc /* The Market Analyst monitors ore market prices, adapts operations to maximize 
               revenue, and advises the corporation on market trends and responses. */
    }    
}
package StakeholderConcerns {

    private import ScalarValues::*;
    private import ISQ::*;
    private import OperationalDomain::MiningCorporation;
    private import StakeholdersDef::*;
    private import MiningFrigateBlackBoxSpecification::**;

    // The concerns are directly declared without definition, beacuse they aren't going to be reused in the scope of this model.
    // Concerns Derived from the Business Case

    concern FleetProfitabilityConcern {
        subject miningCorporation : MiningCorporation;

        attribute fleetProfitabilityLS : Real;
        attribute fleetProfitabilityHS : Real;
        attribute fleetProfitabilityNS : Real;

        require constraint {
            doc /* The Mining Corporation shall ensure that mining operations generate sufficient ISK/hour 
                proportional to the risk of the operations to justify investments in mining
                frigates, fleets, and operational costs.*/
        }

        stakeholder miningCEO : MiningCEO;
    }

    // Concerns Derived from the ConOps

    concern SecurityConcern  {
        subject miningFrigate :> highSecMiningFrigate;

        require constraint {
            doc /* The Mining Corporation shall ensure safety and survivability in hostile environments 
                   (e.g., Low Sec, Null Sec, Wormholes). */
        }

        stakeholder fleetCommander : FleetCommander;
        stakeholder shipEngineer : ShipEngineer;
    }

    concern PilotPodProfitabilityConcern {
        subject miningCorporation : MiningCorporation;

        require constraint {
            doc /* The Mining Corporation shall enable a competitive profit for pilots operating in 
                   all space security environments. */
        }

        stakeholder miningCEO : MiningCEO;
        stakeholder fleetCommander : FleetCommander;
    }

}
package Viewpoints {

    private import StakeholderConcerns::*;    
    
    //Viewpoints
    viewpoint 'Operational profitability'{
        frame FleetProfitabilityConcern;

        require constraint {
            doc /*TBD*/
        }
    }  

     

}
