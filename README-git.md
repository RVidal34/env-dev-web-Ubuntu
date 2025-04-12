# 🔧 Configuration Git - Guide pratique

Ce guide explique comment configurer Git pour un usage personnel ou professionnel, avec ou sans GitHub.

---

## 📚 Navigation rapide

- [🏠 Retour à l'accueil](README.md)
- [📘 LAMP (Apache + PHP)](README-lamp.md)
- [📗 Node.js & Express](README-node.md)
- [📕 Git](README-git.md)
- [📙 Switch Apache <-> Node](README-switching.md)

---

## 📋 Configuration initiale via le script

Le script `install-dev-romain-v3-git.sh` configure Git en te demandant :

- Ton nom d'utilisateur et ton email
- L’éditeur par défaut (`nano` ou `code`)
- Le comportement par défaut de `git push`
- Le cache des identifiants HTTPS

---

## 🔐 Utiliser SSH avec GitHub

### Pourquoi préférer SSH à HTTPS ?

- Pas besoin de taper ton mot de passe à chaque `push`
- Plus sécurisé et automatique une fois installé
- Tu peux générer une clé unique pour chaque machine

### Comment faire ?

```bash
ssh-keygen -t ed25519 -C "ton.email@example.com"
```

Valide toutes les options par défaut.

Puis copie ta clé publique vers GitHub :

```bash
cat ~/.ssh/id_ed25519.pub
```

Va sur [https://github.com/settings/keys](https://github.com/settings/keys), clique sur **New SSH key**, et colle la clé.

---

## 📂 Exemple de `.gitignore`

Un `.gitignore` permet d'exclure certains fichiers/dossiers du suivi Git :

```gitignore
# Fichiers système
.DS_Store
Thumbs.db

# Logs
*.log

# Dépendances
node_modules/
vendor/

# Environnements
.env
```

---

## 💻 Commandes Git essentielles

```bash
git init                # Initialise un dépôt Git
git status              # Vérifie les fichiers modifiés
git add .               # Ajoute tous les fichiers
git commit -m "Message" # Sauvegarde avec un message
git push origin main    # Envoie vers GitHub
```

---

## 🚀 Exemple de workflow Git (perso/pro)

1. `git init`
2. `git remote add origin <url>`
3. Travailler → `git add`, `git commit`
4. Pousser : `git push origin main`
5. Créer une branche : `git checkout -b feature-x`
6. Fusionner : `git merge feature-x` ou Pull Request sur GitHub

---

## 🧩 Ressources utiles

- [Doc Git officielle](https://git-scm.com/doc)
- [Générer une clé SSH GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
