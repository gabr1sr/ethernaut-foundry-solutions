// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {CoinFlipAttack} from "../src/attack/CoinFlipAttack.sol";

contract CoinFlipTest is Test {
    CoinFlipAttack public attacker = CoinFlipAttack(0xbd0178F65699E617BF1d45ae4b37df5F90c7123d);

    function setUp() public {
	vm.createSelectFork(vm.rpcUrl("sepolia"));
    }

    function testSolveCoinFlip() public {
	assert(attacker.attack());
    }
}
