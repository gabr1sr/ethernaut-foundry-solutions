// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {GatekeeperOneFactory} from "../src/factories/GatekeeperOneFactory.sol";
import {GatekeeperOneAttack} from "../src/attacks/GatekeeperOneAttack.sol";

contract GatekeeperOneTest is EthernautTest {
    GatekeeperOneFactory public factory;

    function setUpLevel() public override {
        factory = new GatekeeperOneFactory();
        ethernaut.registerLevel(factory);
        levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveGatekeeperOne() public {
        GatekeeperOneAttack attacker = new GatekeeperOneAttack();
        attacker.attack(levelAddress);
        assert(factory.validateInstance(payable(levelAddress), tx.origin));
    }
}
