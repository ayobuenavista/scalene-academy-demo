// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Kandy is IERC20 {
    uint256 public totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    string public name;
    string public symbol;
    uint256 public decimals = 18;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function balanceOf(address _addr) public view returns (uint256) {
        return _balances[_addr];
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(_balances[msg.sender] >= _amount, "Insufficient balance");
        _balances[msg.sender] -= _amount;
        _balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool) {
        _balances[_from] -= _amount;
        _balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function mint(uint256 _amount) public returns (uint256) {
        require(_amount > 0, "0 amount");
        _balances[msg.sender] += _amount;
        totalSupply += _amount;

        return _balances[msg.sender];
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return _allowances[_owner][_spender];
    }

    function approve(address _spender, uint256 _amount) public returns (bool) {
        require(_spender != address(0), "Spender zero address");

        _allowances[msg.sender][_spender] = _amount;

        return true;
    }
}
