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
	@docker-compose exec $(or $(SERVICE),db) bash

testrunner-shell:
	@docker-compose exec testrunner bash

first-pbf-import:
	@docker-compose exec imposm bash -c 'rm -f /home/settings/.first-pbf-import.lock'
	@make schema-test SCHEMA=/00_initial/00_schema/00_initial.sql
	@until docker-compose exec imposm bash -c 'PYTHONPATH=/home python3 $${REPO_ROOT}/fixtures/tests/scripts/first_pbf_import.py'; do echo "Retrying..."; sleep $(or ${TIMEOUT}, 30); done
	# Add flag to tell that first-pbf-import finishes
	@docker-compose exec imposm bash -c 'touch /home/settings/.first-pbf-import.lock'

wait-first-pbf-import:
	@until docker-compose exec imposm bash -c 'ls /home/settings/.first-pbf-import.lock > /dev/null'; do echo "First PBF import not done."; sleep $(or ${TIMEOUT},30); done; echo "Initial OSM tables ready."

schema-test:
	@docker-compose exec db bash -c '$${REPO_ROOT}/fixtures/tests/scripts/import-sql.sh $${REPO_ROOT}/fixtures/schema$(SCHEMA)'

populate-test-data:
	@docker-compose exec db bash -c '$${REPO_ROOT}/fixtures/tests/scripts/import-sql.sh $${REPO_ROOT}/fixtures/data'

test:
	@docker-compose exec db bash -c 'cd $${REPO_ROOT}/fixtures; python3 -m unittest discover -v'

forecast-test:
	@docker-compose exec db bash -c 'cd $${REPO_ROOT}/forecast_script/forecast_worker; python3 -m unittest discover -v'

wait-db-ready:
	@docker-compose exec db bash -c 'while ! su - postgres -c "psql -l" > /dev/null; do echo "Database not ready. Wait"; sleep $(or ${TIMEOUT},5); done; echo "Database ready."'
	@docker-compose exec db bash -c 'while ! su - postgres -c "psql -t -d $${POSTGRES_DB} -c \"select name from pg_available_extensions where name = '"'"'postgis'"'"'\"" > /dev/null; do echo "Postgis extension not ready. Wait"; sleep $(or ${TIMEOUT},5); done; echo "Postgis extension ready."'

wait-backend-ready:
	@docker-compose exec db bash -c 'cd $${REPO_ROOT}/fixtures; while ! python3 -m unittest tests.backend.TestBackendReady 2>&1 > /dev/null; do echo "Database not ready. Waiting"; sleep $(or ${TIMEOUT},60); done; echo "Backend ready."'

ps:
	@docker-compose ps

up:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Bringing up docker osm instance with default prod configuration"
	@echo "------------------------------------------------------------------"
	@docker-compose up -d $(SERVICE)

stop:
	@docker-compose stop $(or $(SERVICE),db)

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
