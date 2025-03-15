// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract FortyTwo42 is ERC20, Ownable {
    constructor(uint256 amount) ERC20("FortyTwo42", "FT42") Ownable(msg.sender) {
		_mint(_msgSender(), amount);
    }

    address lastPerson;
    uint balance;

    receive() external payable {
        lastPerson = msg.sender;
        balance = balance + msg.value;
    }

    function getLastPerson() public view returns(address) {
        return lastPerson;
    }

    function getBalance() public view returns(uint) {
        return balance;
    }

}
