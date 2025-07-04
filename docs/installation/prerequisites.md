# Prérequis d'Installation

## 🖥️ Configuration Système Requise

### Spécifications Minimales

!!! warning "Configuration Minimale"
    - **OS** : Linux (Ubuntu 18.04+, Debian 10+, CentOS 7+)
    - **CPU** : 4 cores (Intel/AMD 64-bit)
    - **RAM** : 8GB minimum, 16GB recommandé
    - **Espace disque** : 50GB libre minimum
    - **Réseau** : Connexion Internet stable

### Spécifications Recommandées

!!! success "Configuration Optimale"
    - **OS** : Ubuntu 20.04+ ou Debian 11+
    - **CPU** : 8 cores (Intel i7/AMD Ryzen 7+)
    - **RAM** : 16GB minimum, 32GB recommandé
    - **Espace disque** : 100GB SSD
    - **Réseau** : Connexion Internet haute vitesse

## 🔧 Logiciels Requis

### Outils de Base

#### 1. Git
```bash
# Installation sur Ubuntu/Debian
sudo apt update
sudo apt install git

# Vérification
git --version
```

#### 2. VirtualBox
```bash
# Ajout du dépôt officiel
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

# Installation
sudo apt update
sudo apt install virtualbox-6.1

# Vérification
vboxmanage --version
```

#### 3. Vagrant
```bash
# Installation via package manager
sudo apt install vagrant

# Ou installation manuelle
wget https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_linux_amd64.zip
unzip vagrant_2.3.0_linux_amd64.zip
sudo mv vagrant /usr/local/bin/

# Vérification
vagrant --version
```

### Outils d'Automatisation

#### 4. Ansible
```bash
# Installation via package manager
sudo apt install ansible

# Ou installation via pip
sudo apt install python3-pip
pip3 install ansible

# Vérification
ansible --version
```

#### 5. Python et Dépendances
```bash
# Installation Python 3
sudo apt install python3 python3-pip

# Installation pywinrm
pip3 install pywinrm --break-system-packages

# Vérification
python3 --version
pip3 list | grep pywinrm
```

#### 6. Collections Ansible
```bash
# Installation des collections requises
ansible-galaxy collection install trippsc2.adcs
ansible-galaxy collection install ansible.windows
ansible-galaxy collection install community.windows

# Vérification
ansible-galaxy collection list
```

## 🌐 Configuration Réseau

### Prérequis Réseau

!!! info "Configuration Réseau"
    - **Interface réseau** : Au moins une interface configurée
    - **DHCP** : Accès à un serveur DHCP pour l'interface NAT
    - **DNS** : Résolution DNS fonctionnelle
    - **Firewall** : Ports 22, 80, 3389, 5985 accessibles

### Vérification Réseau

```bash
# Test de connectivité
ping -c 4 8.8.8.8

# Test DNS
nslookup google.com

# Vérification des interfaces
ip addr show

# Test des ports requis
netstat -tuln | grep -E ':(22|80|3389|5985)'
```

## 🔐 Configuration Sécurité

### Extensions VirtualBox

```bash
# Installation des extensions VirtualBox
sudo apt install virtualbox-ext-pack

# Ou téléchargement manuel
wget https://download.virtualbox.org/virtualbox/6.1.40/Oracle_VM_VirtualBox_Extension_Pack-6.1.40.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.40.vbox-extpack
```

### Configuration BIOS

!!! warning "Configuration BIOS Requise"
    - **Virtualisation** : VT-x/AMD-V activé
    - **NX/XD** : Execute Disable activé
    - **Secure Boot** : Désactivé (si problème)

### Vérification Virtualisation

```bash
# Vérification VT-x/AMD-V
egrep -c '(vmx|svm)' /proc/cpuinfo

# Si résultat > 0, la virtualisation est activée
# Si résultat = 0, activer dans le BIOS
```

## 📦 Outils Optionnels Recommandés

### Outils de Pentest

```bash
# Installation d'outils utiles
sudo apt install nmap wpscan gobuster dirb nikto metasploit-framework

# Outils Python
pip3 install requests beautifulsoup4 lxml

# Outils Windows (si disponible)
# Windows Terminal, PowerShell 7, etc.
```

### Outils de Monitoring

```bash
# Monitoring système
sudo apt install htop iotop nethogs

# Monitoring réseau
sudo apt install wireshark tcpdump

# Monitoring logs
sudo apt install logwatch
```

## 🧪 Tests de Validation

### Script de Test Automatique

Créez un script de test pour valider l'installation :

```bash
#!/bin/bash
# test_prerequisites.sh

echo "=== Test des Prérequis PantheonLab ==="

# Test des commandes de base
commands=("git" "vagrant" "vboxmanage" "ansible" "python3")
for cmd in "${commands[@]}"; do
    if command -v $cmd &> /dev/null; then
        echo "✅ $cmd installé"
    else
        echo "❌ $cmd manquant"
    fi
done

# Test VirtualBox
if vboxmanage --version &> /dev/null; then
    echo "✅ VirtualBox fonctionnel"
else
    echo "❌ VirtualBox non fonctionnel"
fi

# Test Ansible
if ansible --version &> /dev/null; then
    echo "✅ Ansible fonctionnel"
else
    echo "❌ Ansible non fonctionnel"
fi

# Test réseau
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo "✅ Connectivité réseau OK"
else
    echo "❌ Problème de connectivité"
fi

# Test virtualisation
if egrep -c '(vmx|svm)' /proc/cpuinfo &> /dev/null; then
    echo "✅ Virtualisation activée"
else
    echo "❌ Virtualisation non activée"
fi

echo "=== Fin des Tests ==="
```

### Exécution du Test

```bash
# Rendre le script exécutable
chmod +x test_prerequisites.sh

# Exécuter le test
./test_prerequisites.sh
```

## 🚨 Résolution de Problèmes

### Problèmes Courants

#### VirtualBox ne démarre pas
```bash
# Vérifier les modules kernel
sudo modprobe vboxdrv
sudo modprobe vboxnetflt

# Recharger les modules
sudo systemctl restart vboxdrv
```

#### Vagrant ne trouve pas VirtualBox
```bash
# Vérifier le provider
vagrant provider-list

# Réinstaller VirtualBox
sudo apt remove virtualbox*
sudo apt install virtualbox-6.1
```

#### Ansible ne peut pas se connecter
```bash
# Vérifier pywinrm
pip3 install pywinrm --upgrade

# Tester la connexion
ansible -m win_ping -i inventory windows
```

#### Problèmes de mémoire
```bash
# Vérifier la mémoire disponible
free -h

# Ajuster la configuration Vagrant
# Réduire la RAM allouée aux VMs
```

## 📋 Checklist d'Installation

!!! check "Checklist Prérequis"
    - [ ] Système Linux installé et à jour
    - [ ] Git installé et configuré
    - [ ] VirtualBox installé avec extensions
    - [ ] Vagrant installé et fonctionnel
    - [ ] Ansible installé avec collections
    - [ ] Python3 et pywinrm installés
    - [ ] Virtualisation activée dans le BIOS
    - [ ] Connexion réseau fonctionnelle
    - [ ] Espace disque suffisant
    - [ ] Script de test exécuté avec succès

---

*Une fois tous les prérequis validés, vous pouvez passer à l'installation rapide du lab !* 🚀 