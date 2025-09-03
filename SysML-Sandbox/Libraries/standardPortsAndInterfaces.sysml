package StdPortsAndInterfaces {
	
	private import ScalarValues::*;
	
	// **Port Definitions**
    port def PodPort {
		in item shipReport : ShipReport;
		out item command : ShipCommand;
	}
	
	port def DockingPort {
		out item charge : Real;
		in item cargo : CargoContainer;
	}

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

    port def RigPortSmall :> RigPort;

    port def RigPortMedium :> RigPort;

	// **Power and Control Interfaces**
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
    
    // **High Slot Interface (Power + Activation Command)**
    interface def HighSlotInterface {
        end port hullPort : ~HighSlotPort;
        end port modulePort : HighSlotPort;

        flow of PowerSupply from hullPort.power to modulePort.power;
        flow of HighSlotCommand from hullPort.control to modulePort.control;
    }

    // **Medium Slot Interface (Power + Activation Command)**
    interface def MediumSlotInterface {
        end port hullPort : ~MediumSlotPort;
        end port modulePort : MediumSlotPort;

        flow of PowerSupply from hullPort.power to modulePort.power;
        flow of MediumSlotCommand from hullPort.control to modulePort.control;
    }

    // **Low Slot Interface (Activation Command Only)**
    interface def LowSlotInterface {
        end port hullPort : ~LowSlotPort;
        end port modulePort : LowSlotPort;

        flow of LowSlotCommand from hullPort.control to modulePort.control;
    }
}