#!/usr/bin/env bash

# Working dir refer to the current location of the docker-compose.yml file of the backend to run integration tests
pushd ${WORKING_DIR}

echo "Current working directory ${WORKING_DIR}"

# Create custom settings dir
mkdir -p .cache
mkdir -p .postgres-data
mkdir -p docker-osm-settings/custom_settings

# Copy default integration tests .env
cp -rf .sample.env .env

# Copy default docker-compose.override.yml for integration tests
cp -rf docker-compose.override.local-volumes.yml docker-compose.override.yml

# Copy docker osm custom settings
export FIXTURES_PATH=$(realpath ${FIXTURES_PATH:-../../})
export REPO_ROOT=$(realpath ${FIXTURES_PATH}/../)

echo "FIXTURES_PATH: ${FIXTURES_PATH}"
echo "REPO_ROOT: ${REPO_ROOT}"

cp -rf docker-osm-settings/settings/mapping.yml docker-osm-settings/custom_settings/mapping.yml
cp -rf docker-osm-settings/settings/qgis_style.sql docker-osm-settings/custom_settings/qgis_style.sql
cp -rf docker-osm-settings/settings/post-pbf-import.sql.bu docker-osm-settings/custom_settings/post-pbf-import.sql.bu
cp -rf ${FIXTURES_PATH}/tests/docker-osm/clip.geojson docker-osm-settings/custom_settings/clip.geojson

# Download test pbf for docker-osm
export PBF_URL=${PBF_URL:-http://cloud.kartoza.com/s/sxR8anXo5fgFN9Q/download}

# Retrieve PBF test files
#echo "Downloading test PBF file: ${PBF_URL}"
#curl -L ${PBF_URL} -o docker-osm-settings/custom_settings/country.pbf
docker pull inasafe/inasafe-fba-resources:latest
docker run --name resources -d inasafe/inasafe-fba-resources:latest tail -f /dev/null
docker cp resources:/home/country.pbf docker-osm-settings/custom_settings/country.pbf

du -sh docker-osm-settings/custom_settings/country.pbf

popd

echo "Preparation done"
