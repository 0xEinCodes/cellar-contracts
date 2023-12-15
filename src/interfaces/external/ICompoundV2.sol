// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.21;

interface ComptrollerG7 {
    function claimComp(address user) external;

    function markets(address market) external view returns (bool, uint256, bool, bool);

    function compAccrued(address user) external view returns (uint256);

    // Functions from ComptrollerInterface.sol to supply collateral that enable open borrows
    function enterMarkets(address[] calldata cTokens) external returns (uint[] memory);

    function exitMarket(address cToken) external returns (uint);
}

interface CErc20 {
    function underlying() external view returns (address);

    function balanceOf(address user) external view returns (uint256);

    function exchangeRateStored() external view returns (uint256);

    function borrowBalanceCurrent(address account) external view returns (uint);

    function mint(uint256 mintAmount) external returns (uint256);

    function redeemUnderlying(uint256 redeemAmount) external returns (uint256);

    function redeem(uint256 redeemTokens) external returns (uint256);

    function borrow(uint borrowAmount) external returns (uint);

    function repayBorrow(uint repayAmount) external returns (uint);
}
