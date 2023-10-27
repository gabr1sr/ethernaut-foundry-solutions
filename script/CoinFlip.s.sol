// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlipAttack} from "../src/attack/CoinFlipAttack.sol";

contract CoinFlipScript is Script {
    CoinFlipAttack public attacker = CoinFlipAttack(0xbd0178F65699E617BF1d45ae4b37df5F90c7123d);

    function run() external {
	vm.startBroadcast();

	attacker.attack();

	console.log("Consecutive wins:", attacker.consecutiveWins());

	vm.stopBroadcast();
    }
}
