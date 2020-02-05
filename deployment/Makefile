

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
	@cd ../docker-osm/indonesia-buildings; $(MAKE) up SERVICE=$(SERVICE)
#	@cd ../geoserver; $(MAKE) up

backend-stop:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) stop SERVICE=$(SERVICE)

backend-logs:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) logs SERVICE=$(SERVICE)

backend-schema-test:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) schema-test

backend-populate-test-data:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) populate-test-data

backend-first-pbf-import:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) first-pbf-import

backend-wait-first-pbf-import:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) wait-first-pbf-import

backend-test:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) test

backend-forecast-test:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) forecast-test

wait-db-ready:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) wait-db-ready

wait-backend-ready:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) wait-backend-ready

backend-down:
	@cd ../docker-osm/indonesia-buildings; $(MAKE) down
#	@cd ../geoserver; $(MAKE) down
