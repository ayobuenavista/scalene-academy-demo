// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Create2.sol";

/*
This pattern is used for the creation of a child contract from a parent that acts as a factory.
The factory contract has an array of addresses where all the child contracts created are stored.
*/
contract OToken is ERC20 {
    address public asset;
    address public collateral;
    address public strikePrice;
    uint256 public expiry;

    constructor(
        address _asset,
        address _collateral,
        uint256 _expiry,
        address _strikePrice,
        string memory _name,
        string memory _symbol
    ) ERC20(_name, _symbol) {
        asset = _asset;
        collateral = _collateral;
        strikePrice = _strikePrice;
        expiry = _expiry;
    }
}

contract OTokenFactory {
    address[] public otokenAddress;

    function createNewOToken(
        address _asset,
        address _collateral,
        address _strikePrice,
        uint256 _expiry,
        string memory _name,
        string memory _symbol
    ) public returns (address) {
        address otoken = address(
            new OToken(_asset, _collateral, _expiry, _strikePrice, _name, _symbol)
        );
        otokenAddress.push(otoken);
        return otoken;
    }

    function create2NewOToken(
        address _asset,
        address _collateral,
        address _strikePrice,
        uint256 _expiry,
        string memory _name,
        string memory _symbol
    ) public returns (address) {
        address otoken = Create2.deploy(
            0,
            bytes32(block.chainid),
            abi.encodePacked(
                type(OToken).creationCode,
                abi.encode(_asset, _collateral, _expiry, _strikePrice, _name, _symbol)
            )
        );
        otokenAddress.push(otoken);
        return otoken;
    }
}
