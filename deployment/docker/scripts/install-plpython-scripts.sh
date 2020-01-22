#!/usr/bin/env bash
apt -y update
apt -y install curl python3 python3-pip zip

rm -rf /tmp/upgrades
mkdir -p /tmp/upgrades
mkdir -p /docker-entrypoint-initdb.d

# Install forecast scripts
mkdir -p /tmp/upgrades/forecast_scripts
curl ${ARCHIVE_BASE_URL}/forecast_scripts/entrypoint-scripts.zip -o /tmp/upgrades/forecast_scripts/entrypoint-scripts.zip
pushd /tmp/upgrades/forecast_scripts
unzip entrypoint-scripts.zip
echo "Copy entrypoint-scripts"
rm -rf entrypoint-scripts/*.sh entrypoint-scripts/*.sql
cp -rf entrypoint-scripts/* /docker-entrypoint-initdb.d/
echo "plpython script injection finished."
