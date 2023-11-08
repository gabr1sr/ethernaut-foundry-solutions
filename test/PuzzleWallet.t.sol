// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {PuzzleWalletFactory} from "../src/factories/PuzzleWalletFactory.sol";
import {PuzzleWalletAttack} from "../src/attacks/PuzzleWalletAttack.sol";

contract PuzzleWalletTest is EthernautTest {
    function setUpLevel() public override {
	PuzzleWalletFactory factory = new PuzzleWalletFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(factory);
    }

    function testSolvePuzzleWallet() public {
	PuzzleWalletAttack attacker = new PuzzleWalletAttack();
	vm.startPrank(address(this));
	attacker.attack{value: 0.001 ether}(payable(levelAddress));
	vm.stopPrank();
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
