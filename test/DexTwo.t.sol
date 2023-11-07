// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {console} from "forge-std/console.sol";
import {DexTwoFactory} from "../src/factories/DexTwoFactory.sol";
import {DexTwo, SwappableTokenTwo} from "../src/levels/DexTwo.sol";
import {DexTwoAttack} from "../src/attacks/DexTwoAttack.sol";

contract DexTwoTest is EthernautTest {
    function setUpLevel() public override {
	DexTwoFactory factory = new DexTwoFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveDexTwo() public {
	DexTwo instance = DexTwo(payable(levelAddress));
	SwappableTokenTwo token1 = SwappableTokenTwo(payable(instance.token1()));
	SwappableTokenTwo token2 = SwappableTokenTwo(payable(instance.token2()));
	DexTwoAttack attacker = new DexTwoAttack();

	vm.startPrank(address(this));
	
	uint256 token1Balance = token1.balanceOf(address(this));
	uint256 token2Balance = token2.balanceOf(address(this));

	token1.transfer(address(attacker), token1Balance);
	token2.transfer(address(attacker), token2Balance);
	
	vm.stopPrank();

	attacker.attack(levelAddress);
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
