#!/usr/bin/env bash

# Deploy frontend to nginx static folders
REPO_ROOT=${REPO_ROOT:-/opt/inasafe-fba}

cp -rf ${REPO_ROOT}/frontend/app-dashboard /usr/share/nginx/

# Deploy forecast_script to archive
mkdir -p ${REPO_ROOT}/archive/forecast_scripts/
pushd ${REPO_ROOT}/forecast_script
make build
popd
cp ${REPO_ROOT}/forecast_script/tmp/entrypoint-scripts.zip ${REPO_ROOT}/archive/forecast_scripts/

# Deploy plpython install scripts to archive
cp -rf ${REPO_ROOT}/deployment/docker/scripts/install-plpython-scripts.sh ${REPO_ROOT}/archive/
