#!/bin/bash

echo "🔧 Installation d'un environnement de développement web full stack (config Romain)..."

# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Outils de base
sudo apt install -y \
  curl wget git unzip build-essential \
  zsh gnupg lsb-release ca-certificates apt-transport-https software-properties-common \
  fastfetch

# Terminal GNOME + Starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc
echo 'fastfetch' >> ~/.bashrc

# ZSH + Oh My Zsh
if ! command -v zsh &> /dev/null; then
    echo "❌ Zsh n’a pas été installé correctement."
else
    echo "✅ Zsh est installé."

    # Définir Zsh comme shell par défaut
    chsh -s $(which zsh)

    # Installer Oh My Zsh
    echo "🎩 Installation de Oh My Zsh..."
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Prompt Starship et Fastfetch pour Zsh
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    echo 'fastfetch' >> ~/.zshrc
fi

# Configuration NVM dans bashrc et zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc

# Aliases utiles
cat << 'EOF' >> ~/.bashrc

# 🔁 Alias personnalisés
# Gestion des alias
alias gb='gedit .bashrc' # Edite le fichier ~/.bashrc
alias al='alias' # Affiche les alias enregistrés

# Recherche de paquets
alias as='apt-cache search' # Recherche un paquet dans les dépôts
alias vp='dpkg -l | grep' # Vérifie si un paquet est installé
alias pi='dpkg -l > ~/Bureau/paquets_installés.txt' # Liste des paquets installés

# Installation et suppression de paquets
alias it='sudo apt update && sudo apt install'
alias ri='sudo apt update && sudo apt reinstall'
alias rv='sudo apt remove'
alias pu='sudo apt purge'

# Mise à jour et nettoyage
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

# Structure de dossiers
mkdir -p ~/Documents/dev/{frontend,backend,fullstack,sandbox,templates}

# VS Code
echo "📦 Installation de VS Code..."
sudo snap install code --classic

# Extensions VS Code recommandées
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension eamodio.gitlens
code --install-extension ritwickdey.LiveServer
code --install-extension pkief.material-icon-theme
code --install-extension christian-kohler.path-intellisense
code --install-extension bradlc.vscode-tailwindcss

# Node.js, npm, yarn, pnpm via NVM
echo "📦 Installation de Node.js via NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts

# Installer Yarn et PNPM globalement
corepack enable
npm install -g pnpm

# Docker + Postman
echo "🐳 Installation de Docker et Postman..."
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER
sudo snap install postman

# MongoDB
echo "🍃 Installation de MongoDB..."
sudo apt install -y mongodb
sudo systemctl enable mongodb
sudo systemctl start mongodb

# MariaDB
echo "🗃 Installation de MariaDB..."
sudo apt install -y mariadb-server
sudo mysql_secure_installation

# GNOME Shell extensions (installées via navigateur)
echo "💡 N'oublie pas d'installer l'intégration GNOME Shell si tu veux gérer tes extensions graphiquement :"
echo "👉 https://extensions.gnome.org"

# Fin
echo ""
echo "✅ Installation terminée ! Redémarre ta session pour finaliser Zsh et Docker."
echo "✨ Bon dev Romain ! Tu peux coder en toute tranquillité maintenant 😎"
