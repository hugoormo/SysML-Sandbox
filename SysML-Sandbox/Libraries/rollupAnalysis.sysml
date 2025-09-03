package RollupAnalysis {

    private import ScalarValues::*;
    private import NumericalFunctions::*;

    // **Base Definition for Mass and Power Rollup**
    part def SpaceshipComponent {
        attribute mass : Real;
        attribute totalMass : Real;
        attribute powerGridUsage : Real;
        attribute totalPowerGridUsage : Real;
        attribute capacitorUsage : Real;
        attribute totalCapacitorUsage : Real;
        attribute cpuUsage : Real;
        attribute totalCpuUsage : Real;
    }

    // **Simple Component (Directly Contributes to Mass and Power)**
    part def SimpleSpaceshipComponent :> SpaceshipComponent {
        attribute redefines totalMass = mass;
        attribute redefines totalPowerGridUsage = powerGridUsage;
        attribute redefines totalCapacitorUsage = capacitorUsage;
        attribute redefines totalCpuUsage = cpuUsage;
    }

    // **Composite Component (Rolls Up Mass and Power from Subcomponents)**
    part def CompositeSpaceshipComponent :> SpaceshipComponent {
        part subcomponents : SpaceshipComponent[*];

        attribute redefines totalMass default
            mass + sum(subcomponents.totalMass);

        attribute redefines totalPowerGridUsage default
            powerGridUsage + sum(subcomponents.totalPowerGridUsage);

        attribute redefines totalCapacitorUsage default
            capacitorUsage + sum(subcomponents.totalCapacitorUsage);

        attribute redefines totalCpuUsage default
            cpuUsage + sum(subcomponents.totalCpuUsage);
    }

    // **Derived Calculations**
    // Spaceship.totalMass --> Sum of hull + fitted modules
    // Spaceship.totalPowerUsage --> Sum of all power-consuming modules
}
