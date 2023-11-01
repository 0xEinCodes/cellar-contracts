// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.21;

import { Math } from "src/utils/Math.sol";
import { Deployer } from "src/Deployer.sol";
import { ERC4626 } from "@solmate/mixins/ERC4626.sol";
import { ERC20 } from "@solmate/tokens/ERC20.sol";
import { Registry } from "src/Registry.sol";
import { PriceRouter } from "src/modules/price-router/PriceRouter.sol";
import { IChainlinkAggregator } from "src/interfaces/external/IChainlinkAggregator.sol";

import { StEthExtension } from "src/modules/price-router/Extensions/Lido/StEthExtension.sol";
import { WstEthExtension } from "src/modules/price-router/Extensions/Lido/WstEthExtension.sol";
import { RedstonePriceFeedExtension } from "src/modules/price-router/Extensions/Redstone/RedstonePriceFeedExtension.sol";
import { IRedstoneAdapter } from "src/interfaces/external/Redstone/IRedstoneAdapter.sol";
import { BalancerStablePoolExtension } from "src/modules/price-router/Extensions/Balancer/BalancerStablePoolExtension.sol";
import { AuraERC4626Adaptor } from "src/modules/adaptors/Aura/AuraERC4626Adaptor.sol";

import { MorphoAaveV2ATokenAdaptor } from "src/modules/adaptors/Morpho/MorphoAaveV2ATokenAdaptor.sol";
import { MorphoAaveV3ATokenP2PAdaptor } from "src/modules/adaptors/Morpho/MorphoAaveV3ATokenP2PAdaptor.sol";

import { DebtFTokenAdaptorV1 } from "src/modules/adaptors/Frax/DebtFTokenAdaptorV1.sol";

import { MainnetAddresses } from "test/resources/MainnetAddresses.sol";

import "forge-std/Script.sol";

/**
 * @dev Run
 *      `source .env && forge script script/prod/DeployMacroAudit12.s.sol:DeployMacroAudit12Script --rpc-url $MAINNET_RPC_URL  --private-key $PRIVATE_KEY —optimize —optimizer-runs 200 --with-gas-price 25000000000 --verify --etherscan-api-key $ETHERSCAN_KEY --slow --broadcast`
 * @dev Optionally can change `--with-gas-price` to something more reasonable
 */
contract DeployMacroAudit12Script is Script, MainnetAddresses {
    using Math for uint256;

    address public sommDev = 0x552acA1343A6383aF32ce1B7c7B1b47959F7ad90;

    Deployer public deployer = Deployer(deployerAddress);

    Registry public registry = Registry(0xEED68C267E9313a6ED6ee08de08c9F68dee44476);
    PriceRouter public priceRouter = PriceRouter(0xA1A0bc3D59e4ee5840c9530e49Bdc2d1f88AaF92);

    uint8 public constant CHAINLINK_DERIVATIVE = 1;
    uint8 public constant TWAP_DERIVATIVE = 2;
    uint8 public constant EXTENSION_DERIVATIVE = 3;

    WstEthExtension public wstEthExtension;
    AuraERC4626Adaptor public auraERC4626Adaptor;

    function run() external {
        bytes memory creationCode;
        bytes memory constructorArgs;

        vm.startBroadcast();

        // Deploy the price router.
        creationCode = type(PriceRouter).creationCode;
        constructorArgs = abi.encode(sommDev, registry, WETH);
        priceRouter = PriceRouter(
            deployer.deployContract("Isolated PriceRouter V0.0", creationCode, constructorArgs, 0)
        );

        // Deploy WSTETH Extension.
        {
            creationCode = type(WstEthExtension).creationCode;
            constructorArgs = abi.encode(priceRouter);
            wstEthExtension = WstEthExtension(
                deployer.deployContract("WstEthExtension V 0.1", creationCode, constructorArgs, 0)
            );
        }

        // Deploy Aura Adaptor.
        {
            creationCode = type(AuraERC4626Adaptor).creationCode;
            constructorArgs = hex"";
            auraERC4626Adaptor = AuraERC4626Adaptor(
                deployer.deployContract("Aura ERC4626 Adaptor V0.0", creationCode, constructorArgs, 0)
            );
        }

        // Add Chainlink USD assets.
        PriceRouter.ChainlinkDerivativeStorage memory stor;
        PriceRouter.AssetSettings memory settings;

        uint256 price = uint256(IChainlinkAggregator(WETH_USD_FEED).latestAnswer());
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, WETH_USD_FEED);
        priceRouter.addAsset(WETH, settings, abi.encode(stor), price);

        price = uint256(IChainlinkAggregator(USDC_USD_FEED).latestAnswer());
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, USDC_USD_FEED);
        priceRouter.addAsset(USDC, settings, abi.encode(stor), price);

        price = uint256(IChainlinkAggregator(USDT_USD_FEED).latestAnswer());
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, USDT_USD_FEED);
        priceRouter.addAsset(USDT, settings, abi.encode(stor), price);

        price = uint256(IChainlinkAggregator(DAI_USD_FEED).latestAnswer());
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, DAI_USD_FEED);
        priceRouter.addAsset(DAI, settings, abi.encode(stor), price);

        price = uint256(IChainlinkAggregator(FRAX_USD_FEED).latestAnswer());
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, FRAX_USD_FEED);
        priceRouter.addAsset(FRAX, settings, abi.encode(stor), price);

        // Intentionally use WETH_USD_FEED for steth price, to peg it 1:1 with WETH.
        price = uint256(IChainlinkAggregator(WETH_USD_FEED).latestAnswer());
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, WETH_USD_FEED);
        priceRouter.addAsset(STETH, settings, abi.encode(stor), price);

        price = uint256(IChainlinkAggregator(WBTC_USD_FEED).latestAnswer());
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, WBTC_USD_FEED);
        priceRouter.addAsset(WBTC, settings, abi.encode(stor), price);

        // Add Chainlink ETH assets.
        stor.inETH = true;

        price = uint256(IChainlinkAggregator(RETH_ETH_FEED).latestAnswer());
        price = priceRouter.getValue(WETH, price, USDC);
        price = price.changeDecimals(6, 8);
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, RETH_ETH_FEED);
        priceRouter.addAsset(rETH, settings, abi.encode(stor), price);

        price = uint256(IChainlinkAggregator(CBETH_ETH_FEED).latestAnswer());
        price = priceRouter.getValue(WETH, price, USDC);
        price = price.changeDecimals(6, 8);
        settings = PriceRouter.AssetSettings(CHAINLINK_DERIVATIVE, CBETH_ETH_FEED);
        priceRouter.addAsset(cbETH, settings, abi.encode(stor), price);

        // Add wstEth.
        uint256 wstethToStethConversion = wstEthExtension.stEth().getPooledEthByShares(1e18);
        price = priceRouter.getValue(WETH, wstethToStethConversion, USDC);
        price = price.changeDecimals(6, 8);
        settings = PriceRouter.AssetSettings(EXTENSION_DERIVATIVE, address(wstEthExtension));
        priceRouter.addAsset(WSTETH, settings, abi.encode(0), price);

        // Add Balancer Assets.
        // settings = PriceRouter.AssetSettings(EXTENSION_DERIVATIVE, address(balancerStablePoolExtension));

        // {
        //     // New WstEth BB A WETH
        //     uint8[8] memory rateProviderDecimals;
        //     address[8] memory rateProviders;
        //     ERC20[8] memory underlyings;
        //     underlyings[0] = WETH;
        //     underlyings[1] = STETH;
        //     BalancerStablePoolExtension.ExtensionStorage memory extensionStor = BalancerStablePoolExtension
        //         .ExtensionStorage({
        //             poolId: bytes32(0),
        //             poolDecimals: 18,
        //             rateProviderDecimals: rateProviderDecimals,
        //             rateProviders: rateProviders,
        //             underlyingOrConstituent: underlyings
        //         });

        //     settings = PriceRouter.AssetSettings(EXTENSION_DERIVATIVE, address(balancerStablePoolExtension));
        //     priceRouter.addAsset(new_wstETH_bbaWETH, settings, abi.encode(extensionStor), 1.866e11);
        // }

        vm.stopBroadcast();
    }
}
