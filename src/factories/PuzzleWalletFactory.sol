// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Level} from "../Level.sol";
import {PuzzleWallet, PuzzleProxy} from "../levels/PuzzleWallet.sol";

contract PuzzleWalletFactory is Level {
    function createInstance(address) public payable override returns (address) {
	require(msg.value == 0.001 ether, "Must send 0.001 ETH to create instance");

	PuzzleWallet walletLogic = new PuzzleWallet();

	bytes memory data = abi.encodeWithSelector(PuzzleWallet.init.selector, 100 ether);
	PuzzleProxy proxy = new PuzzleProxy(address(this), address(walletLogic), data);
	PuzzleWallet instance = PuzzleWallet(address(proxy));

	instance.addToWhitelist(address(this));
	instance.deposit{value: msg.value}();

	return address(proxy);
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
	PuzzleProxy proxy = PuzzleProxy(_instance);
	return proxy.admin() == _player;
    }
}
