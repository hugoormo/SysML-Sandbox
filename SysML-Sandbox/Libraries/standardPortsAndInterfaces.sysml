package StdPortsAndInterfaces {
	
	private import ScalarValues::*;
    private import RollupAnalysis::*;
    private import NaturalEnvironment::*; 
    
    package ImperialTechnology {
    
        package ImperialStandardInteractionPoints {
            doc /*
            * Interaction points that are imposed for all
            * ships that are piloted by pods.
            */
            private import ImperialStandardItems::*;

            //Pod and Station docking points
            port def PodPort {
                port droneCommandsSubPort : DroneCommandsSubPort;
                port modulesCommandsSubPort : ModuleCommandsSubPort;
                port navigationCommandsSubPort : NavigationCommandsSubPort;
                port scanCommandsSubPort : ScanCommandsSubPort;
                port targetingCommandsSubPort : TargetingCommandsSubPort;
                
            }
            port def DroneCommandsSubPort {
                out releaseDronesToGrid : ReleaseDronesToGrid;
                out recallDrones : RecallDrones;
                out reconnectDrones : ReconnectDrones;
                out engageDronesCommand : EngageDronesCommand;
                in dronesReport : DronesReport;
            }
            port def ModuleCommandsSubPort {
                out module1ToggleCommand : Module1ToggleCommand;
                out module2ToggleCommand : Module1ToggleCommand;
                out module3ToggleCommand : Module1ToggleCommand;
                out module4ToggleCommand : Module1ToggleCommand;
                out module5ToggleCommand : Module1ToggleCommand;
                out module6ToggleCommand : Module1ToggleCommand;
                out module7ToggleCommand : Module1ToggleCommand;
                in moduleReport : ModuleReport;
            }
            port def NavigationCommandsSubPort {
                out executeWarpDriveCommand : ExecuteWarpDriveCommand;
                out approachSignatureCommand : ApproachSignatureCommand;
                out orbitSignatureCommand : OrbitSignatureCommand;
                out keepSignatureAtRangeCommand : KeepSignatureAtRangeCommand;
                out dockToStationCommand : DockToStationCommand;
                out engagePropulsionCommand : EngagePropulsionCommand;
                in navigationReport : NavigationReport;
            }

            port def ScanCommandsSubPort {
                out directionalScanCommand : DirectionalScanCommand;
                in scanReport : ScanReport;
            }

            port def TargetingCommandsSubPort {
                out lockTarget : LockTarget;
                in targetLockReport : TargetLockReport;
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
            
            port def LongRangeSensorDirectionalPort :> EmissionPort;

            port def GridSensorPort :> EmissionPort;

            port def PodCommsPort {
                inout item shipComm : PodComms;
            }

            port def MainPropulsionPort {
                in item disruptionField : WebifierDisruptionField;
            }

            port def DroneControllerPort {
                out releaseDronesToGrid : ReleaseDronesToGrid;
                out recallDrones : RecallDrones;
                out reconnectDrones : ReconnectDrones;
                out engageDronesCommand : EngageDronesCommand;
                in dronesReport : DronesReport;
            }

            port def RotationPropulsionPort;

            //Ship resilience interaction points
            port def ThreatPort {
                out item firePower : FirePower;
            }

            port def WarpDriveDisruptionShieldPort {
                attribute warpShielding : Integer;
                in item warpDisruptionField : WarpDisruptionField;
            }

            //Standard ship modules extension points
            port def HighSlotPort :> LowSlotPort {
                in power : PowerSupply;
                in activationSurgeLine : Real; // [GJ]
                in turretAlignment: AlignmentSignal; 
            }

            port def MediumSlotPort :> LowSlotPort {
                in power : PowerSupply;
            }

            port def LowSlotPort {
                in moduleControl : ModuleToggleCommand;
                out moduleReport : ModuleReport;
            }

            port def RigPort {
                out rigEffect : Real;
            }

            //Standard ship rigging points
            port def RigPortSmall :> RigPort;
            port def RigPortMedium :> RigPort;
        }

        package ImperialStandardItems {
            //Flowing Items
            //Communication
            item def PodComms {
                doc /*
                    * Payloads of communication messages between pilots
                    * Routed directly through the pilot pod (not through the ship)   
                    */
                attribute pilotPodComms : String;
            }
            item def AnalogSignal;
            item def CargoContainer {
                attribute type : String;
                attribute weight : Real;
            }
            item def PowerSupply {
                attribute electricPower : Real; // [MW]
            }

            //Command, Reports and Control items
            //Reports
            item def ReportPayload;
            item def ShipReport{
                attribute ShipReportHeader: String;
                attribute publicKeyShip : String;
                attribute payload : ReportPayload;
            }
            item def ModuleReport :> ShipReport;
            item def DronesReport :> ShipReport;
            item def NavigationReport :> ShipReport;
            item def ScanReport :> ShipReport;
            item def TargetLockReport :>ShipReport;

            //Ship Commands
            item def ShipCommand {
                doc /*Payloads of messages within a ship*/
                attribute ShipCommandHeader : String;
                attribute publicKeyPod: String;
            }
            item def DronesCommand :> ShipCommand;
            item def ReleaseDronesToGrid :> DronesCommand;
            item def RecallDrones :> DronesCommand;
            item def ReconnectDrones :> DronesCommand;
            item def EngageDronesCommand :> DronesCommand {
                attribute targetsignature : GridSignature;
            }

            item def ModuleToggleCommand :> ShipCommand {
                attribute overheat : Boolean;
            }

            item def Module1ToggleCommand :> ModuleToggleCommand;
            item def Module2ToggleCommand :> ModuleToggleCommand;
            item def Module3ToggleCommand :> ModuleToggleCommand;
            item def Module4ToggleCommand :> ModuleToggleCommand;
            item def Module5ToggleCommand :> ModuleToggleCommand;
            item def Module6ToggleCommand :> ModuleToggleCommand;
            item def Module7ToggleCommand :> ModuleToggleCommand;
            
            item def DirectionalScanCommand :> ShipCommand {
                attribute range; 
                attribute direction; 
                attribute coneAngle;
            }

            //Ship Navigation Commands
            item def Course;
            item def NavigationCommand :> ShipCommand {
                attribute destinationSignature : Signature;
                attribute atRange : Integer;
            }
            item def ExecuteWarpDriveCommand :> NavigationCommand;   
            item def ApproachSignatureCommand :> NavigationCommand;
            item def OrbitSignatureCommand :> NavigationCommand;
            item def KeepSignatureAtRangeCommand :> NavigationCommand;
            item def DockToStationCommand :> NavigationCommand;
            
            item def EngagePropulsionCommand :> NavigationCommand {
                attribute TrottlePercentage : Integer;
            }   

            item def LockTarget :> ShipCommand {
                attribute signatureGrid : GridSignature;
            } 

            item def AlignmentSignal {
                attribute azimuth : AnalogSignal;
                attribute elevation : AnalogSignal;
            }        
            
            //Station Commands
            item def StationCommand {
                doc /*
                    *Payloads of messages between a ship/pod and a station
                    */
                attribute StationCommandHeader: String;
            }
            item def StationReport{
                attribute type: String;
            }
            item def UndockFromStationCommand :> StationCommand;
            item def TransferOreCommand :> StationCommand;
            item def DockingRequestAccepted :> StationCommand;

            //Drone Commands
            item def DroneCommand; 

            item def DroneReport; 
            
            // Items that Flow Between Domain Objects 
            item def TractorBeam { 
                strength : Real; //directional tractor field
            } 

            //Energy items
            item def FirePower {
                attribute type : String;
                attribute strenght : String;
            } 

            item def WarpDisruptionField {
                attribute warpPoints : Integer;
            }

            item def WebifierDisruptionField {
                attribute webifierStrength : Real;
            }

            //Sensor data processing items
            item def Signature {
                doc /*Signatures are recorded emissiond from emitting massive object*/
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
        }

        package ImperialStandardInterfaces {
            doc /*
                * Imperial standard interfaces for all
                * ships piloted by pods.
                */
                private import ImperialStandardInteractionPoints::*;
                private import ImperialStandardItems::*;
            //Standard interfaces
            //Ship Extension modules interfaces
            interface def HighSlotInterface {
                end port shipPort : ~HighSlotPort;
                end port modulePort : HighSlotPort;

                flow of PowerSupply from shipPort.power to modulePort.power;
                flow of ModuleToggleCommand from shipPort.moduleControl to modulePort.moduleControl;
                flow of ModuleReport from modulePort.moduleReport to shipPort.moduleReport;
            }

            interface def MediumSlotInterface {
                end port shipPort : ~MediumSlotPort;
                end port modulePort : MediumSlotPort;

                flow of PowerSupply from shipPort.power to modulePort.power;
                flow of ModuleToggleCommand from shipPort.moduleControl to modulePort.moduleControl;
                flow of ModuleReport from modulePort.moduleReport to shipPort.moduleReport;
            }

            interface def LowSlotInterface {
                end port shipPort : ~LowSlotPort;
                end port modulePort : LowSlotPort;

                flow of ModuleToggleCommand from shipPort.moduleControl to modulePort.moduleControl;
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
                end droneControllerPort : DroneControllerPort;
                end droneControllPort : ~DroneControllerPort;
                flow of ReleaseDronesToGrid from droneControllerPort.releaseDronesToGrid to droneControllPort.releaseDronesToGrid;
                flow of RecallDrones from droneControllerPort.recallDrones to droneControllPort.recallDrones;
                flow of ReconnectDrones from droneControllerPort.reconnectDrones to droneControllPort.reconnectDrones;
                flow of EngageDronesCommand from droneControllerPort.engageDronesCommand to droneControllPort.engageDronesCommand;
                flow of DronesReport from droneControllPort.dronesReport to droneControllerPort.dronesReport;
            }

            //Command interfaces
            interface def CommandIF {
                end controlSend : PodPort;
                end controlReceive : ~PodPort;
                //flows are defined within the interface
                
            }

            //Logistic interfaces
            interface def PowerDockIF {
                end shipDockingPort : ~DockingPort;
                end stationDockingPort : DockingPort;
                flow of Power : Real from stationDockingPort.charge to shipDockingPort.charge;
                flow of CargoContainer from shipDockingPort.cargo to stationDockingPort.cargo;      
            }
        }
    }
    
    package GallenteTechnology {
        doc /*Library of Gallente Technology parts, interfaces, and ports*/
        
        private import ImperialTechnology::ImperialStandardItems::*;
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
            out shipCommand : ShipCommand;
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