package MiningFrigateRequirementsVerification {

    private import MiningFrigateRequirements::*;
    private import StakeholdersDef::*;
    private import DomainPackage::*;
    private import ScalarValues::*;
    private import ISQ::*;
	private import SI::*;
	private import VerificationCases::*;
	private import MiningFrigatePackage::*;

	//Verifications at the problem/operational level
	//These are incidentally the validation actions for the system/soution level
	
	// Definition of a test rig that includes all necessary verification parts
	//Verification actions are assigned to the parts of the verification domain
    part def MiningFrigateTestRig {
        part testMiningFrigate :> highSecMiningFrigate;
        part testEngineer : ShipEngineer;
        part testEnvironment : TestEnvironment;
        part dataLogger : DataLogger;
    }
	
    part def TestEnvironment {
        doc /* The TestEnvironment provides the controlled conditions needed 
               to execute tests on the Mining Frigate, such as simulated asteroid belts, 
               hostile encounters, and docking stations. */
    	perform action simulateLowSecAttack;
    }

    part def DataLogger {
        doc /* The DataLogger records test data, including ore extraction rates, 
               cargo capacity, shield strength, and other key performance metrics. */
        perform action evaluateData;
    }
    
    part def ShipEngineer {
        doc /* The ShipEngieer is both a stakeholder and an actor in the verification domain */
    }	
	
	part miningFrigateDUT :> highSecMiningFrigate {
		doc /* The miningFrigateDUT is a test unit */
		perform action collectData;
		perform action deployDrones;
	}

	
	//Verification
	verification oreExtractionEfficiencyTest : OreExtractionEfficiencyTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}
	verification cargoCapacityTest : CargoCapacityTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}
	verification survivabilityTest : SurvivabilityTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}
	verification droneOperationsTest : DroneOperationsTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}

	// Verification definitions 
    // Verification Definition for Ore Extraction Efficiency
    verification def OreExtractionEfficiencyTest {
        subject testMiningFrigate :> highSecMiningFrigate;

        objective oreExtractionEfficiencyVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify oreExtractionEfficiencyRequirementLowSec ;
        }
        metadata VerificationMethod {
			kind = VerificationMethodKind::test;
		}

        action collectData {
            in part testMiningFrigate :> highSecMiningFrigate = OreExtractionEfficiencyTest::testMiningFrigate;
            out miningRateMeasuredHS : Real ; // High Sec (m³/min)
            out miningRateMeasuredLS : Real; // Low Sec, Null Sec, Wormholes
        }

        action evaluateData {
            in evalMiningRateMeasuredLS = collectData.miningRateMeasuredLS;
            out verdict : VerdictKind =
            // Check if mining rates satisfy the OreExtractionEfficiencyRequirement.
            PassIf(oreExtractionEfficiencyRequirementLowSec(
            	myMiningFrigate = testMiningFrigate));
        }

        return :>> verdict : VerdictKind = evaluateData.verdict;
    }

    // Verification Definition for Cargo Capacity
    verification def CargoCapacityTest {
        subject testMiningFrigate :> highSecMiningFrigate;

        objective cargoCapacityVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify cargoCapacityRequirementLowSec;
        }

        metadata VerificationMethod {
            kind = VerificationMethodKind::test;
        }

        action collectData {
            in part testMiningFrigate :> highSecMiningFrigate = CargoCapacityTest::testMiningFrigate;
            out cargoCapacityMeasured : Real;
        }

        action evaluateData {
            in cargoCapacityMeasured : Real = collectData.cargoCapacityMeasured;
            out verdict : VerdictKind =
            // Check if cargo capacity satisfies the CargoCapacityRequirement.
            PassIf(cargoCapacityRequirementLowSec(
                myMiningFrigate = testMiningFrigate));
        }

        return verdict : VerdictKind = evaluateData.verdict;
    }

    // Verification Definition for Survivability
    verification def SurvivabilityTest {
        subject testMiningFrigate :> highSecMiningFrigate;

        objective survivabilityVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify survivabilityRequirementLowSec;
        }

        metadata VerificationMethod {
            kind = VerificationMethodKind::test;
        }

        action simulateHighSecAttack {
            in part testMiningFrigate :> highSecMiningFrigate = SurvivabilityTest::testMiningFrigate;
            out shieldStrengthMeasuredHS : Real; // High Sec survivability (DPS)
        }

        action simulateLowSecAttack {
            in part testMiningFrigate :> highSecMiningFrigate = SurvivabilityTest::testMiningFrigate;
            out shieldStrengthMeasuredLS : Real; // Low Sec survivability (DPS)
        }

        action evaluateData {
            in shieldStrengthMeasuredLS : Real = simulateLowSecAttack.shieldStrengthMeasuredLS;
            out verdict : VerdictKind =
            // Check if shield strength satisfies the SurvivabilityRequirement.
            PassIf(survivabilityRequirementLowSec(
                myMiningFrigate = testMiningFrigate));
        }

        return verdict : VerdictKind = evaluateData.verdict;
    }

    // Verification Definition for Drone Operations
    verification def DroneOperationsTest {
        subject testMiningFrigate :> highSecMiningFrigate;

        objective droneOperationsVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify droneOperationsRequirementLowSec;
        }

        metadata VerificationMethod {
            kind = VerificationMethodKind::test;
        }

        action deployDrones {
            in part testMiningFrigate :> highSecMiningFrigate = DroneOperationsTest::testMiningFrigate;
            out droneCapacityMeasured : Integer;
        }

        action evaluateData {
            in droneCapacityMeasured : Integer = deployDrones.droneCapacityMeasured;
            out verdict : VerdictKind =
            // Check if the drone capacity satisfies the DroneOperationsRequirement.
            PassIf(droneOperationsRequirementLowSec(
                myMiningFrigate = testMiningFrigate
            ));
        }

        return verdict : VerdictKind = evaluateData.verdict;
    }
}
