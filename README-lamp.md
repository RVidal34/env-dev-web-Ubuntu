# 🔥 Guide LAMP : Apache, PHP, phpMyAdmin & MariaDB

Ce guide explique comment configurer configurer et utiliser le serveur LAMP.

---

## 📚 Navigation rapide

- [🏠 Retour à l'accueil](README.md)
- [📘 LAMP (Apache + PHP)](README-lamp.md)
- [📗 Node.js & Express](README-node.md)
- [📕 Git](README-git.md)
- [📙 Switch Apache <-> Node](README-switching.md)

---

---

## 📦 Installé avec le script principal

Le script `install-dev-v3-git.sh` installe :

- Apache2 (port 8080)
- PHP 8.x (via PPA `ondrej/php`)
- Modules PHP classiques : `php-mysql`, `php-curl`, `php-mbstring`, `php-xml`, `php-zip`, etc.
- phpMyAdmin (interface web de MariaDB)

---

## 🛠️ Créer un nouveau projet LAMP

Utilise le script :

```bash
./create-lamp-site.sh
```

Ce qu’il fait :

- Crée `/var/www/<projet>/public`
- Ajoute :
  - un `index.php` avec `phpinfo()`
  - un `.htaccess` avec sécurité basique et réécriture
  - un `.env` vide
- Crée un VirtualHost `*.conf`
- Ajoute `127.0.0.1 <projet>.local` à `/etc/hosts`
- Active le site et propose de désactiver les autres

---

## 🌍 Accéder à ton site

```bash
http://<projet>.local:8080
```

---

## 🔑 phpMyAdmin

```bash
http://localhost:8080/phpmyadmin
```

---

## 📁 Structure de projet générée

```
/var/www/<projet>/
├── public/
│   ├── index.php
│   ├── .htaccess
├── .env
```

---

## ⚙️ Gestion des VirtualHosts Apache

Activer un site :

```bash
sudo a2ensite projet.conf
sudo systemctl reload apache2
```

Désactiver un site :

```bash
sudo a2dissite projet.conf
sudo systemctl reload apache2
```

---

## 📓 Droits & sécurité

- Propriétaire : toi ($USER)
- Dossiers : `755` / Fichiers : `644`
- Apache lit, toi tu modifies
