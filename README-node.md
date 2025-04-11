# 🚀 Guide Node.js : Express & coexistence avec Apache


---

## 📚 Navigation rapide

- [🏠 Retour à l'accueil](README.md)
- [📘 LAMP (Apache + PHP)](README-lamp.md)
- [📗 Node.js & Express](README-node.md)
- [📙 Switch Apache <-> Node](README-switching.md)

---


---

## 📦 Installé avec le script principal

- Node.js via NVM (version LTS)
- npm, yarn, pnpm
- VS Code avec ESLint, Prettier, Tailwind

---

## 🎯 Dossiers pour projets JS

Crée tes projets dans :

```bash
~/Documents/dev/frontend/
~/Documents/dev/fullstack/
```

---

## 🧪 Lancer une app Node

```bash
npm install
npm run dev
```

Accessible par défaut sur :

```
http://localhost:3000
```

---

## ⚔️ Conflit de ports avec Apache ?

Apache écoute sur 8080 → pas de conflit.  
Mais si tu veux libérer les ports, utilise :

```bash
./switch-to-node.sh    # Stoppe Apache
./switch-to-apache.sh  # Relance Apache et coupe Node
```

---

## 🧱 Utiliser Apache et Node ensemble ?

Oui, chacun sur un port différent :
- Apache : `http://localhost:8080`
- Node.js : `http://localhost:3000`

Tu peux aussi configurer un reverse proxy avec Apache vers un serveur Node (ex : proxy vers port 3001)

---

## 🔍 À venir

- Support de proxy inversé Apache → Node
- Templates de projet (Express, API REST, Socket.io)

