// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

interface IMorpho {
    // For Aave V3.
    struct LiquidityData {
        uint256 borrowable; // The maximum debt value allowed to borrow (in base currency).
        uint256 maxDebt; // The maximum debt value allowed before being liquidatable (in base currency).
        uint256 debt; // The debt value (in base currency).
    }

    function liquidityData(address user) external view returns (LiquidityData memory);

    function userBorrows(address user) external view returns (address[] memory);

    function collateralBalance(address underlying, address user) external view returns (uint256);

    function supplyBalance(address underlying, address user) external view returns (uint256);

    function borrowBalance(address underlying, address user) external view returns (uint256);

    function scaledP2PBorrowBalance(address underlying, address user) external view returns (uint256);

    function scaledP2PSupplyBalance(address underlying, address user) external view returns (uint256);

    function scaledPoolBorrowBalance(address underlying, address user) external view returns (uint256);

    function scaledPoolSupplyBalance(address underlying, address user) external view returns (uint256);

    function borrow(
        address underlying,
        uint256 amount,
        address onBehalf,
        address receiver,
        uint256 maxIterations
    ) external returns (uint256);

    function repay(address underlying, uint256 amount, address onBehalf) external returns (uint256);

    function supply(
        address underlying,
        uint256 amount,
        address onBehalf,
        uint256 maxIterations
    ) external returns (uint256);

    function supplyCollateral(address underlying, uint256 amount, address onBehalf) external returns (uint256);

    function withdraw(
        address underlying,
        uint256 amount,
        address onBehalf,
        address receiver,
        uint256 maxIterations
    ) external returns (uint256);

    function withdrawCollateral(
        address underlying,
        uint256 amount,
        address onBehalf,
        address receiver
    ) external returns (uint256);

    // For Aave V2.
    struct PoolIndexes {
        uint32 lastUpdateTimestamp; // The last time the local pool and peer-to-peer indexes were updated.
        uint112 poolSupplyIndex; // Last pool supply index. Note that for the stEth market, the pool supply index is tweaked to take into account the staking rewards.
        uint112 poolBorrowIndex; // Last pool borrow index. Note that for the stEth market, the pool borrow index is tweaked to take into account the staking rewards.
    }

    function userMarkets(address user) external view returns (bytes32);

    function borrowBalanceInOf(address poolToken, address user) external view returns (uint256 inP2P, uint256 onPool);

    function supplyBalanceInOf(address poolToken, address user) external view returns (uint256 inP2P, uint256 onPool);

    function poolIndexes(address poolToken) external view returns (PoolIndexes memory);

    function p2pSupplyIndex(address poolToken) external view returns (uint256);

    function p2pBorrowIndex(address poolToken) external view returns (uint256);

    function supply(address poolToken, uint256 amount) external;

    function borrow(address poolToken, uint256 amount) external;

    function repay(address poolToken, uint256 amount) external;

    function withdraw(address poolToken, uint256 amount, address receiver) external;
}