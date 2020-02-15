#!/usr/bin/env bash

# We are using bash script because we want to
# populate config table based on current environment var value

source /env-data.sh

env_var=( POSTGREST_BASE_URL GEOSERVER_BASE_URL WMS_BASE_URL )

for i in "${env_var[@]}"
do
	eval value=\$$i
	query="INSERT INTO public.config (key, value) VALUES ('$i', '\"$value\"') ON CONFLICT (key) DO UPDATE SET key = '$i', value = '\"$value\"' ;"
	if ! PGPASSWORD=${POSTGRES_PASS} psql -d ${POSTGRES_DB} -U ${POSTGRES_USER} -h ${POSTGRES_HOST} -v ON_ERROR_STOP=1 -c "$query" -1; then
		echo "Config failed at query $query"
		echo "Cancel import"
		RETVAL=1
		break
	fi
done

exit $RETVAL
