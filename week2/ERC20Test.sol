pragma solidity ^0.4.24;

import "./ERC20.sol";

contract ERC20Test is ERC20 {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    /**
    * @dev Function that mints an amount of the token and assigns it to
    * an account. This encapsulates the modification of balances such that the
    * proper events are emitted.
    * @param account The account that will receive the created tokens.
    * @param amount The amount that will be created.
    */
    function mint(address account, uint256 amount) public {
        require(msg.sender == owner);
        require(account != 0);
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

}