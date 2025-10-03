package PowerGridGrayBox {
    
    private import LogicalGrayBoxMiningFrigate::*;
    private import ScalarValues::*;
    private import SI::*;
    private import ParametersOfInterestMetadata::*;
    private import LogicalReferenceArchitecture::LogicalDefinitions::*;
    private import StdPortsAndInterfaces::ImperialTechnology::ImperialStandardItems::*;

    part def LogicalWhiteBoxMiningFrigateVentureClass :> LogicalGrayBoxMiningFrigateVentureClass {

        part powerGridGrayBox : LogicalPart :> powerGrid {
            doc /*
                * Routes power to the expansion modules.
                */
            attribute suppliedPowerGrid :>> suppliedPowerGrid default 45;

            port energyStoreSupplyPort : ~LogicalPowerGridPort :>> energyStoreSupplyPort;
            port energyStoreFlowbackPort :>> energyStoreFlowbackPort;
            port highPowerSlotCoupling1GridPort :>> highPowerSlotCoupling1GridPort;
            port highPowerSlotCoupling2GridPort :>> highPowerSlotCoupling2GridPort;
            port highPowerSlotCoupling3GridPort :>> highPowerSlotCoupling3GridPort;
            port midPowerSlotCoupling1GridPort :>> midPowerSlotCoupling1GridPort;
            port midPowerSlotCoupling2GridPort :>> midPowerSlotCoupling2GridPort;
            port midPowerSlotCoupling3GridPort :>> midPowerSlotCoupling3GridPort;
            port shieldGeneratorGridPort :>> shieldGeneratorGridPort;
            port powerGridLowPowerGridPort :>> lowPowerGridPort; 

            part lowPowerSupplyUnit : LogicalPart {
                
                port lowPowerGridPort : ~LogicalLowPowerGridPort :>> lowPowerGridPort;
                port powerGridNetworkPort :>> lowPowerLinePort;
                
                perform logicalInitializePowerGrid.logicalPowerUpPowerGrid;
            }

            part powerGridNetwork : LogicalPart {
                attribute suppliedPowerGrid :>> suppliedPowerGrid default 45;
                
                port energyStoreSupplyPort : ~LogicalPowerGridPort :>> energyStoreSupplyPort;
                port energyStoreFlowbackPort :>> energyStoreFlowbackPort;
                port highPowerSlotCoupling1GridPort :>> highPowerSlotCoupling1GridPort;
                port highPowerSlotCoupling2GridPort :>> highPowerSlotCoupling2GridPort;
                port highPowerSlotCoupling3GridPort :>> highPowerSlotCoupling3GridPort;
                port midPowerSlotCoupling1GridPort :>> midPowerSlotCoupling1GridPort;
                port midPowerSlotCoupling2GridPort :>> midPowerSlotCoupling2GridPort;
                port midPowerSlotCoupling3GridPort :>> midPowerSlotCoupling3GridPort;
                port shieldGeneratorGridPort :>> shieldGeneratorGridPort;
                port lowPowerSupplyUnitPort :>> lowPowerLinePort;

                perform logicalInitializePowerGrid.monitorPowerInGrid {
                    in energyStoreSupplyProxyPort : LogicalPowerSupply = energyStoreSupplyPort.powerGridEnergy;
                    in shieldGeneratorGridProxyPort : LogicalPowerGridPort = shieldGeneratorGridPort;
                    out energyFlowback : LogicalPowerSupply = energyStoreFlowbackPort.powerGridEnergy;
                    out highPowerSlotCoupling1Energy : LogicalPowerSupply = highPowerSlotCoupling1GridPort.powerGridEnergy;
                    out highPowerSlotCoupling2Energy : LogicalPowerSupply = highPowerSlotCoupling2GridPort.powerGridEnergy;
                    out highPowerSlotCoupling3Energy : LogicalPowerSupply = highPowerSlotCoupling3GridPort.powerGridEnergy;
                    out midPowerSlotCoupling1Energy : LogicalPowerSupply = midPowerSlotCoupling1GridPort.powerGridEnergy;
                    out midPowerSlotCoupling2Energ: LogicalPowerSupply = midPowerSlotCoupling2GridPort.powerGridEnergy;
                    out midPowerSlotCoupling3Energy : LogicalPowerSupply = midPowerSlotCoupling3GridPort.powerGridEnergy;
                }
            }
            
            part lowPowerWiring : LogicalPart {
                ref lowPowerSupplyUnit :>> lowPowerSupplyUnit;
                ref powerGridNetwork :>> powerGridNetwork;

                //Low power wiring
                interface : LogicalLowPowerGridIF connect
                    supplierPort ::> lowPowerSupplyUnit.powerGridNetworkPort to
                    consumerPort ::> powerGridNetwork.lowPowerSupplyUnitPort;       
            }

            bind energyStoreSupplyPort = powerGridNetwork.energyStoreSupplyPort;
            bind energyStoreFlowbackPort = powerGridNetwork.energyStoreFlowbackPort;
            bind highPowerSlotCoupling1GridPort = powerGridNetwork.highPowerSlotCoupling1GridPort;
            bind highPowerSlotCoupling2GridPort = powerGridNetwork.highPowerSlotCoupling2GridPort;
            bind highPowerSlotCoupling3GridPort = powerGridNetwork.highPowerSlotCoupling3GridPort;
            bind midPowerSlotCoupling1GridPort = powerGridNetwork.midPowerSlotCoupling1GridPort;
            bind midPowerSlotCoupling2GridPort = powerGridNetwork.midPowerSlotCoupling2GridPort;
            bind midPowerSlotCoupling3GridPort = powerGridNetwork.midPowerSlotCoupling3GridPort;
            bind shieldGeneratorGridPort = powerGridNetwork.shieldGeneratorGridPort;
            bind powerGridLowPowerGridPort = lowPowerSupplyUnit.lowPowerGridPort;
            
            action :>> logicalInitializePowerGrid {
                doc /*
                    * Relays power from the energyStore to the modules
                    * Monitors the powerGrid
                    */
                
                in energyIn : LogicalPowerSupply :>> energyIn;
                in shieldGeneratorGridPort : LogicalPowerGridPort :>> shieldGeneratorGridPort;
                out energyFlowback : LogicalPowerSupply :>> energyFlowback;
                out highPowerSlotCoupling1Energy : LogicalPowerSupply :>> highPowerSlotCoupling1Energy;
                out highPowerSlotCoupling2Energy : LogicalPowerSupply :>> highPowerSlotCoupling2Energy;
                out highPowerSlotCoupling3Energy : LogicalPowerSupply :>> highPowerSlotCoupling3Energy;
                out midPowerSlotCoupling1Energy : LogicalPowerSupply :>> midPowerSlotCoupling1Energy;
                out midPowerSlotCoupling2Energy : LogicalPowerSupply :>> midPowerSlotCoupling2Energy;
                out midPowerSlotCoupling3Energy : LogicalPowerSupply :>> midPowerSlotCoupling3Energy;
                
                first start;
                then action logicalPowerUpPowerGrid;
                then action monitorPowerInGrid {
                    in energyIn : LogicalPowerSupply;
                    in shieldGeneratorGridPort : LogicalPowerGridPort;
                    out energyFlowback : LogicalPowerSupply;
                    out highPowerSlotCoupling1Energy : LogicalPowerSupply;
                    out highPowerSlotCoupling2Energy : LogicalPowerSupply;
                    out highPowerSlotCoupling3Energy : LogicalPowerSupply;
                    out midPowerSlotCoupling1Energy : LogicalPowerSupply;
                    out midPowerSlotCoupling2Energ: LogicalPowerSupply;
                    out midPowerSlotCoupling3Energy : LogicalPowerSupply;
                    
                }  
            }     
        }
    }
}