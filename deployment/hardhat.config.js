require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.22",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    sepolia: {
      url: process.env.RPC_URL, // URL de votre fournisseur, Alchemy ou Infura
      accounts: [process.env.PRIVATE_KEY], // Clé privée pour signer les transactions
    },
  },
};
