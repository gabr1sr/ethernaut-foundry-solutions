// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {ShopFactory} from "../src/factories/ShopFactory.sol";
import {ShopAttack} from "../src/attacks/ShopAttack.sol";

contract ShopTest is EthernautTest {
    function setUpLevel() public override {
	ShopFactory factory = new ShopFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveShop() public {
	ShopAttack attacker = new ShopAttack();
	attacker.attack(levelAddress);
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
