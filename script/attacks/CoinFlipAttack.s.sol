// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlipAttack} from "../../src/attacks/CoinFlipAttack.sol";

contract CoinFlipAttackScript is Script {
    address public coinFlipAddress = 0x33b5d72a9F5A9F8E1E56c9E7Aa85B65B66cF44fC;
    CoinFlipAttack public attacker;

    function run() external {
	vm.startBroadcast();
	attacker = new CoinFlipAttack(coinFlipAddress);
	console.log("CoinFlipAttack Contract deployed to:", address(attacker));
	vm.stopBroadcast();
    }
}
