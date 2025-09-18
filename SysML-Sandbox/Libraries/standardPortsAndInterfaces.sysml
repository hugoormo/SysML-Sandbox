package StdPortsAndInterfaces {
	
	private import ScalarValues::*;
    private import RollupAnalysis::*;
    private import NaturalEnvironment::*; 
    
    package ImperialTechnology {
    
        //Pod and Station docking points
        port def PodPort {
            in item shipReport : ShipReport;
            out item command : ShipCommand;
        }

        port def DockingPort {
            out item charge : Real;
            in item cargo : CargoContainer;
        }

        port def TractorBeamPort {
            attribute tractorMass : Real;
            out tractorBeam : TractorBeam;
        }

        //Ship interaction points

        port def DroneControllerPort {
            in item droneCommand : DroneCommand;
            out item droneReport : DroneReport;
        }
        port def LongRangeSensorDirectionalPort :> EmissionPort;

        port def GridSensorPort :> EmissionPort;

        port def PodCommsPort {
            inout item shipComm : PodComms;
        }

        port def MainPropulsionPort {
            in item disruptionField : WebifierDisruptionField;
        }

        port def RotationPropulsionPort;

        //Ship resilience interaction points
        port def ThreatPort {
            out item firePower : FirePower;
        }

        port def WarpDriveDisruptionShieldPort {
            attribute warpShielding : Integer;
            in item warpField : WarpField;
        }

        //Standard ship modules extension points
        port def HighSlotPort {
            in power : PowerSupply;
            in moduleControl : ModuleCommand;
            out moduleReport : ModuleReport;
        }

        port def MediumSlotPort {
            in power : PowerSupply;
            in moduleControl : ModuleCommand;
            out moduleReport : ModuleReport;
        }

        port def LowSlotPort {
            in moduleControl : ModuleCommand;
            out moduleReport : ModuleReport;
        }

        port def RigPort {
            out rigEffect : Real;
        }

        //Standard ship rigging points
        port def RigPortSmall :> RigPort;
        port def RigPortMedium :> RigPort;


        //Flowing Items
        //Communication
        item def PodComms {
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

        item def ShipReport{
            attribute type: String;
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

        item def ModuleCommand {
            attribute command : String;
        }
        
        item def ModuleReport {
            attribute type: String;
        }
        // Items that Flow Between Domain Objects 
        //Ship Commands 

        item def TractorBeam { 
            strength : Real; //directional tractor field
        } 

        item def ShipCommand {
            doc /*Payloads of messages within a ship*/
            attribute pilotPodCommandHeader : String;
        }

        item def DroneCommand :> ShipCommand {
            attribute droneID: String;
        } 

        item def  ActivateMiningLaserCommand :> ShipCommand;

        item def ActivateAsteroidScanner :> ShipCommand;
        
        item def  ScanForThreatsCommand :> ShipCommand {
            attribute range; 
            attribute direction; 
            attribute coneAngle;
        } 
        
        item def  SelectDronesForDeploymentCommand :> ShipCommand;

        //Ship Navigation Commands
        item def ExecuteWarpDriveCommand :> ShipCommand{
            attribute signatureCelestial : CelestialSignature;
            attribute warpToDistance : Integer;
        }
        item def GridNavigationCommand :> ShipCommand {
            attribute signatureGrid : GridSignature;
            attribute range : Real;
        }    
        item def ApproachSignatureAtRangeCommand :> GridNavigationCommand;
        item def orbitSignatureAtRange :> GridNavigationCommand;
        item def keepSignatureAtRange :> GridNavigationCommand;
        
        item def EngagePropulsionCommand :> ShipCommand {
            attribute TrottlePercentage : Integer;
        }
        
        item def  DetectThreatCommand :> ShipCommand;
        
        item def  EngageDefensesCommand :> ShipCommand{
            attribute signatureGrid : GridSignature;
        }
        
        item def  DockToStation :> ShipCommand {
            attribute signatureCelestial : CelestialSignature;
        }
        
        //Station Commands
        item def UndockFromStationCommand :> StationCommand;
        item def TransferOreCommand :> StationCommand;
        item def DockingRequestAccepted :> StationCommand;  
        
        //Ship Information Items
        item def Course {
            attribute waypoints: String;
            attribute distance: Real;
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

        //Sensor data processing items
        item def Signature {
            doc /*Signatures are received emissiond from emitting massive object*/
            attribute type: String;
            attribute signatureID: String;
            attribute distance : Real;
        }
        item def CelestialSignature :> Signature {
            doc /*Large Signatures that are available within the system range*/
            attribute celestialType :>> type;
            attribute celestialSignatureID :>> signatureID;
            attribute celestialDistance :>> distance; //in parsecs
        }

        item def GridSignature :> Signature {
            doc /*Small Signatures that are continously refreshed at grid range or 
            *up to a few parsecs using the directional scanner
            */
            attribute gridType :>> type;
            attribute gridSignatureID :>> signatureID;
            attribute gridDistance :>> distance; //in Km
        }


        //Standard interfaces
        //Ship Extension modules interfaces
        interface def HighSlotInterface {
            end port shipPort : ~HighSlotPort;
            end port modulePort : HighSlotPort;

            flow of PowerSupply from shipPort.power to modulePort.power;
            flow of ModuleCommand from shipPort.moduleControl to modulePort.moduleControl;
            flow of ModuleReport from modulePort.moduleReport to shipPort.moduleReport;
        }

        interface def MediumSlotInterface {
            end port shipPort : ~MediumSlotPort;
            end port modulePort : MediumSlotPort;

            flow of PowerSupply from shipPort.power to modulePort.power;
            flow of ModuleCommand from shipPort.moduleControl to modulePort.moduleControl;
            flow of ModuleReport from modulePort.moduleReport to shipPort.moduleReport;
        }

        interface def LowSlotInterface {
            end port shipPort : ~LowSlotPort;
            end port modulePort : LowSlotPort;

            flow of ModuleCommand from shipPort.moduleControl to modulePort.moduleControl;
            flow of ModuleReport from modulePort.moduleReport to shipPort.moduleReport;
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
    
    package GallenteTechnology {
        doc /*Library of Gallente Technology parts, interfaces, and ports*/
        
        private import ImperialTechnology;
        private import COTS::*;

        //Ship items
        item def ComputationServiceGallente;
        item def DiagnosisGallente;
        
        //Ship components
        part def GallenteStandardComponent :> ImperialStandardModule {
            port commandControlGallente : CommandControlGallente;
            port computationNetworkPort : ComputationNetworkGallente;
            port powerGridPort : PowerGridGallente;
        }
        //Ship components ports
        port def ComputationNetworkGallente {
            in computationRequest : ComputationNetworkGallente;
            out computationResponse : ComputationServiceGallente;
        }

        port def CommandControlGallente {
            out shipCommand : ImperialTechnology::ShipCommand;
            in shipDiagnosis : DiagnosisGallente;
        }

        port def PowerGridGallente {
            out powerGrid : Real;
        }

        //Gallente uses gravimetric sensor technology
        port def LongRangeGravimetricSensorDirectionalPort :> EmissionPort {
            out :>> magneticField[0]; 
        }
        //Gallente uses gravimetric sensor technology
        port def GridGravimetricSensorPort :> EmissionPort {
            out :>> magneticField[0]; 
        }   

        //Ship interfaces
        interface def GallenteControlIF {
            end port supplierPort : CommandControlGallente;
            end port consumerPort : ~CommandControlGallente;
        }

        interface def GallenteComputationServicesIF {
            end port supplierPort : ComputationNetworkGallente;
            end port consumerPort : ~ComputationNetworkGallente;
        }

        interface def GallentePowerGridIF {
            end port supplierPort : PowerGridGallente;
            end port consumerPort : ~PowerGridGallente;
        }

    }

}