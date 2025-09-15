package MiningFrigateVerification {

    private import MiningFrigateRequirements::*;
    private import OperationalDomain::*;
    private import ScalarValues::*;
    private import ISQ::*;
	private import SI::*;
	private import VerificationCases::*;
	private import MiningFrigateBlackBoxSpecification::*;

	//Verifications at the system level
	
	// Definition of a test rig that includes all necessary verification parts
	//Verification actions are assigned to the parts of the verification domain
    part def MiningFrigateVerificationRig {
        doc /* This test rig uses a low sec mining frigate and a test pilot
            * that has no mining bonusses.
             */
        part verificationPilot : MiningPilotPod{
            attribute testerPilotSkillset :>> skillsSet {
                attribute testerPilotSkillsetEfficiency :>> miningEfficiency = 1.0;
            }  //no mining bonusses from pilot skills
            ref part miningFrigateDUT :> lowSecMiningFrigate :>> lowSecMiningFrigate;
        }
    }

    part miningFrigateTestRigLowSec : MiningFrigateVerificationRig {
        perform oreExtractionEfficiencyTest;
    }	
	
	//Verification
	verification oreExtractionEfficiencyTest : OreExtractionEfficiencyTest {
		subject miningFrigateDUT;
	}

	// Verification definitions 
    // Verification Definition for Ore Extraction Efficiency
    verification def OreExtractionEfficiencyTest {
        subject miningFrigateDUT :> lowSecMiningFrigate;

        objective oreExtractionEfficiencyVerificationObjective {
            verify oreExtractionEfficiencyRequirementLowSec ;
        }
        metadata VerificationMethod {
			kind = VerificationMethodKind::test;
		}

        action collectData {
            in part testMiningFrigate = OreExtractionEfficiencyTest::miningFrigateDUT;
            out miningRateMeasured : Real; // Low Sec
        }

        action evaluateData {
            in evalMiningRateMeasured = collectData.miningRateMeasured;
            out verdict : VerdictKind =
            // Check if mining rates satisfy the OreExtractionEfficiencyRequirement.
            PassIf(oreExtractionEfficiencyRequirementLowSec(
            	myMiningFrigate = miningFrigateDUT));
        }

        return :>> verdict : VerdictKind = evaluateData.verdict;
    }
}
package MiningFrigateValidation {

    private import MissionRequirements::*;
    private import OperationalDomain::*;
    private import ScalarValues::*;
    private import ISQ::*;
	private import SI::*;
	private import VerificationCases::*;
	private import MiningFrigateBlackBoxSpecification::**;

	//These are the validation actions for the system/soution level
    //In fact they are Verifications at the problem/operational level
	
	// Definition of a test rig that includes all necessary validation parts
	//Validation actions are assigned to the parts of the validaion domain
    part def MiningFrigateValidationRig {
        doc /* This test rig uses a low sec mining frigate and a test pilot
            * that has no mining bonusses.
             */
        part validationPilot :> domain.miningCorporation.lowSecMiningPilotPod { 
            ref part miningFrigateDUT :> lowSecMiningFrigate :>> lowSecMiningFrigate;
        }
    }

    part miningFrigateTestRigLowSec : MiningFrigateValidationRig {
        perform pilotProfitabilityRequirementTest;
    }	
	
	//Validation of the system-of-interest
	verification pilotProfitabilityRequirementTest : PilotProfitabilityRequirementTest {
		subject lowSecMiningPilotPod;
	}

	// Validation definition of the system-of-interest 
    verification def PilotProfitabilityRequirementTest {
        subject miningCorporationDUT :> domain.miningCorporation;

        objective pilotProfitabilityRequirementVerificationObjective {
            verify pilotProfitabilityRequirementLS;
        }
        metadata VerificationMethod {
			kind = VerificationMethodKind::test;
		}

        action collectData {
            in part lowSecMiningPilotPod = PilotProfitabilityRequirementTest::miningCorporationDUT;
            out pilotProfitabilityLS : Real; // Low Sec
        }

        action evaluateData {
            in evalMiningRateMeasured = collectData.pilotProfitabilityLS;
            out verdict : VerdictKind =
            // Check if mining rates satisfy the OreExtractionEfficiencyRequirement.
            PassIf(pilotProfitabilityRequirementLS(
            	miningCorporation = miningCorporationDUT));
        }

        return :>> verdict : VerdictKind = evaluateData.verdict;
    }
}