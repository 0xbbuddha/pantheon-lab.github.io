# Architecture Technique

## 🏗️ Vue d'ensemble de l'Architecture

PantheonLab est conçu avec une architecture modulaire et scalable, permettant une déploiement facile et une personnalisation poussée. L'ensemble repose sur des technologies modernes d'orchestration et d'automatisation.

## 🌐 Topologie Réseau

### Schéma Réseau

```mermaid
graph TB
    subgraph "Réseau Privé 192.168.56.0/24"
        subgraph "Machine Hôte"
            A[Kali Linux / Machine d'attaque]
        end
        
        subgraph "Machines Cibles"
            B[Olympe<br/>192.168.56.10<br/>Ubuntu 18.04]
            C[DC01<br/>192.168.56.11<br/>Windows Server 2025]
            D[Enfers<br/>192.168.56.12<br/>Windows Server 2025]
        end
    end
    
    A --> B
    A --> C
    A --> D
    B --> C
    B --> D
    C --> D
```

