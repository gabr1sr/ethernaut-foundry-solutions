// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {console} from "forge-std/console.sol";
import {DexFactory} from "../src/factories/DexFactory.sol";
import {Dex, SwappableToken} from "../src/levels/Dex.sol";
import {DexAttack} from "../src/attacks/DexAttack.sol";

contract DexTest is EthernautTest {
    function setUpLevel() public override {
	DexFactory factory = new DexFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveDex() public {
	Dex instance = Dex(payable(levelAddress));
	SwappableToken token1 = SwappableToken(payable(instance.token1()));
	SwappableToken token2 = SwappableToken(payable(instance.token2()));
	DexAttack attacker = new DexAttack();

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
