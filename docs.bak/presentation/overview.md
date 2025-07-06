# Vue d'ensemble du Projet

## 🎯 Qu'est-ce que PantheonLab ?

PantheonLab est un **laboratoire de sécurité informatique** conçu pour l'apprentissage pratique des techniques de pentest et de sécurité Active Directory. Contrairement aux labs traditionnels, PantheonLab se distingue par son approche **thématique et immersive** basée sur la mythologie grecque.

### 🏛️ Concept Unique

Le projet transforme l'apprentissage de la cybersécurité en une **quête épique** où chaque défi représente un dieu ou une déesse du Panthéon grec. Cette approche rend l'apprentissage plus engageant et mémorable.

## 🌟 Objectifs Pédagogiques

### Compétences Techniques Visées

!!! info "Compétences Active Directory"
    - **Énumération**
    - **Attaques Windows**
    - **Escalade de privilèges**
    - **Mouvement latéral** 

!!! info "Compétences Linux/Web"
    - **Énumération web**
    - **Exploitation** 
    - **Escalade de privilèges** 


## 🏗️ Architecture Technique

### Environnement Virtualisé

PantheonLab utilise **Vagrant** et **VirtualBox** pour créer un environnement isolé et reproductible :

```yaml
Machines Virtuelles:
  - Olympe (Ubuntu 18.04):
    - IP: 192.168.56.10
    - Rôle: Serveur web WordPress
    - Mémoire: 2GB RAM, 2 CPU
    
  - DC01 (Windows Server 2025):
    - IP: 192.168.56.11
    - Rôle: Contrôleur de domaine
    - Mémoire: 4GB RAM, 2 CPU
    
  - Enfers (Windows Server 2025):
    - IP: 192.168.56.12
    - Rôle: Serveur membre
    - Mémoire: 4GB RAM, 2 CPU
```

### Automatisation avec Ansible

Le déploiement et la configuration sont entièrement automatisés via **Ansible** :

- **Playbooks Windows** : Configuration Active Directory, utilisateurs, politiques
- **Playbooks Linux** : Installation WordPress, configuration Apache/MySQL
- **Variables personnalisables** : Adaptation facile aux besoins spécifiques

## 🎭 Thématique Mythologique
### Immersion Narrative

Chaque machine et utilisateur suit la thématique :

- **Noms de domaine** : `pantheon.god`, `olympe.god`
- **Utilisateurs** : `zeus`, `hera`, `hermes`, etc.
- **Indices** : Liés aux légendes grecques

## 🔧 Technologies Utilisées

### Infrastructure

- **Vagrant** : Orchestration des VMs
- **VirtualBox** : Hyperviseur
- **Ansible** : Configuration automatique
- **Windows Server 2025** : Active Directory
- **Ubuntu 18.04** : Serveur web

## 🎯 Public Cible

### Formateurs et Enseignants

- **Cours de sécurité informatique**
- **Formations professionnelles**
- **Ateliers pratiques**
- **Évaluations de compétences**

### Étudiants et Apprenants

- **Étudiants en cybersécurité**
- **Préparation aux certifications** (OSCP, CEH, etc.)
- **Projets personnels**
- **Hackathons et CTF**

### Professionnels

- **Pentesteurs débutants**
- **Analystes SOC**
- **Administrateurs système**
- **Consultants en sécurité**

## 🚀 Avantages du Projet

### Pour l'Apprentissage

- **Environnement réaliste** : Reproduction fidèle d'un réseau d'entreprise
- **Progression structurée** : Du simple au complexe
- **Feedback immédiat** : Résolution guidée des défis
- **Ressources complètes** : Documentation et writeups détaillés

### Pour l'Enseignement

- **Facilité de déploiement** : Une commande pour tout installer
- **Personnalisation** : Adaptation aux besoins spécifiques
- **Réutilisabilité** : Environnement reproductible
- **Support communautaire** : Documentation collaborative

---

*Avec PantheonLab venez rencontrer les dieux de l'Olympe et détronez Zeus !* ⚡ 
