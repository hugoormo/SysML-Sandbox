package Structures {
    doc/*
    * Suns, Planets, Asteroid fields, asteoids, 
    * and fabricated Structures like stations, gates,
    * warehouses, industrial sites, intelligence sites, etc.
    */

    private import ScalarValues::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;
    private import NaturalEnvironment::*;
    

    part def Station :> EmittingMassiveObject {
        attribute dockingCapacity : Integer;
        attribute location : String;
        port dockingPort: DockingPort;
    }

    part def Gate :> EmittingMassiveObject;
    
}