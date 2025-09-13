package StdPortsAndInterfaces {
	
	private import ScalarValues::*;
    private import RollupAnalysis::*; 
    
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

        //Ship interaction points

        port def DroneControllerPort {
            in item droneCommand : DroneCommand;
            out item droneReport : DroneReport;
        }
        port def LongRangeSensorDirectionalAntenna {
            in item longRangeSignature : CelestialSignature [1..*];
        }

        port def GridSensorAntenna {
            in item gridSignature : GridSignature [1..*];
        }

        port def ShipCommsPort {
            inout item shipComm : ShipComms;
        }

        port def MainPropulsion {
            in item disruptionField : WebifierDisruptionField;
        }

        port def RotationPropulsion;

        //Ship resilience interaction points
        port def ThreatPort {
            out item firePower : FirePower;
        }

        port def WarpDriveDisruptionShield {
            attribute warpShielding : Integer;
            in item warpField : WarpField;
        }

        //Standard ship modules extension points
        port def HighSlotPort {
            in power : PowerSupply;
            in control : ModuleCommand;
        }

        port def MediumSlotPort {
            in power : PowerSupply;
            in control : ModuleCommand;
        }

        port def LowSlotPort {
            in control : ModuleCommand;
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
            flow of ModuleCommand from hullPort.control to modulePort.control;
        }

        interface def MediumSlotInterface {
            end port hullPort : ~MediumSlotPort;
            end port modulePort : MediumSlotPort;

            flow of PowerSupply from hullPort.power to modulePort.power;
            flow of ModuleCommand from hullPort.control to modulePort.control;
        }

        interface def LowSlotInterface {
            end port hullPort : ~LowSlotPort;
            end port modulePort : LowSlotPort;

            flow of ModuleCommand from hullPort.control to modulePort.control;
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

        port def GravimetricAntenna;   //Gallente uses gravimetric sensor technology

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