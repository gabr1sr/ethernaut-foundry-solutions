// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {DSTest} from "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {Ethernaut} from "../../src/Ethernaut-06.sol";

abstract contract DSEthernautTest is DSTest {
    Vm public vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut public ethernaut;
    address public levelAddress;

    function setUp() public {
	ethernaut = new Ethernaut();
	setUpLevel();
    }

    function setUpLevel() public virtual {}
}
