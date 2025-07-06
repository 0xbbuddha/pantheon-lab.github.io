# Configuration

## ⚙️ Configuration Avancée

Cette section détaille la configuration complète de PantheonLab, permettant de personnaliser l'environnement selon vos besoins.

## 🔧 Variables de Configuration

### Fichier de Configuration Principal

Le fichier `ansible/vars/default.yml` contient toutes les variables configurables :

```yaml
# Configuration réseau
network:
  domain: pantheon.god
  subnet: 192.168.56.0/24
  gateway: 192.168.56.1
  dns_servers:
    - 192.168.56.11
    - 8.8.8.8

# Configuration des machines
machines:
  olympe:
    ip: 192.168.56.10
    hostname: OlympeWordpress
    memory: 2048
    cpus: 2
    disk: 20GB
    
  dc01:
    ip: 192.168.56.11
    hostname: pantheon-dc01
    memory: 4096
    cpus: 2
    disk: 40GB
    
  enfers:
    ip: 192.168.56.12
    hostname: pantheon-enfers
    memory: 4096
    cpus: 2
    disk: 40GB

# Configuration Active Directory
active_directory:
  domain_name: pantheon.god
  netbios_name: PANTHEON
  functional_level: WinThreshold
  admin_password: "Zeus@2025!"
  
# Configuration des utilisateurs
users:
  admin_password: "Zeus@2025!"
  user_password: "y"
  default_password: "ChangeMe123!"
  
# Configuration WordPress
wordpress:
  db_name: "pantheon_wp"
  db_user: "wp_user"
  db_password: "wp_pass"
  admin_user: "admin"
  admin_password: "admin123"
  site_title: "Pantheon - Le Panthéon Numérique"
  site_url: "http://pantheon.god"
```

### Configuration des Utilisateurs

Le fichier `ansible/vars/windows_common.yml` définit les utilisateurs du domaine :

```yaml
# Utilisateurs du domaine
domain_users:
  - name: zeus
    password: "Zeus@2025!"
    groups: ["Olympians"]
    description: "Roi des dieux, administrateur du domaine"
    
  - name: hera
    password: "y"
    groups: ["Minor Gods"]
    description: "Reine de l'Olympe, politique stricte"
    
  - name: hermes
    password: "y"
    groups: ["Minor Gods"]
    description: "Messager des dieux, communication"
    
  - name: athena
    password: "y"
    groups: ["Minor Gods"]
    description: "Déesse de la sagesse, monitoring"
    
  - name: ares
    password: "y"
    groups: ["Minor Gods"]
    description: "Dieu de la guerre, attaques"
    
  - name: aphrodite
    password: "y"
    groups: ["Minor Gods"]
    description: "Déesse de l'amour, social engineering"
```

## 🎯 Personnalisation des Vulnérabilités

### Configuration des Vulnérabilités WordPress

```yaml
# ansible/vars/wordpress_vars.yml
wordpress_vulnerabilities:
  cmp_coming_soon:
    enabled: true
    version: "4.1.13"
    vulnerable: true
    
  directory_listing:
    enabled: true
    paths:
      - "/wp-content/uploads/"
      - "/wp-content/plugins/"
      
  xml_rpc:
    enabled: true
    
  wp_cron:
    enabled: true
    external: true
```

### Configuration des Vulnérabilités Active Directory

```yaml
# ansible/vars/windows_common.yml
ad_vulnerabilities:
  password_policy:
    min_length: 4
    complexity: false
    history: 0
    
  kerberos:
    preauth_required: false
    as_rep_roasting: true
    
  acls:
    weak_permissions: true
    dangerous_delegations: true
    
  gpo:
    vulnerable_policies: true
    weak_settings: true
```

## 🌐 Configuration Réseau

### Configuration DNS

```bash
# Configuration DNS locale
sudo nano /etc/hosts

# Ajouter les entrées
192.168.56.10 pantheon.god olympe.god
192.168.56.11 dc01.pantheon.god
192.168.56.12 enfers.pantheon.god
```

### Configuration Kerberos

```bash
# Configuration krb5.conf
sudo nano /etc/krb5.conf

[libdefaults]
    default_realm = PANTHEON.GOD
    dns_lookup_realm = false
    dns_lookup_kdc = false
    ticket_lifetime = 24h
    forwardable = true
    proxiable = true

[realms]
    PANTHEON.GOD = {
        kdc = dc01.pantheon.god
        admin_server = dc01.pantheon.god
    }

[domain_realm]
    .pantheon.god = PANTHEON.GOD
    pantheon.god = PANTHEON.GOD
```

## 🔐 Configuration Sécurité

### Politiques de Sécurité Active Directory

```yaml
# ansible/playbooks/windows_config.yml
security_policies:
  password_policy:
    min_length: 4
    complexity: false
    history: 0
    max_age: 0
    
  account_lockout:
    threshold: 0
    duration: 0
    reset_time: 0
    
  audit_policy:
    logon_events: success
    object_access: success
    privilege_use: success
    policy_change: success
    account_management: success
```

### Configuration des Logs

```yaml
# Configuration des logs Windows
windows_logs:
  security:
    max_size: 100MB
    retention: 30 days
    
  system:
    max_size: 100MB
    retention: 30 days
    
  application:
    max_size: 100MB
    retention: 30 days
```

## 🎭 Personnalisation Thématique

### Configuration des Images

```yaml
# ansible/vars/gods_img_pass.yml
gods_images:
  zeus:
    image: "img_zeus.png"
    description: "Roi des dieux, maître de la foudre"
    
  hera:
    image: "img_hera.png"
    description: "Reine de l'Olympe, gardienne du mariage"
    
  hermes:
    image: "img_hermes.png"
    description: "Messager des dieux, dieu du commerce"
    
  athena:
    image: "img_athena.png"
    description: "Déesse de la sagesse et de la guerre"
    
  ares:
    image: "img_ares.png"
    description: "Dieu de la guerre et de la violence"
    
  aphrodite:
    image: "img_aphrodite.png"
    description: "Déesse de l'amour et de la beauté"
```

### Messages et Indices

```yaml
# ansible/templates/notes.txt.j2
# Notes laissées par les dieux
notes:
  hermes_message: |
    Cher visiteur,
    
    Zeus a décrété que tous les dieux doivent changer leurs mots de passe.
    J'ai oublié de le faire... Honte à moi !
    
    - Hermès, le messager distrait
    
  zeus_message: |
    Décret de Zeus :
    
    Tous les dieux doivent sécuriser leurs comptes.
    La négligence sera punie !
    
    - Zeus, roi de l'Olympe
```

## 🔄 Scripts de Configuration

### Script de Configuration Automatique

```bash
#!/bin/bash
# configure_pantheon.sh

echo "=== Configuration PantheonLab ==="

# Vérifier les prérequis
check_prerequisites() {
    echo "Vérification des prérequis..."
    which vagrant vboxmanage ansible python3 || exit 1
}

# Configuration DNS
setup_dns() {
    echo "Configuration DNS..."
    sudo tee -a /etc/hosts << EOF
192.168.56.10 pantheon.god olympe.god
192.168.56.11 dc01.pantheon.god
192.168.56.12 enfers.pantheon.god
EOF
}

# Configuration Kerberos
setup_kerberos() {
    echo "Configuration Kerberos..."
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
}

# Exécution
check_prerequisites
setup_dns
setup_kerberos

echo "Configuration terminée !"
```

## 📊 Monitoring et Logs

### Configuration des Logs Linux

```yaml
# ansible/playbooks/linux_main.yml
linux_logging:
  rsyslog:
    enabled: true
    remote_logging: false
    
  apache:
    access_log: "/var/log/apache2/access.log"
    error_log: "/var/log/apache2/error.log"
    log_level: "warn"
    
  mysql:
    error_log: "/var/log/mysql/error.log"
    slow_query_log: true
```

### Configuration des Logs Windows

```yaml
# ansible/playbooks/windows_config.yml
windows_logging:
  event_logs:
    - name: "Security"
      max_size: 100MB
      retention: 30
      
    - name: "System"
      max_size: 100MB
      retention: 30
      
    - name: "Application"
      max_size: 100MB
      retention: 30
```

## 🚨 Configuration de Sécurité Avancée

### Firewall et Réseau

```yaml
# Configuration du firewall
firewall_rules:
  windows:
    - name: "Allow RDP"
      port: 3389
      protocol: tcp
      action: allow
      
    - name: "Allow WinRM"
      port: 5985
      protocol: tcp
      action: allow
      
    - name: "Allow SMB"
      port: 445
      protocol: tcp
      action: allow
      
  linux:
    - name: "Allow SSH"
      port: 22
      protocol: tcp
      action: allow
      
    - name: "Allow HTTP"
      port: 80
      protocol: tcp
      action: allow
```

### Configuration des Services

```yaml
# Services à configurer
services:
  windows:
    - name: "WinRM"
      startup: automatic
      state: running
      
    - name: "Remote Desktop Services"
      startup: automatic
      state: running
      
  linux:
    - name: "apache2"
      startup: enabled
      state: running
      
    - name: "mysql"
      startup: enabled
      state: running
```

## 🎯 Validation de la Configuration

### Script de Test

```bash
#!/bin/bash
# test_configuration.sh

echo "=== Test de Configuration PantheonLab ==="

# Test DNS
test_dns() {
    echo "Test DNS..."
    nslookup pantheon.god || echo "❌ DNS échoué"
    nslookup dc01.pantheon.god || echo "❌ DNS DC01 échoué"
}

# Test Kerberos
test_kerberos() {
    echo "Test Kerberos..."
    kinit hermes@PANTHEON.GOD <<< "y" || echo "❌ Kerberos échoué"
}

# Test connectivité
test_connectivity() {
    echo "Test connectivité..."
    ping -c 1 192.168.56.10 || echo "❌ Olympe inaccessible"
    ping -c 1 192.168.56.11 || echo "❌ DC01 inaccessible"
    ping -c 1 192.168.56.12 || echo "❌ Enfers inaccessible"
}

# Exécution des tests
test_dns
test_kerberos
test_connectivity

echo "Tests terminés !"
```

---

*Une configuration bien pensée est la clé d'un lab réussi. Adaptez ces paramètres à vos besoins spécifiques !* ⚙️ 