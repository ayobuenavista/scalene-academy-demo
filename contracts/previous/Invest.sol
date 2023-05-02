// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./Owner.sol";
import "./Token.sol";

contract Invest is Owner {
    address owner;
    Kandy knd;

    mapping(address => uint256) public investments;
    mapping(address => bool) internal _whitelisted;

    modifier onlyWhitelisted() {
        require(_whitelisted[msg.sender], "Not whitelisted");
        _;
    }

    constructor(address _knd) {
        owner = msg.sender;
        knd = Kandy(_knd);
    }

    // receive() external payable {}

    function invest() public payable returns (uint256 amount) {
        require(msg.value >= 1e18, "1 ETH minimum required");

        investments[msg.sender] += msg.value;

        amount = msg.value * 2;
        knd.transfer(msg.sender, amount);
    }

    function withdrawContribs(address payable _to) public {
        _to.transfer(address(this).balance);
    }

    function addToWhitelist(address _user) internal onlyOwner {
        _whitelisted[_user] = true;
    }

    function removeFromWhitelist(address _user) internal onlyOwner {
        _whitelisted[_user] = false;
    }

    function getTotalInvestment(address _user) public view returns (uint256) {
        return investments[_user];
    }

    function getContribs() public view returns (uint256) {
        return address(this).balance;
    }
}
