package TargetLockComputerArrayGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {

        part targetLockComputerArrayGrayBox : LogicalPart :> targetLockComputerArray {
            doc /*
                * Locks and tracks up to five targets
                */

            port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;
            port :>> highPowerTurretSlot1TargetingPort;
            port :>> highPowerTurretSlot2TargetingPort;

            part lowPowerSupplyUnit : LogicalPart {
                
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port targetLockComputer1Port :>> lowPowerLinePort;
                port targetLockComputer2Port :>> lowPowerLinePort;
                port targetLockComputer3Port :>> lowPowerLinePort;
                port targetLockComputer4Port :>> lowPowerLinePort;
                port targetLockComputer5Port :>> lowPowerLinePort;
                port targetLockComputerArrayControlerPort :>> lowPowerLinePort;
                
                perform initializeTargetingComputers.logicalPowerUpTrackingComputers;
            }

            part targetLockComputerArrayControler : LogicalPart {
                port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;
                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort; 

                perform initializeTargetingComputers {
                    in targetLockComputerArrayCommandPort : ~LogicalShipCommandPort;
                }
            }

            abstract part targetLockComputer[5] : LogicalPart {
                port targetLockManagerPort : LogicalShipCommandPort;
                port lowPowerSupplyUnitPort : ~LogicalLowPowerLinePort :>> lowPowerLinePort; 

            }
            part targetLockComputer1 :> targetLockComputer {
                perform initializeTargetingComputers.logicalEnableTargetingComputer1;
            }
            part targetLockComputer2 :> targetLockComputer {
                perform initializeTargetingComputers.logicalEnableTargetingComputer2;
            }
            part targetLockComputer3 :> targetLockComputer {
                perform initializeTargetingComputers.logicalEnableTargetingComputer3;
            }
            part targetLockComputer4 :> targetLockComputer {
                perform initializeTargetingComputers.logicalEnableTargetingComputer4;
            }
            part targetLockComputer5 :> targetLockComputer {
                perform initializeTargetingComputers.logicalEnableTargetingComputer5;
            }

            part lowPowerWiring : LogicalPart {
                ref lowPowerSupplyUnit :>> lowPowerSupplyUnit;
                ref targetLockComputer1 :>> targetLockComputer1;
                ref targetLockComputer2 :>> targetLockComputer2;
                ref targetLockComputer3 :>> targetLockComputer3;
                ref targetLockComputer4 :>> targetLockComputer4;
                ref targetLockComputer5 :>> targetLockComputer5;
                ref targetLockComputerArrayControler :>> targetLockComputerArrayControler;

                //Low power wiring
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.targetLockComputer1Port to
                    consumerPort ::> targetLockComputer1.lowPowerSupplyUnitPort; 
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.targetLockComputer2Port to
                    consumerPort ::> targetLockComputer2.lowPowerSupplyUnitPort;
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.targetLockComputer3Port to
                    consumerPort ::> targetLockComputer3.lowPowerSupplyUnitPort; 
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.targetLockComputer4Port to
                    consumerPort ::> targetLockComputer4.lowPowerSupplyUnitPort; 
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.targetLockComputer5Port to
                    consumerPort ::> targetLockComputer5.lowPowerSupplyUnitPort; 
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.targetLockComputerArrayControlerPort to
                    consumerPort ::> targetLockComputerArrayControler.lowPowerSupplyUnitPort; 

            }

            action :>> initializeTargetingComputers {
                doc /*
                    * Initializes the targeting computers.
                    */

                in targetLockComputerArrayCommandPort : ~LogicalShipCommandPort;
                first start;
                then action logicalPowerUpTrackingComputers;
                then fork;
                    then logicalEnableTargetingComputer1; 
                    then logicalEnableTargetingComputer2;
                    then logicalEnableTargetingComputer3;
                    then logicalEnableTargetingComputer4;
                    then logicalEnableTargetingComputer5;

                    action logicalEnableTargetingComputer1 {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputerArrayCommandPort;
                    }
                    action logicalEnableTargetingComputer2 {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputerArrayCommandPort;
                    }
                    action logicalEnableTargetingComputer3 {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputerArrayCommandPort;
                    }
                    action logicalEnableTargetingComputer4 {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputerArrayCommandPort;
                    }
                    action logicalEnableTargetingComputer5 {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputerArrayCommandPort;
                    }
            }
            action def logicalEnableTargetingComputer {
                    in logicalEnableTargetingComputerCommandPort : LogicalShipCommandPort;
                    in turretSlot : LogicalAlignmentPort;
                    out turretAlignment : LogicalAlignmentSignal;

                    action acceptTargetSignature accept targetSignature : LogicalLockTarget via logicalEnableTargetingComputerCommandPort;
                    then action targetLockSignature {
                        in targetSignature = acceptTargetSignature.targetSignature.signatureGrid;
                        out turretAligment = turretSlot.logicalAlignmentSignal;
                    }
                    then action logicalreportTargetLock {out shipReport : LogicalShipReport;}
                    then send logicalreportTargetLock.shipReport via logicalEnableTargetingComputerCommandPort;
                }
        }
    }
}