.PHONY: help run destroy build logs test

 HELP_FUN = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^(\w+)\s*:.*\#\#(?:@(\w+))?\s(.*)$$/ }; \
	print "usage: make [target]\n\n"; \
	for (keys %help) { \
		print "$$_:\n"; $$sep = " " x (20 - length $$_->[0]); \
		print "  $$_->[0]$$sep$$_->[1]\n" for @{$$help{$$_}}; \
		print "\n"; }

 help: ## Show this help.
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

run: ## Runs containers
	docker-compose up -d

destroy: ## Destroys and cleans up containers
	@echo "Nothing"

build: ## Builds images
	docker-compose build --force-rm --pull

test: ## Run tests
	docker-compose run --rm web bin/phpunit -c app/phpunit.xml --bootstrap vendor/autoload.php

logs: ## Shows logs
	docker-compose logs -f

default: help
