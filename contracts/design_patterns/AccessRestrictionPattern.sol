// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
This pattern as the name entails is one that is used when a restriction is necessary on the contract.
It consists of the use of modifiers to restrict access to some functions on a contract.
*/
contract LibraryManagementControl {
    address public owner;
    address[] public librarians;
    mapping(address => bool) public isLibrarian;

    modifier onlyLibarian() {
        require(isLibrarian[msg.sender], "Not librarian");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier authorized() {
        require(msg.sender == owner || isLibrarian[msg.sender], "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function appointLibarian(address _libAddress) public onlyOwner {
        librarians.push(_libAddress);
        isLibrarian[_libAddress] = true;
    }

    function removeLibrarian(uint256 _libIndex, address _libAddress) public onlyOwner {
        address lastElem = librarians[librarians.length - 1];
        librarians[_libIndex] = lastElem;
        librarians.pop();
        isLibrarian[_libAddress] = false;
    }

    function setUpLibary() public authorized {
        // code to set up a library
    }
}
