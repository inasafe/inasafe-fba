#!/usr/bin/env bash

# Running extended script or sql if provided.
# Useful for people who extends the image.
function entry_point_script {
SETUP_LOCKFILE="/docker-entrypoint-initdb.d/.entry_point.lock"
if [[ -f "${SETUP_LOCKFILE}" ]]; then
	return 0
else
    if find "/docker-entrypoint-initdb.d" -mindepth 1 -print -quit 2>/dev/null | grep -q .; then
        for f in /docker-entrypoint-initdb.d/*; do
        export PGPASSWORD=${POSTGRES_PASS}
        list=(`echo ${POSTGRES_DBNAME} | tr ',' ' '`)
        arr=(${list})
        SINGLE_DB=${arr[0]}
        case "$f" in
            *.sql)    echo "$0: running $f"; psql ${SINGLE_DB} -U ${POSTGRES_USER} -p 5432 -h localhost  -f ${f} || true ;;
            *.sql.gz) echo "$0: running $f"; gunzip < "$f" | psql ${SINGLE_DB} -U ${POSTGRES_USER} -p 5432 -h localhost || true ;;
            *.sh)     echo "$0: running $f"; . $f || true;;
            *)        echo "$0: ignoring $f" ;;
        esac
        echo
        done
        # Put lock file to make sure entry point scripts were run
        touch ${SETUP_LOCKFILE}
    else
        return 0
    fi

fi

}

function kill_postgres {
PID=`cat ${PG_PID}`
kill -TERM ${PID}

# Wait for background postgres main process to exit
while [[ "$(ls -A ${PG_PID} 2>/dev/null)" ]]; do
  sleep 1
done
}
