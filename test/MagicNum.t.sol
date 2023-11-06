// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {MagicNumFactory} from "../src/factories/MagicNumFactory.sol";
import {MagicNum} from "../src/levels/MagicNum.sol";
import {MagicNumAttack} from "../src/attacks/MagicNumAttack.sol";

contract MagicNumTest is EthernautTest {
    function setUpLevel() public override {
	MagicNumFactory factory = new MagicNumFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveMagicNum() public {
	MagicNum instance = MagicNum(payable(levelAddress));
	MagicNumAttack solver = new MagicNumAttack();
	instance.setSolver(address(solver));
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
