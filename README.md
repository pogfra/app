# Présentation

Cette image est conteneur docker servant de base pour des applications php, il est composé de :

- Apache
- PHP (+xdebug)
- composer
- node
- npm
- gulp-cli
- imagemagick
- deno
- rsync
- git
- inotify
- poppler
- unzip

# Utilisation

### Installer et lancer Docker Dev (Traefik / Mysql)

[Docker Dev](https://github.com/pogfra/dev)

### Extraire l'archive
```
unzip app.zip && cd app
```

### Dupliquer le fichier .env.template en .env

```
cp .env.template .env
```

### Définir le nom du projet avec PROJECT
```
### DOCKER SETTINGS

PROJECT=app
DOMAIN=dev.local

# Host user id (`id -u`) and group id (`id -g`)
# ID_USER=1000
# ID_GROUP=1000

# off,develop,coverage,debug,gcstats,profile,trace
XDEBUG_MODE=off
```

### Lancer le conteneur
```
make up
```
