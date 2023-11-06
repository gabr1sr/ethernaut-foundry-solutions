// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautTest} from "./utils/EthernautTest.sol";
import {ElevatorFactory} from "../src/factories/ElevatorFactory.sol";
import {Elevator} from "../src/levels/Elevator.sol";
import {ElevatorAttack} from "../src/attacks/ElevatorAttack.sol";

contract ElevatorTest is EthernautTest {
    function setUpLevel() public override {
        ElevatorFactory factory = new ElevatorFactory();
        ethernaut.registerLevel(factory);
        levelAddress = ethernaut.createLevelInstance(factory);
    }

    function testSolveElevator() public {
        ElevatorAttack attacker = new ElevatorAttack();
        attacker.attack(levelAddress);
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}
