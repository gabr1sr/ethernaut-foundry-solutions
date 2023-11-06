// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {TelephoneFactory} from "../src/factories/TelephoneFactory.sol";
import {TelephoneAttack} from "../src/attacks/TelephoneAttack.sol";

contract TelephoneTest is EthernautTest {
    function setUpLevel() public override {
        TelephoneFactory factory = new TelephoneFactory();
        ethernaut.registerLevel(factory);
        levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveTelephone() public {
        TelephoneAttack attacker = new TelephoneAttack(levelAddress);
        attacker.attack();
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
