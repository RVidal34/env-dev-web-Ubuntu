#!/bin/bash

echo "🔧 Installation d'un environnement de développement web full stack (config Romain)..."

# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Vérification du lien python → python3
if ! command -v python &> /dev/null; then
    echo "🔁 Création du lien symbolique python -> python3"
    sudo ln -s /usr/bin/python3 /usr/bin/python
else
    echo "✅ python est déjà disponible."
fi
if ! command -v python &> /dev/null; then
    echo "🔁 Création du lien symbolique python -> python3"
    sudo ln -s /usr/bin/python3 /usr/bin/python
fi

# Outils de base
sudo apt install -y   curl wget git unzip build-essential   zsh gnupg lsb-release ca-certificates apt-transport-https software-properties-common   fastfetch

# Terminal GNOME + Starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc
echo 'fastfetch' >> ~/.bashrc

# ZSH + Oh My Zsh
if ! command -v zsh &> /dev/null; then
    echo "❌ Zsh n’a pas été installé correctement."
else
    echo "✅ Zsh est installé."
    chsh -s $(which zsh)
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    echo 'fastfetch' >> ~/.zshrc
fi

# Configuration NVM dans bashrc et zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc

# Aliases
cat << 'EOF' >> ~/.bashrc

# 🔁 Alias personnalisés
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

# Structure des dossiers
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

# Node, NPM, Yarn, PNPM
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

# Installation de MongoDB 7 via dépôt officiel
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod

# MariaDB
sudo apt install -y mariadb-server
sudo mysql_secure_installation

# Info extensions GNOME
echo "💡 Pour gérer les extensions GNOME, utilise : https://extensions.gnome.org"

# Fin
echo ""
echo "✅ Installation terminée ! Redémarre ta session pour finaliser Zsh et Docker."
echo "✨ Bon dev Romain ! 🚀"
