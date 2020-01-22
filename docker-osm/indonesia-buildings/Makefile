SHELL := /bin/bash

# ----------------------------------------------------------------------------
#    P R O D U C T I O N     C O M M A N D S
# ----------------------------------------------------------------------------
deploy: run-docker-osm-setting run import-clip
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Bringing up docker osm instance and loading clip region"
	@echo "------------------------------------------------------------------"

prepare-integration-tests:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Do preparations for default integration tests"
	@echo "------------------------------------------------------------------"
	@WORKING_DIR=$(PWD); FIXTURES_PATH=$(PWD)/../../fixtures; source $${FIXTURES_PATH}/tests/scripts/integration-tests-prepare.sh

upgrade-plpython-scripts:
	@docker-compose exec db bash -c 'wget -qO- $${ARCHIVE_BASE_URL}/install-plpython-scripts.sh | bash'
#	@docker-compose exec db sh -c 'echo "$${ARCHIVE_BASE_URL}/install-plpython-scripts.sh"'

shell:
	@docker-compose exec db bash

testrunner-shell:
	@docker-compose exec testrunner bash

test:
	@docker-compose exec testrunner python -m unittest discover

wait-db-ready:
	@docker-compose exec db bash -c 'while ! su - postgres -c "psql -l" > /dev/null; do echo "Database not ready. Wait"; sleep $(or ${TIMEOUT},5); done; echo "Database ready."'

wait-backend-ready:
	@docker-compose exec testrunner bash -c 'while ! python -m unittest backend 2>&1 > /dev/null; do echo "Database not ready. Waiting"; sleep $(or ${TIMEOUT},60); done; echo "Backend ready."'

ps:
	@docker-compose ps

up:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Bringing up docker osm instance with default prod configuration"
	@echo "------------------------------------------------------------------"
	@docker-compose up -d $(SERVICE)

run: run-docker-osm-setting 
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Bringing up docker osm instance "
	@echo "------------------------------------------------------------------"
	@docker-compose up -d

run-docker-osm-setting:
	@echo "------------------------------------------------------------------"
	@echo "Get setting of "
	@echo "------------------------------------------------------------------"
	$(MAKE) -C docker-osm-settings osm-settings

import-clip:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Importing clip shapefile into the database"
	@echo "------------------------------------------------------------------"
	@docker-compose -p $(PROJECT_ID) exec imposm apt update
	@docker-compose -p $(PROJECT_ID) exec imposm apt install -y gdal-bin
	@docker-compose -p $(PROJECT_ID) exec imposm /usr/bin/ogr2ogr -progress -skipfailures -lco GEOMETRY_NAME=geom -nlt PROMOTE_TO_MULTI -f PostgreSQL PG:"host=db user=docker password=docker dbname=gis" /home/settings/clip/clip.shp


down:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Shutting down containers"
	@echo "------------------------------------------------------------------"
	@docker-compose down

rm: kill
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Removing production instance!!! "
	@echo "------------------------------------------------------------------"
	@docker-compose rm

rm-volumes:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Removing all volumes!!!! "
	@echo "------------------------------------------------------------------"
	@docker volume rm $(COMPOSE_PROJECT_NAME)_osm-postgis-data $(COMPOSE_PROJECT_NAME)_import_queue $(COMPOSE_PROJECT_NAME)_import_done $(COMPOSE_PROJECT_NAME)_cache

logs:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Show logs of stack status"
	@echo "------------------------------------------------------------------"
	@docker-compose logs -f --tail=30 $(SERVICE)
