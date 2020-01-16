.PHONY: build-local console

build-local:
	docker-compose build --pull

console: build-local
	docker-compose run --rm app rails console
