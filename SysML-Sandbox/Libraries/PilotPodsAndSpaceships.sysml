package PilotPodsAndSpaceships {

    private import StdPortsAndInterfaces::*;
    private import ScalarValues::*;
    private import COTS::*;

    part def PilotPod {
        attribute skillsSet : SkillsSetPilot;
        attribute controlEfficiency : Real default 0.6;         // Efficiency of command execution (%)
        attribute fleetSize: Integer;
        port podPort: PodPort;
        ref part spaceship : Spaceship[0..1];
    }

    item def SkillsSetPilot {
        attribute miningEfficiency : Real;
        attribute maxLockedTargets : Integer; 
    }

    part def Spaceship :> ImperialStandardShip; //Placeholder for any kind of spaceship not yet specified
}