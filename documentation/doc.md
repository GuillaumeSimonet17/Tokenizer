# Explication des différentes tech et outils
### Alchemy:
Alchemy est une plateforme qui permet aux développeurs d’accéder facilement à la blockchain sans devoir gérer leur propre nœud Ethereum.
Dans le fichier hardhat.config.js (ligne sepolia).
Une App sur Alchemy est une instance de votre projet blockchain qui vous fournit des clés d’API et un endpoint RPC pour interagir avec la blockchain.
https://dashboard.alchemy.com/
Permet d'interagir avec le réseau Ethereum (Sepolia) sans devoir gérer ton propre nœud.


### Hardhat:
Hardhat est un framework qui permet de développer, tester et déployer des smart contracts.
Hardhat va utiliser l’URL RPC fournie par Alchemy (stockée dans .env) pour envoyer ses transactions.

### Endpoint RPC:
Un Remote Procedure Call (RPC) est une manière d’envoyer des requêtes à un serveur distant pour 
exécuter des commandes. Dans le contexte d’Ethereum, un endpoint RPC est une URL qui permet de communiquer 
avec un nœud Ethereum afin d’envoyer des transactions, lire des données ou exécuter des smart contracts.

Url RPC sur mon App Alchemy : https://eth-sepolia.g.alchemy.com/v2/MA_CLE_API

### Sepolia Etherscan :
https://sepolia.etherscan.io/
Est explorateur de blockchain pour le réseau de test Sepolia d’Ethereum. Il permet de visualiser tout ce qui se passe
sur la blockchain : transactions, smart contracts, adresses, blocs, etc.
#### Ce que tu peux voir sur Sepolia Etherscan :
🔹 Transactions → Vérifier l’état (succès, échec, en attente)\
🔹 Adresses Ethereum → Suivre le solde et l’historique d’une adresse\
🔹 Smart Contracts → Voir le code source et interagir avec les fonctions\
🔹 Blocs → Voir la confirmation des transactions par les mineurs

| Terme | Signification |
| --- | --- |
| **Gas** | Unité de **mesure de travail** effectué (comme du carburant pour exécuter du code Ethereum) |
| **Transaction Fee** | Ce que tu **paies en ETH** = `Gas utilisé × Prix du gas (gasPrice)` |

Exemple de ta transaction :

- **Gas utilisé** : 953,915
- **Gas price** : 1.5 Gwei
- **Fee payée** : ≈ 0.00143 ETH

Il **n’y a pas de nombre fixe de transactions par bloc**, mais une **limite en "gas total"** par bloc.

### 🔧 Sur Ethereum (et donc Sepolia) :

- **Chaque bloc a une limite de gas** : environ **30 millions** de gas
- **Chaque transaction consomme du gas**
- Donc :
    
    > Nombre de transactions = Gas total du bloc / Gas moyen par transaction
    >

`(.venv) ➜  deployment git:(main) ✗ npx hardhat run deploy.js --network sepolia
`
`Deploying contracts with the account: 0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`
`FortyTwo42 deployed to: 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAA`  
`Solde de l'adresse du propriétaire (deployer): 1000000.0 tokens
`\

**En déployant le contrat, le programme nous print deux adresses :** 
- l'adresse du compte avec laquelle le contract a été déployé\
- et et l'adresse du contrat

_Ici un exemple d'un compte :_
![img.png](img.png)
![Contract-Address-0x2706a38518b2753101c42fa619bb1b3a700f61ca-Etherscan-07-17-2025_04_36_PM.png](Contract-Address-0x2706a38518b2753101c42fa619bb1b3a700f61ca-Etherscan-07-17-2025_04_36_PM.png)
![FortyTwo42-FT42-Token-Tracker-Etherscan-07-17-2025_04_37_PM.png](FortyTwo42-FT42-Token-Tracker-Etherscan-07-17-2025_04_37_PM.png)
#### Cas concret : Déploiement d’un smart contract
Quand tu déploies un smart contract avec Hardhat et Alchemy, tu obtiens une adresse de contrat. 
Tu peux copier cette adresse et la rechercher sur Sepolia Etherscan pour voir :\
✅ Si le contrat a bien été déployé\
✅ Toutes les transactions qui l’ont concerné\
✅ Son code source (si vérifié)

#### Pourquoi c’est utile en testnet ?
Pour verifier si ton contrat fonctionne et intéragir avec lui

#### 💡 A savoir :
Si je déploie deux fois mon contrat, l'adresse sera différente, et les deux tokens n'auront pas de
liens entre eux.


En créant le contrat j'ai spécifié l'amount (1 million de FT42) et le receiver (l'adresse de mon compte). 
Donc en important sur metamask l'adresse du token, on peut constater que j'ai 1 million de token.


## Déployer sur la Mainnet
Le coût du déploiement sur Mainnet dépend de plusieurs facteurs, tels que la complexité du contrat intelligent 
(smart contract), la taille du code, et le prix du gas au moment du déploiement. Le coût est mesuré en gas, qui est 
une unité utilisée pour mesurer le travail nécessaire pour effectuer une opération sur la blockchain Ethereum.

Le prix du gas varie en fonction de la congestion du réseau et de la demande à ce moment-là. En général, le coût peut 
varier de quelques dollars à plusieurs centaines de dollars, selon la taille et la complexité du contrat.

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

Créer un fichier .env avec la clé privée et l'URL RPC d'Alchemy

Exécuter le script d'installation et de déploiement ./script.sh

## Sécurité

Les privilèges de propriété sont limités via OpenZeppelin Ownable.

Après le déploiement, on peut voir le contrat sur Sepolia Etherscan et interagir avec ses fonctions via Remix par exemple.

