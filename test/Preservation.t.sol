// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {PreservationFactory} from "../src/factories/PreservationFactory.sol";
import {PreservationAttack} from "../src/attacks/PreservationAttack.sol";

contract PreservationTest is EthernautTest {
    function setUpLevel() public override {
	PreservationFactory factory = new PreservationFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolvePreservation() public {
	vm.startPrank(address(this));
	PreservationAttack attacker = new PreservationAttack();
	attacker.attack(levelAddress);
	vm.stopPrank();
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
