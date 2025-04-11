#!/bin/bash
echo "🔁 Bascule vers Apache (port 8080)..."
echo "🛑 Arrêt des serveurs Node.js éventuels (sur 3000)..."
sudo fuser -k 3000/tcp 2>/dev/null
echo "🚀 Démarrage d'Apache..."
sudo systemctl start apache2
echo "✅ Apache est maintenant actif sur http://localhost:8080"
