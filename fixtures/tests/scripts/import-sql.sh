#!/usr/bin/env bash

source /env-data.sh

echo "Imported directory: $1"

for f in $(find $1 -name '*.sql' -o -name '*.sh' | sort -n); do
	case "$f" in
		*.sql)
			echo "Importing $f"
			if ! PGPASSWORD=${POSTGRES_PASS} psql -d ${POSTGRES_DB} -U ${POSTGRES_USER} -h ${POSTGRES_HOST} -v ON_ERROR_STOP=1 -f $f -1; then
				echo "Import failed on file $f"
				echo "Cancel import"
				break
			fi
			;;
		*.sh)
			echo "Executing $f"
			if ! . $f; then
				echo "Execution failed on file $f"
				echo "Cancel import"
				break
			fi
			;;
	esac
done
