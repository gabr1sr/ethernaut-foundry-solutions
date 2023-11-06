// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {MagicNumAttack} from "../src/attacks/MagicNumAttack.sol";
import {MagicNum} from "../src/levels/MagicNum.sol";

contract MagicNumScript is Script {
    MagicNum public instance = MagicNum(payable(0xc89d76182f3d2d56b09ADe4CB56586f0ebAB3C27));
    MagicNumAttack public solver;

    function run() external {
	vm.startBroadcast();
	solver = new MagicNumAttack();
	console.log("Solver Contract deployed to:", address(solver));
	console.log("Setting solver...");
	instance.setSolver(address(solver));
	console.log("MagicNum Contract solver:", address(solver));
	vm.stopBroadcast();
    }
}
