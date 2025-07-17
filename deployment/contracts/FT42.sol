// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

// Librairie OpenZeppelin ERC20 permet d’utiliser toutes les fonctionnalités
// d’un token ERC-20 standard sans tout recoder (transfer, balanceOf, approve...)
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract FortyTwo42 is ERC20 {

    constructor(uint256 amount) ERC20("FortyTwo42", "FT42") {
        // Crée amount de tokens, et les envoie à l’adresse du déployeur du contrat.
        // Fonction héritée, retourne msg.sender, c’est-à-dire l’adresse de celui qui a appelé la fonction.
        _mint(_msgSender(), amount);
    }
}
