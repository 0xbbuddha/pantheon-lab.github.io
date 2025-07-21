# 🏛️ Documentation PantheonLab

[![Documentation CI/CD](https://github.com/pantheon-lab/pantheon-lab.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/pantheon-lab/pantheon-lab.github.io/actions/workflows/deploy.yml)

📌 Ce dépôt héberge le code source de la documentation de **PantheonLab**, un laboratoire de cybersécurité immersif inspiré de la mythologie grecque.

Si vous cherchez le projet principal, rendez-vous sur le [dépôt principal](https://github.com/0xbbuddha/pantheonlab).

## 🚀 Workflow Unique CI/CD

Cette documentation utilise un **workflow unique** GitHub Actions qui :
- ✅ **Teste les Pull Requests** : Build et validation automatique
- ✅ **Déploie automatiquement** : Sur push vers `main`/`master`
- ✅ **Cache optimisé** : Builds rapides avec mise en cache
- ✅ **Artifacts de test** : Téléchargement des builds de PR
- ✅ **Déploiement manuel** : Possible via l'interface GitHub

## 📖 Accès à la Documentation

🌐 **Site web** : [https://pantheon-lab.github.io/](https://0xbbuddha.github.io/pantheon-lab.github.io/index.html)

La documentation est automatiquement mise à jour à chaque modification du code source.

## 🔄 Processus de Développement

### Pour les Pull Requests
1. **Création PR** → **Build automatique** → **Artifacts disponibles**
2. **Review** → **Merge** → **Déploiement automatique**

### Pour les Push Direct
1. **Push sur main** → **Build + Déploiement** → **Site mis à jour**

## 🛠️ Développement Local

### Prérequis
```bash
# Installer les dépendances
pip install -r requirements.txt
```

### Serveur de développement
```bash
# Lancer le serveur local
mkdocs serve

# Ou utiliser le script fourni
./start_docs.sh
```

### Build de production
```bash
# Générer le site statique
mkdocs build

# Déployer vers GitHub Pages
mkdocs gh-deploy
```

## 📂 Structure du Projet

```
pantheon-lab.github.io/
├── docs/                     # Documentation source
│   ├── index.md             # Page d'accueil
│   ├── presentation/        # Présentation du projet
│   ├── installation/        # Guides d'installation
│   ├── writeup/            # Solutions détaillées
│   └── references/         # Ressources
├── mkdocs.yml              # Configuration MkDocs
├── requirements.txt        # Dépendances Python
└── .github/workflows/      # Workflow GitHub Actions
```

## 🎯 Contenu de la Documentation

- **[Présentation](docs/presentation/overview.md)** : Vue d'ensemble du projet
- **[Installation](docs/installation/prerequisites.md)** : Guide d'installation complet
- **[Writeup](docs/writeup/introduction.md)** : Solution détaillée du lab
- **[Références](docs/references/resources.md)** : Ressources et liens utiles

## 🔧 Configuration

### MkDocs
- **Thème** : Material Design avec palette personnalisée
- **Extensions** : Mermaid, syntax highlighting, recherche
- **Plugins** : Git revision date, navigation améliorée

### Workflow GitHub Actions
- **Nom** : `Documentation CI/CD`
- **Tests** : Pull requests et push
- **Déploiement** : Push sur main/master uniquement
- **Cache** : Optimisation des temps de build

## 🤝 Contribution

1. **Fork** le projet
2. **Clone** votre fork
3. **Créez** une branche pour vos modifications
4. **Commitez** vos changements
5. **Poussez** vers votre fork
6. **Créez** une Pull Request

Les PR seront automatiquement testées et les modifications déployées après merge.

## 📊 Statut du Projet

- 🟢 **Documentation** : En cours de développement
- 🟢 **CI/CD** : Workflow unique automatisé
- 🟢 **Tests** : Validation sur chaque PR
- 🟡 **Traductions** : Prévues

## 📚 Ressources

- [Documentation live](https://pantheon-lab.github.io/)
- [Guide de déploiement](DEPLOY.md)
- [Projet principal](https://github.com/0xbbuddha/pantheonlab)
- [MkDocs Documentation](https://www.mkdocs.org/)

---

*Que la sagesse d'Athéna guide votre apprentissage !* ⚡🏛️
