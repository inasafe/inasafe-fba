#!/usr/bin/env bash

# This script will run as the postgres user due to the Dockerfile USER directive
set -e

# Setup postgres CONF file

source /setup-conf.sh

# Setup ssl
source /setup-ssl.sh

# Setup pg_hba.conf

source /setup-pg_hba.sh

source /setup-func.sh

if [[ -z "$REPLICATE_FROM" ]]; then
	# This means this is a master instance. We check that database exists
	echo "Setup master database"
	source /setup-database.sh
	entry_point_script
	kill_postgres
else
	# This means this is a slave/replication instance.
	echo "Setup slave database"
	source /setup-replication.sh
fi


# If no arguments passed to entrypoint, then run postgres by default

echo "Postgres initialisation process completed .... restarting in foreground"
su - postgres -c "$SETVARS $POSTGRES  -D $DATADIR  -c config_file=$CONF" &
echo "Restart done."

echo "Command $@"

exec "$@"
