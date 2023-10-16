// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {Instance} from "../src/HelloEthernaut.sol";

contract HelloEthernautScript is Script {
    Instance public helloEthernaut = Instance(0x51b12ebF42043BaCd700ef81860Eb771B0f1c866);

    function run() external {
	vm.startBroadcast();

	string memory password = helloEthernaut.password();
	helloEthernaut.authenticate(password);
	
	vm.stopBroadcast();
    }
}
