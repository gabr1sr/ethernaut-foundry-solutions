// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {DSEthernautTest} from "./utils/DSEthernautTest.sol";
import {ReentranceFactory} from "../src/factories/ReentranceFactory.sol";
import {Reentrance} from "../src/levels/Reentrance.sol";
import {ReentranceAttack} from "../src/attacks/ReentranceAttack.sol";

contract ReentranceTest is DSEthernautTest {
    function setUpLevel() public override {
	ReentranceFactory factory = new ReentranceFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(factory);
    }

    function testSolveReentrance() public {
	Reentrance instance = Reentrance(payable(levelAddress));
	ReentranceAttack attacker = new ReentranceAttack(levelAddress);
	uint256 amount = 0.001 ether;
	vm.startPrank(address(this));
	instance.donate{value: amount}(address(attacker));
	attacker.attack(amount);
	vm.stopPrank();
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }

    receive() external payable {}
}
