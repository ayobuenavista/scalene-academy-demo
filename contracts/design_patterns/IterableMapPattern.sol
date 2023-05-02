// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/*
The iterable map pattern allows you to iterate over mapping entries.
Solidity mapping provides no way to iterate over them.
There are some cases where you will need to iterate over a mapping.
*/
contract DepositContract {
    struct AccountDetails {
        address accountAddress;
        uint256 amount;
    }

    mapping(address => uint256) public balances;
    address[] public accountHolders;

    function deposit() public payable {
        require(msg.value > 0, "eth sent is 0");
        bool exists = balances[msg.sender] != 0;

        if (!exists) {
            accountHolders.push(msg.sender);
        }

        balances[msg.sender] += msg.value;
    }

    function getAccountHolders() public view returns (AccountDetails[] memory) {
        AccountDetails[] memory accounts = new AccountDetails[](accountHolders.length);

        for (uint256 i = 0; i < accounts.length; i++) {
            address _currentAddress = accountHolders[i];
            uint256 _amount = balances[_currentAddress];
            accounts[i] = AccountDetails(_currentAddress, _amount);
        }

        return accounts;
    }
}
