// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {KingFactory} from "../src/factories/KingFactory.sol";
import {King} from "../src/levels/King.sol";
import {KingAttack} from "../src/attacks/KingAttack.sol";

contract KingTest is EthernautTest {
    function setUpLevel() public override {
	KingFactory factory = new KingFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(factory);
    }

    function testSolveKing() public {
	King instance = King(payable(levelAddress));
	KingAttack attacker = new KingAttack();
	uint256 prize = instance.prize();
	vm.startPrank(address(this));
        bool success = attacker.attack{value: prize + 1 wei}(levelAddress);
	assert(success);
	vm.stopPrank();
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }

    receive() external payable {}
}
