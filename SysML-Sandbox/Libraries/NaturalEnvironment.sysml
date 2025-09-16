package NaturalEnvironment {

    private import ScalarValues::*;

    item def EmittingMassiveObject {
        attribute mass : Real;
        port emissionPort : EmissionPort;
    }

    item def Energy {
        attribute amount : Real; //[GJ]
    }
    item energy;

    part def SolarSystem {
        part sun[1] : Sun;
        part planet[1..*] : Planet {
            part moon[1..*] : Moon;
        }
        part asteroidBelt[1..*] : AsteroidBelt;
    }
    part def Planet :> EmittingMassiveObject;
    part def Moon :> EmittingMassiveObject;
    part def Sun :> EmittingMassiveObject;

    part def AsteroidBelt :> EmittingMassiveObject {
    	attribute resourceAvailability : Real;      // Total available ore in the belt (m³)
        part asteroids : Asteroid [1..*];
    }

    part def Asteroid :> EmittingMassiveObject {
        timeslice oreYieldIncreases;
    	attribute oreContent : Real;                // Quantity of ore available (m³)
        attribute depletionRate : Real;             // Rate at which ore is extracted (m³/hour)
        port asteroidOrePort : AsteroidOrePort;
        part ore [1..oreContent] : Ore;
    }

    item def Ore {
        attribute mineralAmount[1..8] : Real;
        attribute size : Real; //[m3]
    } 

    item gravitationalWave : GravitationalField;
    item magneticWave : MagneticField;
    
    //Celestial and Strucutres ports
    port def EmissionPort {
            out gravitationalField : GravitationalField;
            out magneticField : MagneticField;
        }
    
    port def AsteroidOrePort {
		out item ore : Ore;
	}

    //Celestials and Structrues items
    item def GravitationalField;
    item def MagneticField;
}