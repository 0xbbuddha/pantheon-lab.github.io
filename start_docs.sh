#!/bin/bash

echo "=== Démarrage de la Documentation PantheonLab ==="

# Vérifier si MkDocs est installé
if ! command -v mkdocs &> /dev/null; then
    echo "❌ MkDocs n'est pas installé."
    echo "Installation via pip..."
    pip install mkdocs mkdocs-material --break-system-packages
fi

# Générer le site complet
echo "🔨 Génération du site..."
echo "📁 Création du répertoire site/..."
mkdocs build --clean

# Vérifier si la génération a réussi
if [ $? -eq 0 ]; then
    echo "✅ Site généré avec succès dans le répertoire site/"
else
    echo "❌ Erreur lors de la génération du site"
    exit 1
fi

# Démarrer le serveur de documentation
echo "🚀 Démarrage du serveur de documentation..."
echo "📖 Documentation accessible sur : http://localhost:8000"
echo "🛑 Pour arrêter : Ctrl+C"
echo ""

mkdocs serve --dev-addr=0.0.0.0:8000
