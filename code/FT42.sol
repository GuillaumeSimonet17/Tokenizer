// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract FortyTwo42 is ERC20, Ownable {

    constructor(uint256 amount) ERC20("FortyTwo42", "FT42") Ownable(msg.sender) {
        _mint(_msgSender(), amount);
    }

    // send FT42 to another account
    // this function already exist on Remix : legacy from OpenZeppelin's ERC20 contract
    function sendTokens(address receiver, uint256 amount) public {
        transfer(receiver, amount);
    }

    // to mint tokens after contract's creation (onlyOwner)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

}
