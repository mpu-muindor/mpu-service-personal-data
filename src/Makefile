ROOT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PHPSTAN=$(ROOT_DIR)/vendor/bin/phpstan
PHPSTAN_OPTIONS=--memory-limit=2G

PHPCS=$(ROOT_DIR)/vendor/bin/phpcs
PHPCS_IGNORE=resources/lang,resources/views,bootstrap/cache,database/migrations,bin,config,vendor,public,storage

PHPCBF=$(ROOT_DIR)/vendor/bin/phpcbf

analyse:
	@$(PHPSTAN) analyse $(PHPSTAN_OPTIONS)
	@echo 'PHPSTAN: OK\n'

phpcs:
	@$(PHPCS) --report=code --colors --standard=PSR12,PSR2 --ignore=$(PHPCS_IGNORE) $(ROOT_DIR)
	@echo 'PHPCS: OK\n'

phpcsfix:
	@$(PHPCBF) --report=code --colors --standard=PSR12,PSR2 --ignore=$(PHPCS_IGNORE) $(ROOT_DIR)

lint: phpcs analyse
