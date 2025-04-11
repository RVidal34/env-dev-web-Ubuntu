#!/bin/bash

echo "📦 Création d'un nouveau projet LAMP..."

# Demander le nom du projet
read -p "🔤 Nom du projet (ex: monsite) : " PROJECT
FOLDER="/var/www/$PROJECT"
PUBLIC="$FOLDER/public"

# Vérifier s'il existe déjà
if [ -d "$FOLDER" ]; then
    echo "⚠️ Le dossier $FOLDER existe déjà. Abandon."
    exit 1
fi

# Créer les dossiers
sudo mkdir -p "$PUBLIC"
sudo chown -R $USER:$USER "$FOLDER"
sudo chmod -R 755 "$FOLDER"

# Fichier index.php
echo "<?php phpinfo(); ?>" | sudo tee "$PUBLIC/index.php" > /dev/null

# .htaccess de base
cat << 'EOF' | sudo tee "$PUBLIC/.htaccess" > /dev/null
Options -Indexes
RewriteEngine On
DirectoryIndex index.php
EOF

# .env vide
touch "$FOLDER/.env"

# Création du VirtualHost
VHOST_PATH="/etc/apache2/sites-available/$PROJECT.conf"

cat << EOF | sudo tee "$VHOST_PATH" > /dev/null
<VirtualHost *:8080>
    ServerName $PROJECT.local
    DocumentRoot $PUBLIC
    <Directory $PUBLIC>
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/$PROJECT-error.log
    CustomLog \${APACHE_LOG_DIR}/$PROJECT-access.log combined
</VirtualHost>
EOF

# Ajout dans /etc/hosts
echo "127.0.0.1 $PROJECT.local" | sudo tee -a /etc/hosts > /dev/null

# Activer le site et proposer de désactiver les autres
sudo a2ensite "$PROJECT.conf"
echo ""
read -p "❓ Désactiver les autres sites Apache actifs ? (y/n) : " DISABLE
if [[ "$DISABLE" == "y" || "$DISABLE" == "Y" ]]; then
    for site in $(ls /etc/apache2/sites-enabled/*.conf); do
        base=$(basename "$site")
        if [[ "$base" != "$PROJECT.conf" ]]; then
            sudo a2dissite "$base"
        fi
    done
fi

# Redémarrer Apache
sudo systemctl reload apache2

echo ""
echo "✅ Projet LAMP '$PROJECT' prêt !"
echo "🌍 Accède à : http://$PROJECT.local:8080"
echo "📂 Emplacement : $PUBLIC"
