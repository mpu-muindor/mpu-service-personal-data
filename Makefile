build:
	@echo 'Start building dev environment'
	docker-compose build

install: build
	@test -f ./src/.env && echo '.env exists' && exit 1
	@cp ./src/.env.example ./src/.env
	@echo 'Start 1/3 step | Starting container `mpu-pd-app`'
	@docker-compose up -d mpu-pd-app
	@echo 'Start 2/3 step | Key generating'
	@docker-compose exec mpu-pd-app php artisan key:generate
	@echo 'Start 3/3 step | Shutdown container `mpu-pd-app`'
	@docker-compose down mpu-pd-app
	@echo 'DONE!'

db:
	docker-compose exec mpu-pd-db psql stage -h localhost --username=postgres

attach:
	docker-compose exec mpu-pd-app /bin/bash

migrate:
	docker-compose up mpu-pd-migrator

run: start

start:
	docker-compose up -d

down: stop

stop:
	docker-compose down

run-dev:
	docker-compose up

analyse:
	cd src && $(MAKE) analyse

phpcs:
	cd src && $(MAKE) phpcs

phpcsfix:
	cd src && $(MAKE) phpcsfix

inithooks:
	git config core.hooksPath githooks
