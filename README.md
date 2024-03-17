# Run

Copier coller .env.template > .env & make up

# Image docker pogfra/app

Cette image sert de base à un projet PHP, et est hébergée sur le hub Docker.

Contenu :

- Apache
- PHP (+xdebug +sendmail)
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

https://hub.docker.com/repository/docker/pogfra/app

## Notes :

Sendmail n'est pas directement disponible. Pour l'activer après avoir lancé le container :

```sh
$ docker-compose exec -u 0:0 app /sendmail.sh
```

### Publier sur dockerhub

```
docker login docker.io

docker build -t pogfra/app:X.Y .

docker push pogfra/app:X.Y
```

Si le tag est omis, c'est le tag `:latest` qui sera mis à jour.

https://docs.docker.com/docker-hub/repos/

```
retag : docker tag <existing-image> <hub-user>/<repo-name>[:<tag>]

update : docker commit <existing-container> <hub-user>/<repo-name>[:<tag>]
```
