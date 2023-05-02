// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// import "hardhat/console.sol";

contract Lock {
    uint256 public unlockTime;
    address payable public owner;

    event Withdrawal(uint256 amount, uint256 when);

    constructor(uint256 _unlockTime) payable {
        require(block.timestamp < _unlockTime, "Unlock time should be in the future");

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        // console.log("Unlock time: %o", unlockTime)
        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner") ;

        emit Withdrawal(address(this).balance, block.timestamp);
        // console.log("Balance %o:", address(this).balance);

        (bool success, ) = owner.call{ value: address(this).balance }("");
        require(success);
    }
}
