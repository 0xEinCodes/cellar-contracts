// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

import { ERC20 } from "@solmate/tokens/ERC20.sol";
import { CErc20 } from "src/interfaces/external/ICompound.sol";

contract MainnetAddresses {
    // Sommelier
    address public gravityBridgeAddress = 0x69592e6f9d21989a043646fE8225da2600e5A0f7;
    address public strategist = 0xA9962a5BfBea6918E958DeE0647E99fD7863b95A;
    address public cosmos = address(0xCAAA);

    // DeFi Ecosystem
    address public uniV3Router = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    address public uniV2Router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    // ERC20s
    ERC20 public USDC = ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    ERC20 public WETH = ERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    ERC20 public WBTC = ERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);
    ERC20 public USDT = ERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    ERC20 public TUSD = ERC20(0x0000000000085d4780B73119b644AE5ecd22b376);
    ERC20 public DAI = ERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    ERC20 public WSTETH = ERC20(0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0);
    ERC20 public STETH = ERC20(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);
    ERC20 public FRAX = ERC20(0x853d955aCEf822Db058eb8505911ED77F175b99e);
    ERC20 public BAL = ERC20(0xba100000625a3754423978a60c9317c58a424e3D);
    ERC20 public COMP = ERC20(0xc00e94Cb662C3520282E6f5717214004A7f26888);
    ERC20 public LINK = ERC20(0x514910771AF9Ca656af840dff83E8264EcF986CA);

    // Chainlink Datafeeds
    address public WETH_USD_FEED = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
    address public USDC_USD_FEED = 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6;
    address public WBTC_USD_FEED = 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
    address public TUSD_USD_FEED = 0xec746eCF986E2927Abd291a2A1716c940100f8Ba;
    address public STETH_USD_FEED = 0xCfE54B5cD566aB89272946F602D76Ea879CAb4a8;
    address public DAI_USD_FEED = 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9;
    address public USDT_USD_FEED = 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D;
    address public COMP_USD_FEED = 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5;
    address public fastGasFeed = 0x169E633A2D1E6c10dD91238Ba11c4A708dfEF37C;
    address public FRAX_USD_FEED = 0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD;

    // Aave V2 Tokens
    ERC20 public aV2WETH = ERC20(0x030bA81f1c18d280636F32af80b9AAd02Cf0854e);
    ERC20 public aV2USDC = ERC20(0xBcca60bB61934080951369a648Fb03DF4F96263C);
    ERC20 public dV2USDC = ERC20(0x619beb58998eD2278e08620f97007e1116D5D25b);
    ERC20 public dV2WETH = ERC20(0xF63B34710400CAd3e044cFfDcAb00a0f32E33eCf);
    ERC20 public aV2WBTC = ERC20(0x9ff58f4fFB29fA2266Ab25e75e2A8b3503311656);
    ERC20 public aV2TUSD = ERC20(0x101cc05f4A51C0319f570d5E146a8C625198e636);
    ERC20 public aV2STETH = ERC20(0x1982b2F5814301d4e9a8b0201555376e62F82428);
    ERC20 public aV2DAI = ERC20(0x028171bCA77440897B824Ca71D1c56caC55b68A3);

    // Aave V3 Tokens
    ERC20 public aV3WETH = ERC20(0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8);
    ERC20 public aV3USDC = ERC20(0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c);
    ERC20 public dV3USDC = ERC20(0x72E95b8931767C79bA4EeE721354d6E99a61D004);
    ERC20 public aV3DAI = ERC20(0x018008bfb33d285247A21d44E50697654f754e63);
    ERC20 public dV3WETH = ERC20(0xeA51d7853EEFb32b6ee06b1C12E6dcCA88Be0fFE);
    ERC20 public aV3WBTC = ERC20(0x5Ee5bf7ae06D1Be5997A1A72006FE6C607eC6DE8);

    // Balancer V2 Addresses
    ERC20 public BB_A_USD = ERC20(0xfeBb0bbf162E64fb9D0dfe186E517d84C395f016);
    ERC20 public vanillaUsdcDaiUsdt = ERC20(0x79c58f70905F734641735BC61e45c19dD9Ad60bC);
    ERC20 public BB_A_WETH = ERC20(0x60D604890feaa0b5460B28A424407c24fe89374a);
    ERC20 public wstETH_bbaWETH = ERC20(0xE0fCBf4d98F0aD982DB260f86cf28b49845403C5);

    // Linear Pools.
    ERC20 public bb_a_dai = ERC20(0x6667c6fa9f2b3Fc1Cc8D85320b62703d938E4385);
    ERC20 public bb_a_usdt = ERC20(0xA1697F9Af0875B63DdC472d6EeBADa8C1fAB8568);
    ERC20 public bb_a_usdc = ERC20(0xcbFA4532D8B2ade2C261D3DD5ef2A2284f792692);

    ERC20 public BB_A_USD_GAUGE = ERC20(0x0052688295413b32626D226a205b95cDB337DE86); // query subgraph for gauges wrt to poolId: https://docs.balancer.fi/reference/vebal-and-gauges/gauges.html#query-gauge-by-l2-sidechain-pool:~:text=%23-,Query%20Pending%20Tokens%20for%20a%20Given%20Pool,-The%20process%20differs
    address public BB_A_USD_GAUGE_ADDRESS = 0x0052688295413b32626D226a205b95cDB337DE86;
    address public wstETH_bbaWETH_GAUGE_ADDRESS = 0x5f838591A5A8048F0E4C4c7fCca8fD9A25BF0590;

    // Mainnet Balancer Specific Addresses
    address public vault = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    address public relayer = 0xfeA793Aa415061C483D2390414275AD314B3F621;
    address public minter = 0x239e55F427D44C3cc793f49bFB507ebe76638a2b;

    // Compound V2
    CErc20 public cDAI = CErc20(0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643);
    CErc20 public cUSDC = CErc20(0x39AA39c021dfbaE8faC545936693aC917d5E7563);
    CErc20 public cTUSD = CErc20(0x12392F67bdf24faE0AF363c24aC620a2f67DAd86);

    // Chainlink Automation Registry
    address public automationRegistry = 0x02777053d6764996e594c3E88AF1D58D5363a2e6;

    // FraxLend Pairs
    address public FXS_FRAX_PAIR = 0xDbe88DBAc39263c47629ebbA02b3eF4cf0752A72;
    address public FPI_FRAX_PAIR = 0x74F82Bd9D0390A4180DaaEc92D64cf0708751759;
    address public SFRXETH_FRAX_PAIR = 0x78bB3aEC3d855431bd9289fD98dA13F9ebB7ef15;
    address public WETH_FRAX_PAIR = 0x794F6B13FBd7EB7ef10d1ED205c9a416910207Ff;
}