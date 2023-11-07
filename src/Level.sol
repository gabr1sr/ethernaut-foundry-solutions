// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "openzeppelin-contracts-08/access/Ownable.sol";

abstract contract Level is Ownable {
    constructor() {}
    function createInstance(address _player) public payable virtual returns (address);
    function validateInstance(address payable _instance, address _player) public virtual returns (bool);
}
