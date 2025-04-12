# 🚀 Environnement de développement Web complet - Setup Romain

Ce projet fournit un ensemble de scripts pour mettre en place un environnement de développement web sous Ubuntu.

---

## 📚 Navigation rapide

- [🏠 Retour à l'accueil](README.md)
- [📘 LAMP (Apache + PHP)](README-lamp.md)
- [📗 Node.js & Express](README-node.md)
- [📕 Git](README-git.md)
- [📙 Switch Apache <-> Node](README-switching.md)

---

## 📄 Contenu principal

### ⚙️ Script d'installation global

- `install-dev-romain-v3-lamp.sh` → installe automatiquement :
  - Node.js, NVM, pnpm, yarn
  - MongoDB, MariaDB, Docker, Postman
  - PHP (latest), Apache2 (port 8080), phpMyAdmin
  - VS Code avec extensions web utiles
  - Zsh, Oh My Zsh, Starship, Fastfetch
  - Structure de dossiers projets frontend/backend

### 🔧 Création de projets LAMP (PHP + Apache)

- `create-lamp-site.sh`
  - Crée un projet dans `/var/www/<projet>/public`
  - Ajoute un `.htaccess` et un `index.php`
  - Gère le vhost Apache automatiquement
  - Ajoute l’URL `<projet>.local` dans `/etc/hosts`
  - Te propose de désactiver les autres sites

### 🚨 Switch entre Apache et Node.js

- `switch-to-apache.sh`
  - Stoppe Node (port 3000) et relance Apache (port 8080)
- `switch-to-node.sh`
  - Stoppe Apache pour libérer le port 3000

## 📥 Installation des scripts

### 📁 Fichiers individuels

Tu peux télécharger chaque script séparément (install, create, switch...), les rendre exécutables et lancer l'installation principale :

```bash
chmod +x install-dev-romain-v3-lamp.sh
chmod +x create-lamp-site.sh
chmod +x switch-to-apache.sh
chmod +x switch-to-node.sh
./install-dev-romain-v3-lamp.sh
```

Ensuite tu pourras créer des projets LAMP avec :

```bash
./create-lamp-site.sh
```

Et basculer entre Apache et Node.js :

```bash
./switch-to-apache.sh
./switch-to-node.sh
```

### 📦 Installation via archive `.zip`

1. [Télécharge l'archive ZIP](https://ton-lien-vers/env-dev-romain.zip)
2. Extrais-la dans un dossier comme `~/env-dev-romain`
3. Ouvre un terminal et exécute :

```bash
cd ~/env-dev-romain
chmod +x *.sh
./install-dev-romain-v3-lamp.sh
```

---

---

## 📁 Structure de dossiers recommandée

```bash
~/Documents/dev/
├── frontend/
├── backend/
├── fullstack/
├── sandbox/
├── templates/
```

Les projets LAMP se trouvent dans `/var/www/<projet>/public`

---

## 🔗 Documentation complémentaire

- [README LAMP](README-lamp.md) : Apache2, PHP, vhosts, phpMyAdmin
- [README NODE](README-node.md) : Node.js, Express, cohabitation avec Apache
- [README SWITCHING](README-switching.md) : Comment changer de stack proprement

---

## 🌐 Accès rapide (par défaut)

| Service          | URL                              |
| ---------------- | -------------------------------- |
| Apache (default) | http://localhost:8080            |
| phpMyAdmin       | http://localhost:8080/phpmyadmin |
| Node.js app      | http://localhost:3000            |
| Projet LAMP      | http://nom-du-projet.local:8080  |

---

## 💡 Conseils

- Utilise `create-lamp-site.sh` pour tes projets PHP proprement
- Apache écoute sur le port 8080 pour éviter les conflits avec Node
- Node.js reste libre d’utiliser le port 3000 ou d’autres (Vite, Next.js...)
- Tu peux désactiver temporairement Apache ou Node selon le besoin avec les scripts de switch

---

## 🌟 Auteur : Romain

> Setup conçu pour les devs web, que ce soit pour du test, de la prod légère ou du freelance !
