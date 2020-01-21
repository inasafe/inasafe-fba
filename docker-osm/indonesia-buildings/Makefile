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

up:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Bringing up docker osm instance with default prod configuration"
	@echo "------------------------------------------------------------------"
	@docker-compose up -d

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
	@docker-compose logs -f
