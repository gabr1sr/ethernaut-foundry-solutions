// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Instance} from "../src/levels/HelloEthernaut.sol";

contract HelloEthernautScript is Script {
    Instance public instance = Instance(payable(0x4Ed7480a70c9ad829F279d17785b9FAA7cD78F80));

    function run() external {
        vm.startBroadcast();
        string memory password = instance.password();
        console.log("The password is:", password);
        instance.authenticate(password);
        console.log("Cleared:", instance.getCleared());
        vm.stopBroadcast();
    }
}
