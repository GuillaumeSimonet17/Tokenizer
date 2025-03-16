// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FortyTwo42 is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("FortyTwo42", "FT42")  Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }
}
