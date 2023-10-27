// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {CoinFlipFactory} from "../src/factories/CoinFlipFactory.sol";
import {CoinFlipAttack} from "../src/attacks/CoinFlipAttack.sol";

contract CoinFlipTest is EthernautTest {
    function setUpLevel() public override {
	CoinFlipFactory factory = new CoinFlipFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveCoinFlip() public {
	CoinFlipAttack attacker = new CoinFlipAttack(levelAddress);
	for (uint256 i; i < 10; i++) {
	    vm.roll(block.number + 1);
	    attacker.attack();
	}
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
