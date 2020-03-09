.DEFAULT_GOAL:= build
USER_OPTS?=--user="$$(id -u):$$(id -g)"
VOL_OPTS?=--volume="$$(pwd):/var/www/requisition"

.PHONY: app
app:
	docker-compose run $(USER_OPTS) $(VOL_OPTS) --rm --service-ports app

.PHONY: build
build:
	docker-compose build --pull

.PHONY: shell
shell:
	docker-compose run $(USER_OPTS) $(VOL_OPTS) --rm app /bin/sh

.PHONY: repl
repl:
	docker-compose run $(USER_OPTS) $(VOL_OPTS) --rm app bundle exec rails console
