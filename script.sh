#!/bin/bash


# Vérifiez si .venv existe
if [ ! -d ".venv" ]; then
    echo "Environnement virtuel .venv non trouvé. Création en cours..."
    # Créer un environnement virtuel
    python3 -m venv .venv
    echo "Environnement virtuel créé dans le répertoire .venv."
else
    echo "Environnement virtuel .venv déjà existant."
fi

# Activer l'environnement virtuel
echo "Activation de l'environnement virtuel..."
source .venv/bin/activate

cd deployment

# Assurez-vous que Node.js et npm sont installés
if ! command -v npm &> /dev/null
then
    echo "npm non installé. Veuillez installer Node.js et npm."
    exit 1
fi

npm install

# Vérifiez si Hardhat est installé via npm, sinon installez-le
if ! npm list --depth=0 | grep hardhat; then
    echo "Hardhat non installé. Installation en cours..."
    npm install --save-dev hardhat
fi

# Assurez-vous que Hardhat est installé
if ! command -v npx &> /dev/null
then
    echo "Hardhat non installé. Installation en cours..."
    npm install --save-dev hardhat
fi

# Vérifier si .env existe pour les variables sensibles (comme la clé privée)
if [ ! -f .env ]; then
    echo ".env n'existe pas. Assurez-vous d'avoir un fichier .env avec votre clé privée."
    exit 1
fi

# Compiler le contrat avec Hardhat
echo "Compilation des contrats avec Hardhat..."
npx hardhat compile

# Si la compilation échoue, arrêter le script
if [ $? -ne 0 ]; then
    echo "Erreur lors de la compilation des contrats."
    exit 1
fi

# Déployer le contrat sur Sepolia
echo "Déploiement du contrat sur Sepolia..."

# Exécuter le script de déploiement
npx hardhat run ./deploy.js --network sepolia

# Vérifier si le déploiement a réussi
if [ $? -ne 0 ]; then
    echo "Erreur lors du déploiement du contrat."
    exit 1
fi

echo "Déploiement terminé avec succès!"
