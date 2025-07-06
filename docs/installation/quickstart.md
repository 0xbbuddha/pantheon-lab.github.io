# Installation Rapide

## 🚀 Démarrage Express

Cette section vous guide à travers l'installation complète de PantheonLab en quelques étapes simples.

### Étape 1 : Clonage du Projet

```bash
# Cloner le dépôt principal
git clone https://github.com/0xbbuddha/pantheonlab
cd pantheonlab

# Naviguer vers le lab PantheonLab
cd HCO_VulnAD/pantheon-lab
```


### Étape 2 : Déploiement Automatique

!!! success "Méthode Recommandée"
    Utilisez le script de déploiement automatique pour une installation complète.

```bash
# Rendre le script exécutable
chmod +x pantheon.sh

# Lancer le déploiement complet
./pantheon.sh
```

Ce script effectue automatiquement :
- Destruction des VMs existantes
- Création des nouvelles VMs
- Configuration initiale
- Déploiement Ansible

### Étape 3 : Déploiement Manuel (Alternative)

Si vous préférez contrôler chaque étape :

```bash
# 1. Créer les machines virtuelles
vagrant up

# 2. Attendre que toutes les VMs soient prêtes
vagrant status

# 3. Déployer la configuration Windows
ansible-playbook -i ansible/inventory/administrator_inventory.yml ansible/playbooks/windows_main.yml

# 4. Déployer la configuration Linux
ansible-playbook -i ansible/inventory/linux_inventory.yml ansible/playbooks/linux_main.yml
```

## ⏱️ Temps d'Installation

## 🔍 Monitoring de l'Installation

### Suivi en Temps Réel

```bash
# Surveiller les VMs
vagrant status

# Voir les logs en temps réel
vagrant up --debug

# Surveiller les processus
watch -n 5 'ps aux | grep -E "(vagrant|vbox|ansible)"'
```


