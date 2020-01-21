

up:
	@docker-compose up -d

down:
	@docker-compose down

ps:
	@docker-compose ps

logs:
	@docker-compose logs -f inasafe-fba

shell:
	@docker-compose exec inasafe-fba bash

build: build-archive
	@docker-compose build

build-archive:
	@echo "Forecast script archive build"
	@cd ../forecast_script;$(MAKE) build

backend-up:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) up
	@cd ../geoserver; $(MAKE) up

backend-down:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) down
	@cd ../geoserver; $(MAKE) down
