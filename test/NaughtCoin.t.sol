// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {NaughtCoinFactory} from "../src/factories/NaughtCoinFactory.sol";
import {NaughtCoin} from "../src/levels/NaughtCoin.sol";
import {NaughtCoinAttack} from "../src/attacks/NaughtCoinAttack.sol";

contract NaughtCoinTest is EthernautTest {
    function setUpLevel() public override {
        NaughtCoinFactory factory = new NaughtCoinFactory();
        ethernaut.registerLevel(factory);
        levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveNaughtCoin() public {
        NaughtCoin instance = NaughtCoin(payable(levelAddress));
        NaughtCoinAttack attacker = new NaughtCoinAttack();
        vm.startPrank(address(this));
        uint256 amount = instance.balanceOf(address(this));
        instance.approve(address(attacker), amount);
        attacker.attack(levelAddress);
        vm.stopPrank();
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
