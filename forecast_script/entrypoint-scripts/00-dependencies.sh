#!/usr/bin/env bash

# Include python3
apt -y update; apt -y install python3 python3-pip git

# Add ubuntugis
apt -y install software-properties-common wget
add-apt-repository ppa:ubuntugis/ppa
apt -y update
apt -y upgrade

# Add GDAL
apt -y install gdal-bin libgdal-dev python3-gdal
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip3 install GDAL==`gdal-config --version`

export PG_MAJOR_VERSION=$(pg_config --version | grep -Po '(?<=PostgreSQL )[^.]+')

# Add pg_cron
apt -y install postgresql-$PG_MAJOR_VERSION-cron
echo "shared_preload_libraries = 'pg_cron'" >> /etc/postgresql/$PG_MAJOR_VERSION/main/postgresql.conf
echo "cron.database_name = 'gis'" >> /etc/postgresql/$PG_MAJOR_VERSION/main/postgresql.conf

# Add plpython3u
apt -y install postgresql-plpython3-$PG_MAJOR_VERSION

# Needs postgres restart to apply new extension library
source /env-data.sh
restart_postgres
