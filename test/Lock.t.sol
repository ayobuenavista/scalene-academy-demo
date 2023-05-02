// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../lib/forge-std/src/Test.sol";
import "../contracts/Lock.sol";

contract LockTest is Test {
    Lock public lock;

    function setUp() public {
        lock = new Lock(block.timestamp + 1);
    }

    function testWithdraw() public {
        emit log_uint(block.timestamp);
        vm.warp(block.timestamp + 100);
        emit log_uint(block.timestamp);

        emit log_uint(address(lock).balance);
        vm.deal(address(lock), 1e18);
        emit log_uint(address(lock).balance);

        lock.withdraw();
        assert(block.timestamp >= lock.unlockTime());
    }

    receive() payable external {}
}
