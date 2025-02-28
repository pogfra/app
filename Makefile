# NOTE: les arguments précédés par des moins (-y, --version) seront capturés par make et ne seront pas disponibles pour les commandes
#
# On peut les forcer en ajoutant un argument "--" :
# Tout ce qui suit cet argument spécial n'est pas capturé par make, et sera donc correctement envoyé vers les commandes
#
# La notation générique permet de complètement contourner ce problème : make [action] -- [arguments]
# exemples :
#   make drush -- cim -y
#   make npm -- install malib --save-dev


## GESTION DES CONTAINERS
.PHONY: up down build config prune shell shell-root logs

up: # Start up containers
	@docker compose up -d --remove-orphans
down: # Stop containers
	@docker compose down
build: # Build containers
	@docker compose up -d --remove-orphans --build
config: # Print config
	@docker compose config
prune: # Remove containers and volumes
	@docker compose down -v $(filter-out $@,$(MAKECMDGOALS))
shell:
	@docker compose exec app /bin/bash
shell-root:
	@docker compose exec -u 0:0 app /bin/bash
logs:
	@docker compose logs -f || true


## OUTILS COURANTS
.PHONY: composer drush wp npm npx gulp deno

composer:
	@docker compose exec app composer $(filter-out $@,$(MAKECMDGOALS)) || true
drush:
	@docker compose exec app vendor/bin/drush $(filter-out $@,$(MAKECMDGOALS)) || true
wp:
	@docker compose exec app vendor/bin/wp $(filter-out $@,$(MAKECMDGOALS)) || true
npm:
	@docker compose exec app npm $(filter-out $@,$(MAKECMDGOALS)) || true
npx:
	@docker compose exec app npx $(filter-out $@,$(MAKECMDGOALS)) || true
gulp:
	@docker compose exec app gulp $(filter-out $@,$(MAKECMDGOALS)) || true
deno:
	@docker compose exec app deno $(filter-out $@,$(MAKECMDGOALS)) || true

%:
	@:
