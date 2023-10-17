// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {Instance} from "../src/HelloEthernaut.sol";

contract HelloEthernautTest is Test {
    Instance public helloEthernaut = Instance(0x51b12ebF42043BaCd700ef81860Eb771B0f1c866);

    function setUp() external {
	vm.createSelectFork(vm.rpcUrl("sepolia"));
    }

    function testSolveChallenge() external {
        string memory password = helloEthernaut.password();
	helloEthernaut.authenticate(password);
	assert(helloEthernaut.getCleared());
    }
}
