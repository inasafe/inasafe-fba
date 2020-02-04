#!/usr/bin/env bash

set -e

# Include python3
apt -y update; apt -y install python3 python3-pip git

# Add ubuntugis
apt -y install software-properties-common wget
apt -y update

# Add GDAL
apt -y install gdal-bin libgdal-dev python3-gdal
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip3 install GDAL==`gdal-config --version`

source /env-data.sh
export PG_MAJOR_VERSION=$(${POSTGRES} --version | grep -Po '(?<=PostgreSQL\) )[^.]+')
echo "Postgres major version: $PG_MAJOR_VERSION"


function restart_postgres_with_log {
  PID=`cat ${PG_PID}`
  kill -TERM ${PID}

  # Wait for background postgres main process to exit
  while [[ "$(ls -A ${PG_PID} 2>/dev/null)" ]]; do
    sleep 1
  done

  # Brought postgres back up again
  source /env-data.sh
  su - postgres -c "$SETVARS $POSTGRES  -D $DATADIR  -c config_file=$CONF" > /var/log/postgres-main.log &

  # wait for postgres to come up
  until su - postgres -c "psql -l"; do
    sleep 1
  done
  echo "postgres ready"
}

# Add pg_cron
apt -y install postgresql-$PG_MAJOR_VERSION-cron
if ! cat /etc/postgresql/$PG_MAJOR_VERSION/main/postgresql.conf | grep "shared_preload_libraries = 'pg_cron'" > /dev/null; then
	echo "shared_preload_libraries = 'pg_cron'" >> /etc/postgresql/$PG_MAJOR_VERSION/main/postgresql.conf
	echo "cron.database_name = 'gis'" >> /etc/postgresql/$PG_MAJOR_VERSION/main/postgresql.conf

	source /env-data.sh
	restart_postgres_with_log
fi

# Add plpython3u
apt -y install postgresql-plpython3-$PG_MAJOR_VERSION
