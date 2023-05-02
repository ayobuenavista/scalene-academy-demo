// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./Owner.sol";

interface Something {
    function test() external;
}

// The abstract keyword is used when a contract either contains functions
// that are non-implemented or if it inherits another abstract contract
// or interface and does not implement every one of its functions.
abstract contract Something2 {
    function toImplement() public virtual returns (uint256);
}

// Libraries can used to attach functions to other variables
// (like the self variable in Python)
// using SafeMath for uint256;
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
}

/**
 * @title Syntax
 * @author Scalene
 * @dev Demonstrates solidity syntax
 * @notice This is an example of NatSpec
 */
contract Syntax {
    event Increased(uint256 ctr);
    error ZeroValue(uint256 val);

    enum Faculty {
        CS,
        BUSINESS,
        ARTS
    }

    struct Student {
        string id;
        bool graduated;
        uint256 age;
        Faculty faculty;
    }

    address owner;
    uint256 ctr;

    // uint8 public u8 = 1;
    // uint public u256 = 456;
    // uint public u = 123; // uint is an alias for uint256
    // int8 public i8 = -1;
    // int public i256 = 456;
    // int public i = -123; // int is same as int256
    // address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    // bool public defaultBoo; // false
    // uint public defaultUint; // 0
    // int public defaultInt; // 0
    // address public defaultAddr; // 0x0000000000000000000000000000000000000000

    mapping(address => Student) public identity;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call");
        _;
    }

    /**
     * @dev Constructor that sets owner
     * @param _owner Owner of the contract
     */
    constructor(address _owner) {
        owner = _owner;
    }

    function increase(uint256 _x) public onlyOwner returns (uint256) {
        _check(_x);
        ctr += _x;

        emit Increased(ctr);
        return ctr;
    }

    function prevIncrease(uint256 _x) public view returns (uint256) {
        _check(_x);
        return ctr + _x;
    }

    function _check(uint256 _x) internal pure {
        require(_x > 0, "Error");
        if (_x <= 0) {
            revert ZeroValue(_x);
        }
    }

    // 1e18
    // wei
    // block.
    // msg.
}

// contract SendEther {
//     // Throws an error
//     function sendViaTransfer(address payable _to) public payable {
//         _to.transfer(msg.value);
//     }

//     // Send returns a boolean value indicating success or failure.
//     function sendViaSend(address payable _to) public payable {
//         bool sent = _to.send(msg.value);
//         require(sent, "Failed to send Ether");
//     }

//     function sendViaCall(address payable _to) public payable {
//         // Call returns a boolean value indicating success or failure.
//         // This is the current recommended method to use.
//         (bool sent, bytes memory data) = _to.call{value: msg.value}("");
//         require(sent, "Failed to send Ether");
//     }
// }
