// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
This pattern incorporates the ability to pause all function execution in the contract in
the case of something going wrong. Since contracts are immutable once deployed;
if there are bugs in the contract the pause functionality can be activated to prevent
further damage caused.
*/
contract MerchantBank {
    address payable public owner;
    bool paused = false;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier isPaused() {
        require(paused);
        _;
    }

    modifier notPaused() {
        require(!paused);
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    // Required for the contract to receive ETH
    receive() external payable {}

    function pauseContract() public onlyOwner notPaused {
        paused = true;
    }

    function unpauseContract() public onlyOwner isPaused {
        paused = false;
    }

    function depositEther() public notPaused {
        // logic to deposit ether into the contract
    }

    function emergencyWithdrawal() public isPaused {
        // transfer the ether out fast before more damage is done
        owner.transfer(address(this).balance);

        // (bool success,) = owner.call{value: address(this).balance}("");
        // require(success, "eth transfer failed");
    }
}
