# 🌩️ PantheonLab - Le Panthéon de l'Active Directory Vulnérable

<div align="center">
  <img alt="PantheonLab Logo" src="../PantheonLab/assets/pantheonlab.png" width="400" />
</div>

## 🏛️ Bienvenue dans l'Olympe de la Cybersécurité

PantheonLab est un laboratoire immersif et modulaire dédié à l'apprentissage de la sécurité Active Directory et des techniques de pentest, le tout dans un univers inspiré du **Panthéon grec** !

### 🎯 Objectif du Projet

Ce lab propose plusieurs environnements prêts à l'emploi, chacun incarnant une facette du Panthéon : chaque dieu ou déesse représente un scénario, une faille ou une technique d'attaque/défense Active Directory ou Linux. Le but est d'offrir un terrain de jeu réaliste, progressif et scénarisé pour :

- 🔍 **Passionnés de cybersécurité**
- 👨‍🏫 **Formateurs et enseignants**
- 🎓 **Étudiants en sécurité informatique**
- 💼 **Professionnels du domaine**

### 🌟 Caractéristiques Principales

!!! success "Fonctionnalités Clés"
    - **Environnement complet** : Windows Server + Linux + WordPress
    - **Thématique immersive** : Mythologie grecque intégrée
    - **Scénarios progressifs** : Du débutant au niveau avancé
    - **Documentation complète** : Guides détaillés et writeups
    - **Automatisation** : Déploiement via Ansible et Vagrant

### 🏗️ Architecture du Lab

Le lab comprend trois machines virtuelles principales :

| Machine | Rôle | IP | Description |
|---------|------|----|-------------|
| **Olympe** | Serveur Linux/WordPress | 192.168.56.10 | Point d'entrée principal avec WordPress vulnérable |
| **DC01** | Contrôleur de domaine | 192.168.56.11 | Active Directory principal |
| **Enfers** | Serveur membre | 192.168.56.12 | Machine Windows avec services vulnérables |

### 🚀 Démarrage Rapide

```bash
# Cloner le projet
git clone https://github.com/bbuddha/vulnad
cd vulnad/HCO_VulnAD/pantheon-lab

# Lancer l'environnement
vagrant up

# Déployer la configuration
ansible-playbook -i ansible/inventory/administrator_inventory.yml ansible/playbooks/windows_main.yml
```

### 📚 Navigation de la Documentation

Cette documentation est organisée en plusieurs sections :

- **[Présentation](presentation/overview.md)** : Vue d'ensemble du projet et de son architecture
- **[Installation](installation/prerequisites.md)** : Guide complet d'installation et de configuration
- **[Writeup](writeup/introduction.md)** : Solution détaillée du lab avec méthodologie
- **[Références](references/commands.md)** : Commandes utiles et ressources

### 🎭 Thématique Mythologique

Chaque aspect du lab est pensé pour renforcer l'immersion dans l'univers de la mythologie grecque :

- **Noms des machines** : Olympe, Enfers, DC01 (Zeus)
- **Utilisateurs** : Chaque dieu a son compte (Zeus, Héra, Hermès, etc.)
- **Scénarios** : Les vulnérabilités sont liées aux attributs des dieux
- **Visuels** : Images et thème cohérents avec la mythologie

### 🤝 Contribution

Nous accueillons les contributions ! Que vous souhaitiez :

- Proposer de nouveaux scénarios
- Améliorer la documentation
- Corriger des bugs
- Ajouter de nouvelles fonctionnalités

N'hésitez pas à consulter notre guide de contribution et à ouvrir des issues ou pull requests.

---

*Que la sagesse d'Athéna, la ruse d'Hermès et la puissance de Zeus t'accompagnent dans ta quête de la faille ultime !* ⚡ 