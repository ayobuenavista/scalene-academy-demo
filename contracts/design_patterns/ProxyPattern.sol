// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract MyProxy {
    address internal owner;
    address internal implementation;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function upgradeImplementation(address _newImplementation) public onlyOwner {
        implementation = _newImplementation;
    }

    fallback() external payable {
        address _impl = implementation;
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    receive() external payable {}
}


import "@openzeppelin/contracts/proxy/Proxy.sol";

contract BetterProxy is Proxy {
    address internal owner;
    address internal implementation;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function upgradeImplementation(address _newImplementation) public onlyOwner {
        implementation = _newImplementation;
    }

    function _implementation() internal view override returns (address) {
        return implementation;
    }
}

