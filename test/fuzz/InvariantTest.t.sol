// have our invariants aka properties

// what are our invariants?
// 1. the supply of dsc shoudl be less than the total value of collateral
// 2. Getter view functions should never revert <- evergreen invariant

// in handler test:
// don't  call redeemCollateral unless there is collateral to redeem and this is done by handler

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Handler} from "./Handler.t.sol";

contract InvariantsTest is StdInvariant, Test {
    DeployDSC deployer;
    DSCEngine dsce;
    DecentralizedStableCoin dsc;
    HelperConfig config;
    address weth;
    address wbtc;
    Handler handler;

    function setUp() external {
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        (,, weth, wbtc,) = config.activeNetworkConfig();
        // to set this contract as target contract.
        // for open testing
        // targetContract(address(dsce));

        // for invariant testing
        handler = new Handler(dsce, dsc);
        targetContract(address(handler));
    }

    // always use the invariant_ before the name of the test while writing invariant test.
    function invariant_protoclMustHaveMoreValueThanTotalSupply() public view {
        // get value of all the collateral in the protocol
        // compare it to all the debt

        // to get the total supply of dsc
        uint256 totalSupply = dsc.totalSupply();
        uint256 totalWethDeposited = IERC20(weth).balanceOf(address(dsce));
        uint256 totalBtcDeposited = IERC20(wbtc).balanceOf(address(dsce));

        uint256 wethValue = dsce.getUsdValue(weth, totalWethDeposited);
        uint256 wbtcValue = dsce.getUsdValue(wbtc, totalBtcDeposited);

        console.log("weth value", wethValue);
        console.log("wbtc value", wbtcValue);
        console.log("Total Supply:", totalSupply);
        console.log("Times Mint Called", handler.timesMintIsCalled());

        assert(wethValue + wbtcValue >= totalSupply);
    }

    function invariants_gettersShouldNotRevert() public view {
        dsce.getLiquidationBonus();
        dsce.getPrecision();
        // similarly put all getters here
    }
}
