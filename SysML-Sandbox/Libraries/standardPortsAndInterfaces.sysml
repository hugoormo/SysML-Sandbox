package StdPortsAndInterfaces {
	
	private import ScalarValues::*;
    
    //Pod and Station docking points
    port def PodPort {
		in item shipReport : ShipReport;
		out item command : ShipCommand;
	}
	
	port def DockingPort {
		out item charge : Real;
		in item cargo : CargoContainer;
	}

    //Ship interaction points
    port def ThreatPort {
		out item firePower : FirePower;
	}
	
	port def DroneControllerPort {
		in item droneCommand : DroneCommand;
		out item droneReport : DroneReport;
	}

    port def GravimetricAntenna;   //one of the four sensor kinds
    port def LongRangeSensorDirectionalAntenna {
        in item longRangeSignature : CelestialSignature [1..*];
    }

    port def GridSensorAntenna {
        in item gridSignature : GridSignature [1..*];
    }

    port def ShipCommsPort {
        inout item shipComm : ShipComms;
    }

    port def MainPropulsion;
    port def DirectionalPropulsion;

    //Ship resiience interaction points
    port def WarpDriveDisruptionShield {
        attribute warpShielding : Integer;
        in item warpField : WarpField;
    }

    port def PropulsionDisruption {
        in item disruptionField : WebifierDisruptionField;
    }


    //Standard ship modules extension points
    port def HighSlotPort {
        in power : PowerSupply;
        in control : HighSlotCommand;
    }

    port def MediumSlotPort {
        in power : PowerSupply;
        in control : MediumSlotCommand;
    }

    port def LowSlotPort {
        in control : LowSlotCommand;
    }
    
    port def RigPort {
        out rigEffect : Real;
    }

    //Standard ship rigging points
    port def RigPortSmall :> RigPort;
    port def RigPortMedium :> RigPort;

	
    //Flowing Items
    //Communication
    item def ShipComms {
        doc /*Payloads of communication messages between pilots*/
        attribute pilotPodComms : String;
    }
    
    //Command and Control items
    item def StationCommand {
        doc /*Payloads of messages between a ship/pod and a station*/
        attribute StationCommandHeader: String;
    }
    
    item def StationReport{
    	attribute type: String;
    }
    
    item def ShipCommand {
        doc /*Payloads of messages within a ship*/
        attribute pilotPodCommandHeader : String;
    }
    
    item def ShipReport{
    	attribute type: String;
    }

    item def DroneCommand :> ShipCommand {
        attribute droneID: String;
    } 
    
    item def DroneReport :> ShipReport {
    	attribute DroneID: String;
    } 
    
    item def CargoContainer {
        attribute type : String;
        attribute weight : Real;
    }
    
    item def PowerSupply {
        attribute energyTransfer : Real;
    }

    item def HighSlotCommand {
        attribute activation : Boolean;
    }

    item def MediumSlotCommand {
        attribute activation : Boolean;
    }

    item def LowSlotCommand {
        attribute activation : Boolean;
    }

    //Energy items
    item def FirePower {
        attribute type : String;
        attribute strenght : String;
    } 

    item def WarpField {
        attribute warpPoints : Integer;
    }

    item def WebifierDisruptionField {
        attribute webifierStrength : Real;
    }

    //Sensor items
     item def CelestialSignature {
        doc /*Large Signatures that are available within the system range*/
        attribute type: String;
        attribute CelestialSignatureID: String;
    }

    item def GridSignature {
        doc /*Small Signatures that are continously refreshed at grid range or 
        *up to a few parsecs using the directional scanner
        */
        attribute type: String;
        attribute GridSignatureID: String;
    }

    
    //Standard interfaces
    //Ship Extension modules interfaces
    interface def HighSlotInterface {
        end port hullPort : ~HighSlotPort;
        end port modulePort : HighSlotPort;

        flow of PowerSupply from hullPort.power to modulePort.power;
        flow of HighSlotCommand from hullPort.control to modulePort.control;
    }

    interface def MediumSlotInterface {
        end port hullPort : ~MediumSlotPort;
        end port modulePort : MediumSlotPort;

        flow of PowerSupply from hullPort.power to modulePort.power;
        flow of MediumSlotCommand from hullPort.control to modulePort.control;
    }

    interface def LowSlotInterface {
        end port hullPort : ~LowSlotPort;
        end port modulePort : LowSlotPort;

        flow of LowSlotCommand from hullPort.control to modulePort.control;
    }

    //Aggression interfaces
    interface def ThreatIF {
        end threadIncomingPort : ~ThreatPort;
        end threatOutgoingPort : ThreatPort;
        flow of FirePower from threatOutgoingPort.firePower to threadIncomingPort.firePower;     
    }

    //Communication interfaces
    interface def DroneIF {
        end droneControllerPort : ~DroneControllerPort;
        end droneControllPort : DroneControllerPort;
        flow of DroneCommand from droneControllerPort.droneCommand to droneControllPort.droneCommand;
        flow of DroneReport from droneControllPort.droneReport to droneControllerPort.droneReport;     
    }

    //Command interfaces
    interface def CommandIF {
        end controlSend : PodPort;
        end controlReceive : ~PodPort;
        //flows are defined within the interface
        flow of ShipCommand from controlSend.command to controlReceive.command;
        flow of ShipReport from controlReceive.shipReport to controlSend.shipReport;
    }
    
    //Logistic interfaces
	interface def PowerDockIF {
        end shipDockingPort : ~DockingPort;
        end stationDockingPort : DockingPort;
        flow of Power : Real from stationDockingPort.charge to shipDockingPort.charge;
        flow of CargoContainer from shipDockingPort.cargo to stationDockingPort.cargo;      
    }
}