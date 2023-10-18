// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {DSTest} from "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutTest is DSTest {
    Fallout public falloutContract = Fallout(payable(0xaD3f8D5E20A323067b3f746F4987b51037fB59e7));

    function setUp() external {
	Vm vm = (Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D)));
	vm.createSelectFork(vm.rpcUrl("sepolia"));
    }

    function testFalloutChallenge() external {
	falloutContract.Fal1out();
    }
}
