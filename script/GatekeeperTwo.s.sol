// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperTwo} from "../src/levels/GatekeeperTwo.sol";
import {GatekeeperTwoAttack} from "../src/attacks/GatekeeperTwoAttack.sol";

contract GatekeeperTwoScript is Script {
    GatekeeperTwo instance = GatekeeperTwo(payable(0x360b9ac0537824EB4cBDa52c5Ab9C8C7bbe4EAC3));
    GatekeeperTwoAttack attacker;

    function run() external {
	vm.startBroadcast();
	console.log("GatekeeperTwo Contract initial entrant:", instance.entrant());
	attacker = new GatekeeperTwoAttack(address(instance));
	console.log("GatekeeperTwoAttack Contract deployed to:", address(attacker));
	console.log("Attacking...");
	console.log("GatekeeperTwo Contract new entrant:", instance.entrant());
	vm.stopBroadcast();
    }
}
