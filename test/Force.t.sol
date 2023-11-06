// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {ForceFactory} from "../src/factories/ForceFactory.sol";
import {ForceAttack} from "../src/attacks/ForceAttack.sol";

contract ForceTest is EthernautTest {
    function setUpLevel() public override {
        ForceFactory factory = new ForceFactory();
        ethernaut.registerLevel(factory);
        levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveForce() public {
        ForceAttack attacker = new ForceAttack();
        attacker.attack{value: 1 wei}(payable(levelAddress));
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
