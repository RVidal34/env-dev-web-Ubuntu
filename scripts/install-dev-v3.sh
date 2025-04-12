#!/bin/bash
# (le reste du script original va ici jusqu'à la section Git)

# --- Configuration Git ---
echo "🔧 Configuration de Git :"

# Saisie du nom et email
read -p "💬 Ton nom d'utilisateur Git (ex: helix34) : " git_username
read -p "📧 Ton email Git (ex: helix34@proton.me) : " git_email

git config --global user.name "$git_username"
git config --global user.email "$git_email"

# Couleurs
git config --global color.ui auto

# Choix de l’éditeur
read -p "📝 Choisir l'éditeur Git (nano/code) : " git_editor
if [[ "$git_editor" == "code" ]]; then
  git config --global core.editor "code --wait"
else
  git config --global core.editor "nano"
fi

# push.default
echo "⚙️ Configurer le comportement du git push :"
select pushmode in "simple (recommandé)" "matching (toutes les branches)" "nothing"; do
  case $pushmode in
    "simple (recommandé)") git config --global push.default simple; break;;
    "matching (toutes les branches)") git config --global push.default matching; break;;
    "nothing") break;;
  esac
done

# cache identifiants
read -p "🔐 Activer le cache des identifiants (y/n) ? " enable_cache
if [[ "$enable_cache" == "y" || "$enable_cache" == "Y" ]]; then
  git config --global credential.helper "cache --timeout=3600"
  echo "⏳ Le cache des identifiants est activé pour 1h."
else
  echo "❌ Cache non activé. Tu entreras tes identifiants à chaque push si tu utilises HTTPS."
fi

# (suite du script original ici)
