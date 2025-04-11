#!/bin/bash
echo "🔁 Bascule vers Node.js (port 3000)..."
echo "🛑 Arrêt d'Apache (port 8080)..."
sudo systemctl stop apache2
echo "✅ Apache arrêté. Tu peux lancer ton serveur Node.js sur http://localhost:3000"
