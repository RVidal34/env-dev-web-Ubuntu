#!/bin/bash

echo "🔧 Installation complète de l’environnement de développement web fullstack (Romain + LAMP)..."

# Mise à jour système
sudo apt update && sudo apt upgrade -y

# Correction du lien python -> python3
if ! command -v python &> /dev/null; then
    echo "🔁 Création du lien symbolique python -> python3"
    sudo ln -s /usr/bin/python3 /usr/bin/python
else
    echo "✅ python est déjà disponible."
fi

# Outils système et dev
sudo apt install -y curl wget git unzip build-essential zsh gnupg lsb-release ca-certificates apt-transport-https software-properties-common fastfetch

# Starship (prompt) + Fastfetch (affichage)
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc
echo 'fastfetch' >> ~/.bashrc

# ZSH + Oh My Zsh
if command -v zsh &> /dev/null; then
  echo "✅ Zsh est installé."
  chsh -s $(which zsh)
  export RUNZSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
  echo 'fastfetch' >> ~/.zshrc
fi

# Aliases utiles
cat << 'EOF' >> ~/.bashrc
alias gb='gedit .bashrc'
alias al='alias'
alias as='apt-cache search'
alias vp='dpkg -l | grep'
alias pi='dpkg -l > ~/Bureau/paquets_installés.txt'
alias it='sudo apt update && sudo apt install'
alias ri='sudo apt update && sudo apt reinstall'
alias rv='sudo apt remove'
alias pu='sudo apt purge'
alias ul='apt list --upgradable'
alias up='sudo apt update && sudo apt upgrade'
alias ar='sudo apt autoremove'
alias ac='sudo apt autoclean'
alias ll='ls -lah --color=auto'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias dev='cd ~/Documents/dev'
alias c='clear'
alias restart-docker='sudo systemctl restart docker'
EOF

# Structure projets
mkdir -p ~/Documents/dev/{frontend,backend,fullstack,sandbox,templates}

# VS Code
sudo snap install code --classic
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension eamodio.gitlens
code --install-extension ritwickdey.LiveServer
code --install-extension pkief.material-icon-theme
code --install-extension christian-kohler.path-intellisense
code --install-extension bradlc.vscode-tailwindcss

# Node.js + NVM + PNPM/Yarn
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts
corepack enable
npm install -g pnpm

# Docker + Postman
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER
sudo snap install postman

# MongoDB 7
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod

# MariaDB
sudo apt install -y mariadb-server
sudo mysql_secure_installation

# Apache2 + PHP + modules
sudo apt install -y apache2
sudo sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
sudo sed -i 's/<VirtualHost *:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf
sudo systemctl restart apache2

sudo apt install -y software-properties-common ca-certificates lsb-release apt-transport-https
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y php php-cli php-common php-mysql php-curl php-mbstring php-xml php-zip php-gd libapache2-mod-php

# phpMyAdmin
sudo apt install -y phpmyadmin

# Test PHP : /var/www/html/index.php
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php > /dev/null

# Message final
echo ""
echo "✅ Installation complète terminée !"
echo "📁 Apache fonctionne sur : http://localhost:8080"
echo "🧰 PHPMyAdmin : http://localhost:8080/phpmyadmin"
echo "📄 Un index.php de test est dispo dans /var/www/html/"
echo "📦 Pour créer un projet LAMP : ./create-lamp-site.sh"
echo "🌍 Pour passer entre Apache et Node.js : ./switch-to-apache.sh / ./switch-to-node.sh"
