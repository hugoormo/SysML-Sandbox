package TargetLockComputerArray {
    
    private import LogicalMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::*;

    part logicalMiningFrigateVentureClass : LogicalMiningFrigateVentureClass {

        part targetLockComputerArray : LogicalPart :>> targetLockComputerArray{
            doc /*
                * Locks and tracks up to five targets
                */

            port commandNetworkPort : ~LogicalShipCommandPort :>> commandNetworkPort;
            port :>> highPowerTurretSlot1TargetingPort;
            port :>> highPowerTurretSlot2TargetingPort;

            abstract part targetLockComputer[5] : LogicalPart {

                port targetLockManagerPort : LogicalShipCommandPort;

                action logicalEnableTargetingComputer {
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
            part targetLockComputer1 :> targetLockComputer {
                action :>> logicalEnableTargetingComputer;
            }
            part targetLockComputer2 :> targetLockComputer {
                action :>> logicalEnableTargetingComputer;
            }
            part targetLockComputer3 :> targetLockComputer {
                action :>> logicalEnableTargetingComputer;
            }
            part targetLockComputer4 :> targetLockComputer {
                action :>> logicalEnableTargetingComputer;
            }
            part targetLockComputer5 :> targetLockComputer {
                action :>> logicalEnableTargetingComputer;
            }

            action :>> initializeTargetingComputers {
                doc /*
                    * Initializes the targeting computers.
                    */

                first start;
                then action logicalPowerUpTrackingComputers;
                then fork;
                    then targetLockComputer1.logicalEnableTargetingComputer {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputer1.targetLockManagerPort;
                    }
                    then targetLockComputer2.logicalEnableTargetingComputer {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputer2.targetLockManagerPort;
                    }
                    then targetLockComputer3.logicalEnableTargetingComputer {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputer3.targetLockManagerPort;
                    }
                    then targetLockComputer4.logicalEnableTargetingComputer {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputer4.targetLockManagerPort;
                    }
                    then targetLockComputer5.logicalEnableTargetingComputer {
                        in logicalEnableTargetingComputerCommandPort = targetLockComputer5.targetLockManagerPort;
                    }
            }
        }
    }
}