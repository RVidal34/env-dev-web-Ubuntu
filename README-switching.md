# 🔄 Scripts de switch Apache <-> Node.js

[🏡 **ACCUEIL**](README.md)

---

## 📂 Objectif

Permettre de basculer rapidement entre :
- Un projet PHP (Apache)
- Un projet JS (Node.js)

---

## 🧰 Scripts disponibles

### ▶️ `switch-to-apache.sh`
- Stoppe les serveurs Node (sur 3000)
- Démarre Apache
- Apache écoute sur le port 8080

```bash
./switch-to-apache.sh
```

---

### ▶️ `switch-to-node.sh`
- Stoppe Apache
- Libère le port 3000 pour ton serveur Node.js (Vite, Express…)

```bash
./switch-to-node.sh
```

---

## 🧪 Exemple d’utilisation

1. Tu codes un site PHP → Apache actif
2. Tu veux tester un projet React → `./switch-to-node.sh`
3. Tu reviens sur Apache → `./switch-to-apache.sh`

---

## 💡 Astuce

Ajoute un alias dans ton `.bashrc` pour accéder vite :

```bash
alias apache='bash ~/scripts/switch-to-apache.sh'
alias node='bash ~/scripts/switch-to-node.sh'
```

---

## ⚠️ Attention

Ces scripts tuent les processus sur les ports 3000 ou 8080 directement.  
Ils sont faits pour du développement local uniquement.
