#!/bin/bash

echo "=== Démarrage de la Documentation PantheonLab ==="

# Vérifier si MkDocs est installé
if ! command -v mkdocs &> /dev/null; then
    echo "❌ MkDocs n'est pas installé."
    echo "Installation via pip..."
    pip install mkdocs mkdocs-material --break-system-packages
fi

# Démarrer le serveur de documentation
echo "🚀 Démarrage du serveur de documentation..."
echo "📖 Documentation accessible sur : http://localhost:8000"
echo "🛑 Pour arrêter : Ctrl+C"
echo ""

mkdocs serve --dev-addr=0.0.0.0:8000 