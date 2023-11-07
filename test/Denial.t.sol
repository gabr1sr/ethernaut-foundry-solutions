// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {DenialFactory} from "../src/factories/DenialFactory.sol";
import {Denial} from "../src/levels/Denial.sol";
import {DenialAttack} from "../src/attacks/DenialAttack.sol";

contract DenialTest is EthernautTest {
    function setUpLevel() public override {
	DenialFactory factory = new DenialFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(factory);
    }

    function testSolveDenial() public {
	Denial instance = Denial(payable(levelAddress));
	DenialAttack attacker = new DenialAttack();
	instance.setWithdrawPartner(address(attacker));
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
