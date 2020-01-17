.PHONY: app build-local console rails-console
.DEFAULT_GOAL:= build-local
USER_OPTS?=--user="$$(id -u):$$(id -g)"
VOL_OPTS?=--volume="$$(pwd):/var/www/requisition"

app:
	docker-compose run $(USER_OPTS) $(VOL_OPTS) --rm --service-ports app

build-local:
	docker-compose build --pull

console:
	docker-compose run $(USER_OPTS) $(VOL_OPTS) --rm app /bin/sh

rails-console:
	docker-compose run $(USER_OPTS) $(VOL_OPTS) --rm app bundle exec rails console
