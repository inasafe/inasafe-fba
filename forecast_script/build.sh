#!/usr/bin/env bash

echo $REPO_ROOT

# Generate entrypoint-scripts.zip to host
mkdir -p ${REPO_ROOT}/forecast_script/tmp
pushd ${REPO_ROOT}/forecast_script
zip -r tmp/entrypoint-scripts.zip entrypoint-scripts
