// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./ERC20.sol";
import "./Context.sol";

contract LLTmintable is Context, ERC20 {
    using SafeMath for uint256;
    
    constructor (string memory name_, string memory symbol_) ERC20(name_, symbol_) public { }
    
    function mint(uint256 amount) public virtual {
        _mint(_msgSender(), amount);
    }
    
    function mintFrom(address account, uint256 amount) public virtual {
        uint256 increaseAllowance = allowance(account, _msgSender()).add(amount);
        _approve(account, _msgSender(), increaseAllowance);
        _mint(account, amount);
    }
}