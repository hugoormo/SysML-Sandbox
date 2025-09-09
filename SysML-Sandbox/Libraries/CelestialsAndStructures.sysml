package CelestialsAndStructures {
    doc/*
    * Suns, Planets, Asteroid fields, asteoids, 
    * and fabricated Structures like stations, gates,
    * warehouses, industrial sites, intelligence sites, etc.
    */

    private import ScalarValues::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    item def Ore {
        attribute purity : Real;
        attribute quantity : Real;
    }

    part def Station {
        attribute dockingCapacity : Integer;
        attribute location : String;
        port dockingPort: DockingPort;
    }

    part def AsteroidBelt {
    	attribute resourceAvailability : Real;      // Total available ore in the belt (m³)
        part asteroids : Asteroid [1..*];
    }

    part def Asteroid {
    	attribute oreContent : Real;                // Quantity of ore available (m³)
        attribute depletionRate : Real;             // Rate at which ore is extracted (m³/hour)
        port asteroidOrePort : AsteroidOrePort;
        timeslice oreYieldIncreases;
    } 

    item gravitationalWave;
    item MagnetometricWave;
    
    //Celestial and Strucutres ports
    port def AsteroidOrePort {
		out item ore : Ore;
	}

    //Celestials and Structrues items
    item def GravitationalWave;
}