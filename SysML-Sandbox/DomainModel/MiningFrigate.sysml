 package MiningFrigatePackage {
 
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
	private import DomainPackage::*;
    private import StakeholderConcerns::*;
    private import COTS::*;
    private import StdPortsAndInterfaces::*;
    private import SystemUseCases::*;

    //Mining Frigate (System-of-Interest) without enhancements (Non-Configured)
    part def MiningFrigateVentureClass :> ImperialStandardShip {

        //relevant attributes for the roll up calculation
        attribute massShip :>> massShip default 1200000.0;          // Mass of the minig frigate hull (Kg)
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
        attribute warpCoreStrength :>> warpCoreStrength default 2;  //resilience to being immobilized    
        // specific attributes of the mining frigate Venture class
        attribute oreHoldCapacity : Real default 5000.0;       // Maximum ore cargo capacity (m³)
        attribute droneCapacity : Real default 10;     // Drones cargo capacity (m³)
        attribute oreHoldStatus : Real default 2;    // Capacity status of the ores hold
        attribute maxLockedTargets :>> maxLockedTargets default 5;   // Number, the maximum number of locked targets (STRQ07)
        attribute magnetometricSensorStrength :>> sensorStrength default 4;  //ability to lock in a signature
        
        //Ports of the mining frigate redefine the imperial ship definition
        port highPowerSlot1 :>> highPowerSlot[1];
        port highPowerSlot2 :>> highPowerSlot[1];
        port midPowerSlot1 :>> midPowerSlot[1];
        port midPowerSlot2 :>> midPowerSlot[1];
        port midPowerSlot3 :>> midPowerSlot[1];
        port lowPowerSlot1 :>> lowPowerSlot[1];
        //Rig extension points of the mining frigate redefine the imperial ship definition
        port rigPort1 : RigPortSmall :>> rigPort[1];
        port rigPort2 : RigPortSmall :>> rigPort[1];
        port rigPort3 : RigPortSmall :>> rigPort[1];
        //Other ports redefine the imperial ship definition or add to the specific ship
        port podPort :>> podPort;
        port dockingPort :>> dockingPort;
        port droneControl : DroneControllerPort[2];
        port shieldMitigationPort :>> shieldMitigationPort;
        port armourMitigationPort :>> armourMitigationPort;
        port structureMitigationPort :>> structureMitigationPort;
        port longRangeDirectionalSensorAntenna :>> longRangeDirectionalSensorAntenna : LongRangeSensorDirectionalAntenna, GravimetricAntenna;
        port gridSensorAntenna :>> gridSensorAntenna : GridSensorAntenna, GravimetricAntenna;
        port shipComms :>> shipComms;
        port warpShield :>> warpShield;
        port propulsionDisruption :>> propulsionDisruption;
        port propulsionZ :>> propulsionZ[4];
        port propulsionX :>> propulsionX[1..*];
        port propulsionY :>> propulsionY[1..*];

        state miningFrigateStates :>> states {
            
            entry action initial;
            then state Parked :>> Parked {
                doc /* The mining frigate is parked inside a station and can be boarded. */
            } 	
            state Boarded :>> Boarded {
                doc /* The mining frigate is boarded inside a station in the docking pad, available for refitting, resupply, or cargo transfer. */
            }
            state InGrid :>> InGrid {
                doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
                entry action undockFromStation;
            }
            state OnWarp :>> OnWarp {
                doc /* The mining frigate is in warp, traveling between locations. */
                entry action executeWarpDrive;
            }        
            
            transition miningFrigate_parked_to_boarded
                first Parked
                accept boardShip : StationCommand via podPort
                then Boarded;
            
            transition miningFrigate_boarded_to_parked
                first Boarded
                accept unboardShip : StationCommand via podPort
                then Parked;
            
            transition miningFrigate_boarded_to_inGrid
                first Boarded
                accept pilotPodUndockCommandSig : ShipCommand via podPort
                do action initializeGridServicesMiningFrigate
                then InGrid;  		
                
            transition miningFrigate_inGrid_to_docked
                first InGrid
                accept pilotPodDockCommandSig : ShipCommand via podPort
                then Boarded;
                
            transition miningFrigate_inGrid_to_onWarp
                first InGrid
                accept warpCommandSig : ShipCommand via podPort
                then OnWarp;
        
            transition miningFrigate_onWarp_to_inGrid
                first OnWarp
                accept when warpBubbleEnd
                then InGrid;  
        } 

        action initializeGridServicesMiningFrigate :>> initializeGridServices {
            doc /*This action initializes the spaceship for the operational services in grid.
                    * The actions do not end of themselves but will be terminated by the transition on the state. 
                    */
            first start;
            then fork;
                then scanSpaceMiningFrigate;
                then approachSignatureMiningFrigate;
                then deployDefenseDronesMiningFrigate;
                then dockInStationMiningFrigate;
                then executeWarpDriveMiningFrigate;
                then updateSystemConfigurationMiningFrigate;

            action deployDefenseDronesMiningFrigate { //the Mining Frigate hull has a built in drone bay with drone functionality. 
                doc /*Activate defense turrets and deploy drones to neutralize threats.*/   
            }
            action scanSpaceMiningFrigate :>> scanSpace {
                doc /* Scan the grid and range space for potential threats. */
            }

            action approachSignatureMiningFrigate :>> approachSignature {
                doc /*Approach a signature using the navigation system.*/
            }
            
            action dockInStationMiningFrigate :>> dockInStation {
                doc /*Dock into a station to make repairs, resupply capacitor and support systems.*/
            }
            
            action executeWarpDriveMiningFrigate :>> executeWarpDrive {
                doc /* Engage the warp drive to travel to the destination. */
            }

            action updateSystemConfigurationMiningFrigate :>> updateSystemConfiguration {
                doc /* 
                    * Activates all service modules in a configured ship
                    * Record all installed modules in the configuration of the system and enables them 
                    */
            }    
        }

        action transferOreMiningFrigate { //the Mining Frigate hull has a built in ore hold with transfer functionality. 
            doc /*Transfer Ores from the ore hold in the frigate to the station warehouse*/   
        }

        action undockFromStationMiningFrigate :>> undockFromStation {
            doc /*Undock from a station.*/
        }
    }

    abstract part miningFrigateConfiguration : MiningFrigateVentureClass {
        variation part minerModule : MinerModule[2] {
            variant 'Mining Laser EP-S Gaussian Scoped';
            variant 'Mining Laser Particle Bore Compact';
            variant minerI; 
        }
    }

    //Different configurations of mining frigate are defined here that base on an abstract frigate

    part highSecMiningFrigate :> miningFrigateConfiguration {

        //relevant attributes for the roll up calculation
        attribute :>> massShip;
        attribute :>> suppliedPowerGrid;
        attribute :>> suppliedCapacitor;
        attribute :>> suppliedCpu;
        // redefined attributes of a ship
        attribute :>> maxVelocity = 
            miningFrigateConfiguration.maxVelocity * 
            propulsionEnhancer.velocityBonus;  //Maximum velocity (m/s)
        attribute :>> warpSpeed;
        attribute :>> alignTime;
        attribute :>> structureStrength;
        attribute :>> armorStrength;
        attribute :>> shieldStrength;  //Strength of the shield (STRQ03)
        attribute :>> cargoHoldCapacity;
        attribute :>> warpCoreStrength;  
        // specific attributes of the mining frigate Venture class
        attribute :>> oreHoldCapacity;
        attribute :>> droneCapacity;
        attribute :>> oreHoldStatus;
        attribute :>> maxLockedTargets;
        attribute :>> magnetometricSensorStrength;
        // attributes inherited from mounted modules 
        #mop attribute miningRate : Real =          // Depends on COTS. Volume of ore mined per second (m³/s)
            minerModule1.miningYield / minerModule1.cycleTime + 
            minerModule2.miningYield / minerModule2.cycleTime;

        //the mop is allocated to the corresponding moe
        //some of all the responsibility for realizing the source moe is allocated to the here defined target mop
        allocate domain.miningCorporation.highSecMiningPilotPod.operationalMiningRate 
        to highSecMiningFrigate.miningRate;

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
            hullPort ::> highSecMiningFrigate.droneControl to
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
    
        action initializeGridServicesMiningFrigate :>> initializeGridServicesMiningFrigate { 
            action updateSystemConfigurationMiningFrigate :>> updateSystemConfigurationMiningFrigate {
                //these are call to actions referenced from the COTS
                perform action extractOreMinerLaser1 ::> minerModule1.extractOre;
                then perform action extractOreMinerLaser2 ::> minerModule2.extractOre;
                then perform action boostSpeed ::> propulsionEnhancer.boostSpeed;
            }
        }
    } 
    
    part lowSecMiningFrigate :> miningFrigateConfiguration {

        //relevant attributes for the roll up calculation
        attribute :>> massShip;
        attribute :>> suppliedPowerGrid;
        attribute :>> suppliedCapacitor;
        attribute :>> suppliedCpu;
        // redefined attributes of a ship
        attribute :>> maxVelocity = 
            miningFrigateConfiguration.maxVelocity * 
            propulsionEnhancer.velocityBonus;  //Maximum velocity (m/s)
        attribute :>> warpSpeed;
        attribute :>> alignTime;
        attribute :>> structureStrength;
        attribute :>> armorStrength;
        attribute :>> shieldStrength = 
            miningFrigateConfiguration.shieldStrength * 
            shieldExtender.shieldHPBonus;  //Strength of the shield (STRQ03)
        attribute :>> cargoHoldCapacity;
        attribute :>> warpCoreStrength;  
        // specific attributes of the mining frigate Venture class
        attribute :>> oreHoldCapacity;
        attribute :>> droneCapacity;
        attribute :>> oreHoldStatus;
        attribute :>> maxLockedTargets;
        attribute :>> magnetometricSensorStrength;
        // attributes inherited from mounted modules 
        #mop attribute miningRate =          // Depends on COTS. Volume of ore mined per second (m³/s)
            minerModule1.miningYield / minerModule1.cycleTime + 
            minerModule2.miningYield / minerModule2.cycleTime; 

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
            hullPort ::> lowSecMiningFrigate.droneControl to
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
    
        action initializeGridServicesMiningFrigate :>> initializeGridServicesMiningFrigate { 
            action updateSystemConfigurationMiningFrigate :>> updateSystemConfigurationMiningFrigate {
                //these are call to actions referenced from the COTS
                perform action extractOreMinerLaser1 ::> minerModule1.extractOre;
                then perform action extractOreMinerLaser2 ::> minerModule2.extractOre;
                then perform action boostSpeed ::> propulsionEnhancer.boostSpeed;
                then perform action extendShield ::> shieldExtender.extendShield;
            }
        }
    } 

    part nullSecMiningFrigate :> miningFrigateConfiguration {
        
        //relevant attributes for the roll up calculation
        attribute :>> massShip;
        attribute :>> suppliedPowerGrid;
        attribute :>> suppliedCapacitor = 
            miningFrigateConfiguration.suppliedCapacitor + 
            capacitorExtender.capacitorBonus;   //Capacity installed (GJ)
        attribute :>> suppliedCpu;
        // redefined attributes of a ship
        attribute :>> maxVelocity = 
            miningFrigateConfiguration.maxVelocity + 
            propulsionEnhancer.velocityBonus;  //Maximum velocity (m/s)
        attribute :>> warpSpeed;
        attribute :>> alignTime;
        attribute :>> structureStrength;
        attribute :>> armorStrength;
        attribute :>> shieldStrength = 
            miningFrigateConfiguration.shieldStrength + 
            shieldExtender.shieldHPBonus;  //Strength of the shield (STRQ03)
        attribute :>> cargoHoldCapacity;
        attribute :>> warpCoreStrength;    
        // specific attributes of the mining frigate Venture class
        attribute :>> oreHoldCapacity;
        attribute :>> droneCapacity;
        attribute :>> oreHoldStatus;
        attribute :>> maxLockedTargets;
        attribute :>> magnetometricSensorStrength;
        // attributes inherited from mounted modules 
        #mop attribute miningRate =          // Depends on COTS. Volume of ore mined per second (m³/s)
            minerModule1.miningYield / minerModule1.cycleTime + 
            minerModule2.miningYield / minerModule2.cycleTime; 
    
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
            hullPort ::> nullSecMiningFrigate.droneControl to
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
        
        action initializeGridServicesMiningFrigate :>> initializeGridServicesMiningFrigate { 
            action updateSystemConfigurationMiningFrigate :>> updateSystemConfigurationMiningFrigate {
                //these are call to actions referenced from the COTS
                perform action extractOreMinerLaser1 ::> minerModule1.extractOre;
                then perform action extractOreMinerLaser2 ::> minerModule2.extractOre;
                then perform action boostSpeed ::> propulsionEnhancer.boostSpeed;
                then perform action extendShield ::> shieldExtender.extendShield;
                then perform action scanAsteroid ::> surveyScanner.scanAsteroid;
            }
        }
    }

    //trace the activities identified in the Operational Use Cases with the activities defined at the Mining Frigate Blackbox.
    //A dependency states that the "from end" of the dependency needs the "to end" to be specified.
    dependency highSecMiningFrigate::initializeGridServicesMiningFrigate::updateSystemConfigurationMiningFrigate 
        to SystemUseCases::MineAsteroids::highSecMiningFrigate::activateMiningLaser;
    dependency highSecMiningFrigate::initializeGridServicesMiningFrigate::scanSpaceMiningFrigate
        to SystemUseCases::MonitorAndDetectThreats::highSecMiningFrigate::scanSpace;
    dependency highSecMiningFrigate::initializeGridServicesMiningFrigate::executeWarpDriveMiningFrigate
        to SystemUseCases::WarpToCelestial::highSecMiningFrigate::executeWarpDrive;
    dependency highSecMiningFrigate::initializeGridServicesMiningFrigate::approachSignatureMiningFrigate
        to SystemUseCases::ApproachSignature::highSecMiningFrigate::approachSignature;
    dependency highSecMiningFrigate::initializeGridServicesMiningFrigate::dockInStationMiningFrigate
        to SystemUseCases::DockToStation::highSecMiningFrigate::dockInStation;
    dependency highSecMiningFrigate::initializeGridServicesMiningFrigate::deployDefenseDronesMiningFrigate
        to SystemUseCases::DeployDefenseDrones;
    dependency highSecMiningFrigate::transferOreMiningFrigate
        to SystemUseCases::TransferOre;
    dependency highSecMiningFrigate::undockFromStationMiningFrigate
        to SystemUseCases::UndockFromStation;

    
    //Views and views definition
    view def 'Mining Frigate Behavior'{
        satisfy StakeholderConcerns::SecurityConcern;

        filter @SysML::ExhibitStateUsage;
    }
    view 'Mining Frigate states' : 'Mining Frigate Behavior' {
        expose miningFrigateConfiguration::miningFrigateStates::*;
        //render TBD;
    }   
 }