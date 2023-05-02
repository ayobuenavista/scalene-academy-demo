// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

/*
The withdrawal pattern is also referred to as a pull-over-push pattern.
This pattern allows cryptoassets to be removed from a contract by pull instead of push.
*/
contract TokenBank is Ownable {
    using SafeMath for uint256;

    address[] internal investors;
    mapping(address => uint256) internal balances;

    constructor() Ownable() {}

    // function saves an investor address on an array
    function registerInvestor(address _investor) public onlyOwner {
        require(_investor != address(0));
        investors.push(_investor);
    }

    // Bad practice
    function distributeDividends() public onlyOwner {
        for (uint256 i = 0; i < investors.length; i++) {
            uint256 amount = calulateDividendAccrued(investors[i]);
            //amount is what due to the investor
            balances[investors[i]] = 0;
            payable(investors[i]).transfer(amount); //pushing ether to address
        }
    }

    // Good practice
    function claimDividend() public {
        uint256 amount = calulateDividendAccrued(msg.sender);
        require(amount > 0, "No dividends to claim");
        // set their balance to zero to prevent reentrancy attack
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{ value: amount }("");
        require(sent, "Failed to send Ether");
    }

    function calulateDividendAccrued(address _investor) internal view returns (uint256 dividend) {
        //perform your calculations here and return the dividends
        dividend = balances[_investor].mul(22).div(1000); // 2.2% dividend
    }
}
