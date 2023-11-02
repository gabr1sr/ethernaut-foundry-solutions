// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {GatekeeperTwoFactory} from "../src/factories/GatekeeperTwoFactory.sol";
import {GatekeeperTwoAttack} from "../src/attacks/GatekeeperTwoAttack.sol";

contract GatekeeperTwoTest is EthernautTest {
    GatekeeperTwoFactory public factory;

    function setUpLevel() public override {
	factory = new GatekeeperTwoFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveGatekeeperTwo() public {
	new GatekeeperTwoAttack(levelAddress);
	assert(factory.validateInstance(payable(levelAddress), tx.origin));
    }
}
