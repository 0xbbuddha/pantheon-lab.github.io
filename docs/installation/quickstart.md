# Installation Rapide

## 🚀 Démarrage Express

Cette section vous guide à travers l'installation complète de PantheonLab en quelques étapes simples.

### Étape 1 : Clonage du Projet

```bash
# Cloner le dépôt principal
git clone https://github.com/bbuddha/vulnad
cd vulnad

# Naviguer vers le lab PantheonLab
cd HCO_VulnAD/pantheon-lab

# Vérifier la structure
ls -la
```

### Étape 2 : Vérification des Prérequis

```bash
# Vérifier que tous les outils sont installés
which vagrant vboxmanage ansible python3

# Vérifier les versions
vagrant --version
vboxmanage --version
ansible --version
python3 --version
```

### Étape 3 : Déploiement Automatique

!!! success "Méthode Recommandée"
    Utilisez le script de déploiement automatique pour une installation complète.

```bash
# Rendre le script exécutable
chmod +x dc.sh

# Lancer le déploiement complet
./dc.sh
```

Ce script effectue automatiquement :
- Destruction des VMs existantes
- Création des nouvelles VMs
- Configuration initiale
- Déploiement Ansible

### Étape 4 : Déploiement Manuel (Alternative)

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

### Estimations par Composant

| Composant | Temps Estimé | Dépendances |
|-----------|--------------|-------------|
| **Téléchargement des boxes** | 30-60 min | Connexion Internet |
| **Création des VMs** | 15-30 min | Performance système |
| **Configuration Windows** | 45-90 min | Services AD |
| **Configuration Linux** | 10-20 min | Services web |
| **Tests de validation** | 5-10 min | Vérifications |

!!! info "Temps Total"
    **2-3 heures** pour une installation complète selon votre connexion et la performance de votre machine.

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

### Logs Importants

```bash
# Logs Vagrant
tail -f ~/.vagrant.d/logs/vagrant.log

# Logs Ansible
tail -f /var/log/ansible.log

# Logs VirtualBox
tail -f ~/.VirtualBox/VBoxSVC.log
```

## ✅ Validation de l'Installation

### Test de Connectivité

```bash
# Test des machines
ping -c 3 192.168.56.10  # Olympe
ping -c 3 192.168.56.11  # DC01
ping -c 3 192.168.56.12  # Enfers

# Test des services web
curl -I http://192.168.56.10
curl -I http://pantheon.god
```

### Test des Services

```bash
# Test SSH (Olympe)
ssh vagrant@192.168.56.10

# Test RDP (Windows)
# Utiliser un client RDP vers 192.168.56.11:3389

# Test WinRM (Windows)
ansible -m win_ping -i ansible/inventory/administrator_inventory.yml all
```

### Vérification WordPress

```bash
# Test du site web
curl http://192.168.56.10

# Vérification des plugins
wpscan --url http://192.168.56.10 --plugins-detection aggressive
```

## 🎯 Configuration Post-Installation

### Configuration DNS Local

Ajoutez les entrées DNS dans votre fichier `/etc/hosts` :

```bash
# Éditer le fichier hosts
sudo nano /etc/hosts

# Ajouter les entrées
192.168.56.10 pantheon.god olympe.god
192.168.56.11 dc01.pantheon.god
192.168.56.12 enfers.pantheon.god
```

### Configuration Machine d'Attaque

```bash
# Installation d'outils de pentest
sudo apt update
sudo apt install nmap wpscan gobuster dirb nikto

# Outils Python
pip3 install requests beautifulsoup4 lxml

# Outils Windows (si sur Windows)
# Installer Windows Terminal, PowerShell 7
```

## 🚨 Résolution de Problèmes Courants

### Problème : VMs ne démarrent pas

```bash
# Vérifier l'espace disque
df -h

# Vérifier la mémoire
free -h

# Redémarrer VirtualBox
sudo systemctl restart vboxdrv
```

### Problème : Ansible échoue

```bash
# Vérifier la connectivité WinRM
ansible -m win_ping -i ansible/inventory/administrator_inventory.yml all

# Vérifier les credentials
cat ansible/inventory/administrator_inventory.yml

# Réessayer avec verbose
ansible-playbook -i ansible/inventory/administrator_inventory.yml ansible/playbooks/windows_main.yml -vvv
```

### Problème : WordPress inaccessible

```bash
# Vérifier le service Apache
vagrant ssh olympe-wordpress
sudo systemctl status apache2

# Vérifier les logs
sudo tail -f /var/log/apache2/error.log
```

## 📊 État Final Attendu

### Machines Fonctionnelles

| Machine | IP | Services | Statut |
|---------|----|----------|--------|
| **Olympe** | 192.168.56.10 | Apache, MySQL, WordPress | ✅ Opérationnel |
| **DC01** | 192.168.56.11 | AD, DNS, DHCP | ✅ Opérationnel |
| **Enfers** | 192.168.56.12 | File Services, IIS | ✅ Opérationnel |

### Services Accessibles

```bash
# Test complet des services
echo "=== Test des Services ==="

echo "1. Test WordPress..."
curl -s -o /dev/null -w "%{http_code}" http://192.168.56.10

echo "2. Test RDP DC01..."
nc -z 192.168.56.11 3389 && echo "OK" || echo "FAIL"

echo "3. Test WinRM..."
ansible -m win_ping -i ansible/inventory/administrator_inventory.yml all

echo "4. Test SSH Olympe..."
ssh -o ConnectTimeout=5 vagrant@192.168.56.10 exit && echo "OK" || echo "FAIL"
```

## 🎉 Félicitations !

Votre environnement PantheonLab est maintenant prêt ! Vous pouvez :

- **Commencer le writeup** : Consultez la section [Writeup](writeup/introduction.md)
- **Explorer l'architecture** : Voir la [Présentation](presentation/architecture.md)
- **Personnaliser** : Modifier les variables dans `ansible/vars/`

### Prochaines Étapes

1. **Lire la documentation** : Familiarisez-vous avec l'architecture
2. **Commencer l'énumération** : Suivez le writeup étape par étape
3. **Personnaliser** : Adaptez le lab à vos besoins
4. **Contribuer** : Améliorez le projet

---

*Votre quête dans l'Olympe numérique peut maintenant commencer ! Que la sagesse d'Athéna vous guide !* ⚡🏛️ 