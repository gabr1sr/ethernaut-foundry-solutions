// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {TelephoneAttack} from "../../src/attacks/TelephoneAttack.sol";

contract TelephoneAttackScript is Script {
    address public telephoneAddress = 0x76dBBfdC31eC18BA43b41a4dEc531C7A41332fec;
    TelephoneAttack public attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new TelephoneAttack(telephoneAddress);
	console.log("TelephoneAttack Contract deployed to:", address(attacker));
	vm.stopBroadcast();
    }
}
