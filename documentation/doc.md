https://dashboard.alchemy.com/
https://sepolia.etherscan.io/

To run deploy.js : npx hardhat run deploy.js --network hardhat

# FortyTwo42 Token

## Description

FortyTwo42 (FT42) est un token ERC-20 développé sur la blockchain Ethereum. 
Ce projet a pour but de créer un token respectant les contraintes de nommage imposées (incluant "42") 
et de fournir un exemple fonctionnel d'un contrat intelligent déployé sur un réseau de test.

## Choix Techniques

Blockchain : Ethereum (Testnet Sepolia)

Langage : Solidity 0.8.22

Framework de développement : Hardhat

Bibliothèques : OpenZeppelin (ERC-20, Ownable)

Déploiement : Réseau Sepolia via Hardhat

Explorateur de blockchain : Etherscan Sepolia

Service d'accès à Ethereum : Alchemy

## Installation et Déploiement

### Prérequis

Node.js et npm installés

Un compte sur Alchemy pour obtenir une clé API

Un portefeuille Ethereum avec des ETH de test sur Sepolia

### Étapes

Cloner le dépôt

git clone <repo_url>
cd <repo_directory>

Créer un fichier .env avec votre clé privée et l'URL RPC d'Alchemy :

RPC_URL=<votre_url_rpc>
PRIVATE_KEY=<votre_cle_privee>

Exécuter le script d'installation et de déploiement

chmod +x script.sh
./script.sh

## Sécurité

La clé privée ne doit jamais être exposée publiquement.

Les privilèges de propriété sont limités via OpenZeppelin Ownable.

Le contrat est optimisé pour limiter les gas fees.

Vérification du déploiement

Après le déploiement, vous pouvez voir votre contrat sur Sepolia Etherscan et interagir avec ses fonctions via l'interface publique.

Ce projet a été conçu à des fins éducatives et expérimentales uniquement. ⚡

