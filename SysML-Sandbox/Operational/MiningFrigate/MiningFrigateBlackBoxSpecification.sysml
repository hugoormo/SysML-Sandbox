 package MiningFrigateBlackBoxSpecification {
 
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
	private import OperationalDomain::*;
    private import COTS::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardInteractionPoints::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardInterfaces::*;
    private import StdPortsAndInterfaces::GallenteTechnology::*;
    private import PilotPodsAndSpaceships::*;

    package MiningFrigateVentureClassPackage {
        doc/*
        * Mining Frigate Venture class (System-of-Interest) without enhancements (Non-Configured)
        */
        private import PilotPodsAndSpaceships::*;

        part miningFrigateVentureClass : MiningFrigateVentureClass;

        part def MiningFrigateVentureClass :> ImperialStandardShip {

            //Manufacturer and identification
            attribute :>> vesselType = VesselType::Frigate;
            attribute :>> vesselClass = "Venture";
            attribute :>> manufacturer = "Outer Reach Excavations";

            //the attributes of a spaceship are redefined for the Venture class with default values.
            //relevant attributes for the roll up calculation
            attribute massFrigate :>> massShip default 1200000.0;          // Mass of the minig frigate hull (Kg)
            attribute suppliedPowerGrid :>> suppliedPowerGrid default 45;  //Available power Grid (MW)
            attribute suppliedCapacitor :>> suppliedCapacitor default 250.0;   //Capacity installed (GJ)
            attribute suppliedCpu :>> suppliedCpu default 240;  //Size of the CPU in theraflops (tf)
            // redefined attributes of a ship
            attribute maxVelocity :>> maxVelocity default 335.0;  //Maximum velocity (m/s)
            attribute warpSpeed :>> warpSpeed default 5.0; //AU/s, the warp speed of the frigate (STRQ06)
            attribute alignTime :>> alignTime default 5.99;  // seconds, the time required to align for warp (STRQ06)
            attribute structureStrength :>> structureStrength : Real default 200.0;  //Strength of the hull (STRQ03)
            attribute armorStrength :>> armorStrength : Real default 175.0; 
            attribute shieldStrength :>> shieldStrength : Real default 225.0;  //Strength of the shield (STRQ03)
            attribute cargoHoldCapacity :>> cargoHoldCapacity : Real default 50;  // Maximum transport cargo capacity (m³)
            attribute :>> cargoHoldStatus;
            attribute warpCoreStrength :>> warpCoreStrength default 2;  //resilience to being immobilized    
            // specific attributes of the mining frigate Venture class (not in the generic spaceship)
            attribute oreHoldCapacity : Real default 5000.0;       // Maximum ore cargo capacity (m³)
            attribute droneCapacity : Real default 10;     // Drones cargo capacity (m³)
            attribute oreHoldStatus : Real default 2;    // Capacity status of the ores hold
            attribute maxLockedTargets :>> maxLockedTargets default 5;   // Number, the maximum number of locked targets (STRQ07)
            attribute gravimetricSensorStrength :>> sensorStrength default 4;  //ability to lock in a signature
            #mop attribute yieldBonus : Real = 1;

            assert constraint alignTime2structureStrenght : AlignTime2structureStrenght {
                in maxShipAlignTime = alignTime;
                in shipMass = massFrigate;
                in shipStructureStrength = structureStrength;
                in shipSustainableVelocity = maxVelocity;
            }

            constraint def AlignTime2structureStrenght {
                doc /*
                    * Relates the maximium sustainable velocity of the ship, 
                    * its mass and structure strength to the align time.
                    */
                in maxShipAlignTime : Real;
                in shipMass : Real;
                in shipStructureStrength : Real;
                in shipSustainableVelocity : Real;

                //expression -> f(maxShipAlignTime, shipMass, shipStructureStrength, shipSustainableVelocity) => alignTime;
            }
            
            //Ports of the mining frigate redefine the imperial ship definition
            //The Venture class has a defined number of slots.
            port highPowerSlot1 :>> highPowerSlot[1];
            port highPowerSlot2 :>> highPowerSlot[1];
            port highPowerSlot3 :>> highPowerSlot[1];
            port midPowerSlot1 :>> midPowerSlot[1];
            port midPowerSlot2 :>> midPowerSlot[1];
            port midPowerSlot3 :>> midPowerSlot[1];
            port lowPowerSlot1 :>> lowPowerSlot[1];
            //Rig extension points of the Venture class redefine the imperial ship definition
            port rigPort1 : RigPortSmall :>> rigPort[1];
            port rigPort2 : RigPortSmall :>> rigPort[1];
            port rigPort3 : RigPortSmall :>> rigPort[1];
            //Other ports redefine the imperial ship definition or add to the specific ship
            port podPort :>> podPort;
            port dockingPort :>> dockingPort;
            port tractorBeamPort :>> tractorBeamPort;
            port droneControlPort : DroneControllerPort[2];
            port longRangeGravimetricDirectionalSensorPort : LongRangeGravimetricSensorDirectionalPort :>> longRangeDirectionalSensorPort;
            port gridGravimetricSensorPort : GridGravimetricSensorPort :>> gridSensorPort;
            port xPropulsionPort :>> xPropulsionPort[4];
            port zPropulsionPort :>> zPropulsionPort[2];
            port yPropulsionPort :>> yPropulsionPort[2];
            //Ship resilience ports
            port warpShieldPort :>> warpShieldPort {
                attribute :>> warpShielding = 2;  //The VentureClass has a built-in shielding
            }
            port shieldMitigationPort :>> shieldMitigationPort;
            port armourMitigationPort :>> armourMitigationPort;
            port structureMitigationPort :>> structureMitigationPort;

            //Exhibited or performed behavior of the Venture class
            exhibit miningFrigateStates {
                in ship = miningFrigateVentureClass;
                in shipCommandPort = podPort;
                in shipWarpBubbleEnd = warpBubbleEnd;
            }
        }

        //Venture class Behavior redefines imperial spaceship behavior with own technology 
        state miningFrigateStates :> imperialStandardShipStates {
            in ship : MiningFrigateVentureClass;
            in shipCommandPort : PodPort;
            in shipWarpBubbleEnd : Boolean;

            action :>> startUpSequence;
            action :>> shutDownSequence;
            action :>> initializePowerGrid;
            action :>> initializeGenerator; 
            action :>> initializeScanSpaceServices {
                in scanSpaceServicesCommandPort : PodPort;

                action :>> powerUpSensorSystem;
                action :>> scanGrid {
                    action :>> cycleScanner {out scanReport : String;}
                }
                action :>> directionalScan {
                    action :>> scanSpace {out scanReport : String;}
                }

            }
            action :>> initializeNavigationServices {

                action :>> powerUpNavigationSystem;
                action :>> approachSignatureAtRange;
                action :>> orbitSignatureAtRange;
                action :>> keepAtRangeSignature;
                action :>> dockInStation;
            }
            action :>> initializeExtensionModule {
                in moduleServicesCommandPort : PodPort;
                in module : ImperialStandardModule;

                action :>> configureModule {
                    in module : ImperialStandardModule; 
                    out commandModule : ShipCommand;
                    out reportModule : ShipReport;
                }
                action :>> powerUpModule;
                action :>> diagnoseModule;
                action :>> enableModuleServices;
            }
            action :>> initializeExtensionRig {
                in shipRig : ImperialStandardRig;

                action :>> configureRig {
                    in shipRig : ImperialStandardRig; 
                } 
                action :>> powerUpRig; 
                action :>> diagnoseRig; 
                action :>> enableRig;
            }
            action :>> prepareForWarp {
                in warpCommandPort : PodPort;
                in warpBubbleEnd : CelestialSignature;
                in atRange : Real;

                accept ExecuteWarpDriveCommand : ShipCommand via warpCommandPort;
                action :>> reportStatusWarpDrive {out shipReport : ShipReport;}
                send reportStatusWarpDrive.shipReport via warpCommandPort; 
                action :>> reportStatusDestination {out shipReport : String;}
                send reportStatusDestination.shipReport via warpCommandPort;
            }
            action initializeDroneServices;
            action transferOre;
        }
    }

    package VariationDefinition {
        private import MiningFrigateVentureClassPackage;

        abstract part miningFrigateConfiguration : MiningFrigateVentureClassPackage::MiningFrigateVentureClass {
            variation part minerModule : MinerModule[2] {
                variant 'Mining Laser EP-S Gaussian Scoped';
                variant 'Mining Laser Particle Bore Compact';
                variant minerI; 
            }
        }
    }

    package MinigFrigateConfigurations {
        //Different configurations of mining frigate are defined here that base on an abstract frigate
        private import VariationDefinition;
        private import MiningFrigateVentureClassPackage;

        part highSecMiningFrigate :> VariationDefinition::miningFrigateConfiguration {

            // redefined attributes of a ship
            attribute :>> maxVelocity = 
                VariationDefinition::miningFrigateConfiguration.maxVelocity * 
                propulsionEnhancer.velocityBonus;  //Maximum velocity (m/s)

            // attributes inherited from mounted modules 
            #mop attribute miningRate : Real =          // Depends on COTS. Volume of ore mined per second (m³/s)
                minerModule1.miningYield * (1 + yieldBonus)  / minerModule1.cycleTime + 
                minerModule2.miningYield * (1 + yieldBonus) / minerModule2.cycleTime;

            //the mop is allocated to the corresponding moe
            //some of all the responsibility for realizing the source moe is allocated to the here defined target mop
            allocate domain.miningCorporation.highSecMiningPilotPod.operationalMiningRate 
            to highSecMiningFrigate.miningRate;

            //modules are associated to the spaceship. They can be dismounted and have different lifetimes.
            ref part minerModule1 redefines minerModule[1] = minerModule1::minerI{
                port highSlot redefines highSlot;
                port laserBeam redefines laserBeam;
            }        
            ref part minerModule2 redefines minerModule[1] = minerModule2::minerI{
                port highSlot redefines highSlot;
                port laserBeam redefines laserBeam;
            }
            ref part propulsionEnhancer : Afterburner[1] {
                port lowSlot redefines lowSlot;
            }
            ref part drone : Drone[2]{
                port droneControlPort redefines droneControlPort;
                port droneThreatPort redefines droneThreatPort;
            }

            interface DroneControllerPortIF : DroneControllerPort [2] connect
                hullPort ::> highSecMiningFrigate.droneControlPort to
                modulePort ::> drone.droneControlPort;
            
            interface miningLaser1IF : HighSlotInterface connect
                hullPort ::> highSecMiningFrigate.highPowerSlot1 to
                modulePort ::> minerModule1.highSlot;

            interface miningLaser2IF : HighSlotInterface connect
                hullPort ::> highSecMiningFrigate.highPowerSlot2 to
                modulePort ::> minerModule2.highSlot;

            interface propulsionEnhancerIF : LowSlotInterface connect
                hullPort ::> highSecMiningFrigate.lowPowerSlot1 to
                modulePort ::> propulsionEnhancer.lowSlot;
        
            //Exhibited or performed behavior of the spaceshihp
            exhibit highSecMiningFrigateStates {
                in ship = highSecMiningFrigate;
                in shipCommandPort = highSecMiningFrigate.podPort;
                in shipWarpBubbleEnd = highSecMiningFrigate.warpBubbleEnd;
            }
        }
        //Venture class special Behavior
        state highSecMiningFrigateStates :> MiningFrigateVentureClassPackage::miningFrigateStates {
            perform action highSecStartUpSequence :>> startUpSequence {
                in :>> shipServicesCommandPort = highSecMiningFrigate.podPort;

                first start;
                then action ::> initializePowerGrid;
                then action ::> initializeGenerator;
                then action ::> initializeScanSpaceServices {in scanSpaceServicesCommandPort = shipServicesCommandPort;}
                then action ::> initializeNavigationServices {in navigationServicesCommandPort = shipServicesCommandPort;}
                then action initializeHighPowerModule1 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = highSecMiningFrigate.minerModule1;
                }
                then action initializeHighPowerModule2 ::> initializeExtensionModule { 
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = highSecMiningFrigate.minerModule2;
                }
                then action initializeLowPowerModule1 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = highSecMiningFrigate.propulsionEnhancer;
                }
            }
        }
        
        part lowSecMiningFrigate :> VariationDefinition::miningFrigateConfiguration {

            // redefined attributes of a ship
            attribute :>> maxVelocity = 
                VariationDefinition::miningFrigateConfiguration.maxVelocity * 
                propulsionEnhancer.velocityBonus;  //Maximum velocity (m/s)

            attribute :>> shieldStrength = 
                VariationDefinition::miningFrigateConfiguration.shieldStrength * 
                shieldExtender.shieldHPBonus;  //Strength of the shield (STRQ03)
    
            // attributes inherited from mounted modules 
            #mop attribute miningRate : Real =          // Depends on COTS. Volume of ore mined per second (m³/s)
                minerModule1.miningYield * (1 + yieldBonus)  / minerModule1.cycleTime + 
                minerModule2.miningYield * (1 + yieldBonus) / minerModule2.cycleTime; 

            //the mop is allocated to the corresponding moe
            //some of all the responsibility for realizing the source moe is allocated to the here defined target mop
            allocate domain.miningCorporation.lowSecMiningPilotPod.operationalMiningRate 
            to lowSecMiningFrigate.miningRate;

            ref part minerModule1 redefines minerModule[1] = minerModule1::'Mining Laser Particle Bore Compact'{
                port highSlot redefines highSlot;
                port laserBeam redefines laserBeam;
            }
            ref part minerModule2 redefines minerModule[1] = minerModule2::'Mining Laser Particle Bore Compact'{
                port highSlot redefines highSlot;
                port laserBeam redefines laserBeam;
            }
            ref part propulsionEnhancer : Afterburner[1] {
                port lowSlot redefines lowSlot;
            }
            ref part shieldExtender : SmallShieldExtenderI[1] {
                port mediumSlot redefines mediumSlot;
            }
            ref part drone : Drone[2]{
                port droneControlPort redefines droneControlPort;
                port droneThreatPort redefines droneThreatPort;
            }

            interface DroneControllerPortIF : DroneControllerPort [2] connect
                hullPort ::> lowSecMiningFrigate.droneControlPort to
                modulePort ::> drone.droneControlPort;
            
            interface miningLaser1IF : HighSlotInterface connect
                hullPort ::> lowSecMiningFrigate.highPowerSlot1 to
                modulePort ::> minerModule1.highSlot;

            interface miningLaser2IF : HighSlotInterface connect
                hullPort ::> lowSecMiningFrigate.highPowerSlot2 to
                modulePort ::> minerModule2.highSlot;

            interface shieldExtenderIF : MediumSlotInterface connect
                hullPort ::> lowSecMiningFrigate.midPowerSlot3 to
                modulePort ::> shieldExtender.mediumSlot;

            interface propulsionEnhancerIF : LowSlotInterface connect
                hullPort ::> lowSecMiningFrigate.lowPowerSlot1 to
                modulePort ::> propulsionEnhancer.lowSlot;

            //Exhibited or performed behavior of the spaceshihp
            exhibit lowSecMiningFrigateStates {
                in ship = lowSecMiningFrigate;
                in shipCommandPort = lowSecMiningFrigate.podPort;
                in shipWarpBubbleEnd = lowSecMiningFrigate.warpBubbleEnd;
            }
        }
        
        //Venture class special Behavior
        state lowSecMiningFrigateStates :> MiningFrigateVentureClassPackage::miningFrigateStates {
            action lowSecStartUpSequence :>> startUpSequence {
                in :>> shipServicesCommandPort = lowSecMiningFrigate.podPort;

                first start;
                then action :>> initializePowerGrid;
                then action :>> initializeGenerator;
                then action :>> initializeScanSpaceServices {in scanSpaceServicesCommandPort = shipServicesCommandPort;}
                then action :>> initializeNavigationServices {in navigationServicesCommandPort = shipServicesCommandPort;}
                then action initializeHighPowerModule1 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = lowSecMiningFrigate.minerModule1;
                }
                then action initializeHighPowerModule2 ::> initializeExtensionModule { 
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = lowSecMiningFrigate.minerModule2;
                }
                then action initializeMediumPowerModule1 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = lowSecMiningFrigate.shieldExtender;
                }
                then action initializeLowPowerModule1 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = lowSecMiningFrigate.propulsionEnhancer;
                }
            }
        }

        part nullSecMiningFrigate :> VariationDefinition::miningFrigateConfiguration {
            
            //relevant attributes for the roll up calculation
            attribute :>> suppliedCapacitor = 
                VariationDefinition::miningFrigateConfiguration.suppliedCapacitor + 
                capacitorExtender.capacitorBonus;   //Capacity installed (GJ)
            // redefined attributes of a ship
            attribute :>> maxVelocity = 
                VariationDefinition::miningFrigateConfiguration.maxVelocity + 
                propulsionEnhancer.velocityBonus;  //Maximum velocity (m/s)
            attribute :>> shieldStrength = 
                VariationDefinition::miningFrigateConfiguration.shieldStrength + 
                shieldExtender.shieldHPBonus;  //Strength of the shield (STRQ03)

            // attributes inherited from mounted modules 
            #mop attribute miningRate : Real =          // Depends on COTS. Volume of ore mined per second (m³/s)
                minerModule1.miningYield * (1 + yieldBonus)  / minerModule1.cycleTime + 
                minerModule2.miningYield * (1 + yieldBonus) / minerModule2.cycleTime; 
        
            //the mop is allocated to the corresponding moe
            //some of all the responsibility for realizing the source moe is allocated to the here defined target mop
            allocate domain.miningCorporation.nullSecMiningPilotPod.operationalMiningRate 
            to nullSecMiningFrigate.miningRate;

            ref part minerModule1 redefines minerModule[1] = minerModule1::'Mining Laser EP-S Gaussian Scoped'{
                port highSlot redefines highSlot;
                port laserBeam redefines laserBeam;
            }
            ref part minerModule2 redefines minerModule[1] = minerModule2::'Mining Laser EP-S Gaussian Scoped'{
                port highSlot redefines highSlot;
                port laserBeam redefines laserBeam;
            }
            ref part propulsionEnhancer : Afterburner[1] {
                port lowSlot redefines lowSlot;
            }
            ref part shieldExtender : SmallShieldExtenderI[1] {
                port mediumSlot redefines mediumSlot;
            }
            ref part capacitorExtender : SmallCapBatteryI[1] {
                port mediumSlot redefines mediumSlot;
            }
            ref part surveyScanner : SurveyScannerI[1] {
                port mediumSlot redefines mediumSlot;
            }
            ref part drone : Drone[2]{
                port droneControlPort redefines droneControlPort;
                port droneThreatPort redefines droneThreatPort;
            }

            interface DroneControllerPortIF : DroneControllerPort [2] connect
                hullPort ::> nullSecMiningFrigate.droneControlPort to
                modulePort ::> drone.droneControlPort;
            
            interface miningLaser1IF : HighSlotInterface connect
                hullPort ::> nullSecMiningFrigate.highPowerSlot1 to
                modulePort ::> minerModule1.highSlot;

            interface miningLaser2IF : HighSlotInterface connect
                hullPort ::> nullSecMiningFrigate.highPowerSlot2 to
                modulePort ::> minerModule2.highSlot;

            interface shieldExtenderIF : MediumSlotInterface connect
                hullPort ::> nullSecMiningFrigate.midPowerSlot1 to
                modulePort ::> shieldExtender.mediumSlot;

            interface capacitorExtenderIF : MediumSlotInterface connect
                hullPort ::> nullSecMiningFrigate.midPowerSlot2 to
                modulePort ::> capacitorExtender.mediumSlot;

            interface surveyScannerIF : MediumSlotInterface connect
                hullPort ::> nullSecMiningFrigate.midPowerSlot3 to
                modulePort ::> surveyScanner.mediumSlot;

            interface propulsionEnhancerIF : LowSlotInterface connect
                hullPort ::> nullSecMiningFrigate.lowPowerSlot1 to
                modulePort ::> propulsionEnhancer.lowSlot;
            
            //Exhibited or performed behavior of the spaceshihp
            exhibit nullSecMiningFrigateStates {
                in ship = nullSecMiningFrigate;
                in shipCommandPort = nullSecMiningFrigate.podPort;
                in shipWarpBubbleEnd = nullSecMiningFrigate.warpBubbleEnd;
            }
        }
        
        //Venture class special Behavior
        state nullSecMiningFrigateStates :> MiningFrigateVentureClassPackage::miningFrigateStates {

            action nullSecStartUpSequence :>> startUpSequence {
                in :>> shipServicesCommandPort = nullSecMiningFrigate.podPort;

                first start;
                then action :>> initializePowerGrid;
                then action :>> initializeGenerator;
                then action :>> initializeScanSpaceServices {in scanSpaceServicesCommandPort = shipServicesCommandPort;}
                then action :>> initializeNavigationServices {in navigationServicesCommandPort = shipServicesCommandPort;}
                then action initializeHighPowerModule1 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = nullSecMiningFrigate.minerModule1;
                }
                then action initializeHighPowerModule2 ::> initializeExtensionModule { 
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = nullSecMiningFrigate.minerModule2;
                }
                then action initializeMediumPowerModule1 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = nullSecMiningFrigate.shieldExtender;
                }
                then action initializeMediumPowerModule2 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = nullSecMiningFrigate.surveyScanner;
                }
                then action initializeLowPowerModule1 ::> initializeExtensionModule {
                    in moduleServiceCommandPort = shipServicesCommandPort;
                    in module = nullSecMiningFrigate.propulsionEnhancer;
                }
            }
        }
    }
    package DependenciesToUseCases {
        doc/*
        * trace the activities identified in the Operational Use Cases with the activities defined 
        * at the Mining Frigate Blackbox.
        * A dependency states that the "from end" of the dependency needs the "to end" to be specified.
        */
        private import MinigFrigateConfigurations;

        dependency MinigFrigateConfigurations::highSecMiningFrigate::highSecMiningFrigateStates::highSecStartUpSequence::initializeHighPowerModule1 
            to SystemUseCases::MineAsteroids::highSecMiningFrigate::activateMiningLaser;
        dependency MinigFrigateConfigurations::highSecMiningFrigate::highSecMiningFrigateStates::highSecStartUpSequence::initializeHighPowerModule2  
            to SystemUseCases::MineAsteroids::highSecMiningFrigate::activateMiningLaser;
        dependency MinigFrigateConfigurations::highSecMiningFrigate::highSecMiningFrigateStates::initializeScanSpaceServices::directionalScan
            to SystemUseCases::MonitorAndDetectThreats::highSecMiningFrigate::scanSpace;
        dependency MinigFrigateConfigurations::highSecMiningFrigate::highSecMiningFrigateStates::prepareForWarp
            to SystemUseCases::WarpToCelestial::highSecMiningFrigate::executeWarpDrive;
        dependency MinigFrigateConfigurations::highSecMiningFrigate::highSecMiningFrigateStates::initializeNavigationServices::approachSignatureAtRange
            to SystemUseCases::ApproachSignature::highSecMiningFrigate::approachSignature;
        dependency MinigFrigateConfigurations::highSecMiningFrigate::highSecMiningFrigateStates::initializeNavigationServices::dockInStation
            to SystemUseCases::DockToStation::highSecMiningFrigate::dockInStation;
        dependency MinigFrigateConfigurations::highSecMiningFrigate::highSecMiningFrigateStates::initializeDroneServices
            to SystemUseCases::DeployDefenseDrones;
        dependency MinigFrigateConfigurations::highSecMiningFrigate::highSecMiningFrigateStates::transferOre
            to SystemUseCases::TransferOre;
    }
    package ViewsAndViewDefinitions {

        private import VariationDefinition;
    
        view def 'Mining Frigate Behavior'{
            satisfy StakeholderConcerns::SecurityConcern;

            filter @SysML::ExhibitStateUsage;
        }
        view 'Mining Frigate states' : 'Mining Frigate Behavior' {
            expose VariationDefinition::miningFrigateConfiguration::miningFrigateStates::*;
            //render TBD;
        }
    } 
}