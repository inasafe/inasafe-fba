#!/usr/bin/env bash

# store this script in postgis entry point directory

echo "REPO ROOT: ${REPO_ROOT}"

# make sure tools installed

apt -y update; apt -y install vim nano git;

# Update repo
pushd ${REPO_ROOT}
git pull origin master
ln -nsf /opt/inasafe-fba/fixtures/tests/scripts/import-fixtures.sh /usr/local/bin/import-fixtures.sh
echo "Updating schema..."
import-fixtures.sh /opt/inasafe-fba/fixtures/schema
echo "Updating data init..."
import-fixtures.sh /opt/inasafe-fba/fixtures/data
popd
