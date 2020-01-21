#!/usr/bin/env bash

REPO_ROOT=${REPO_ROOT:-/opt/inasafe-fba}

# variable subtitutions to templates
python3 ${REPO_ROOT}/deployment/docker/scripts/generate_conf.py ${REPO_ROOT}/deployment/docker/templates web.nginx.template.conf /etc/nginx/conf.d/default.conf
python3 ${REPO_ROOT}/deployment/docker/scripts/generate_conf.py /usr/share/nginx/app-dashboard/js site-config.template.js /usr/share/nginx/app-dashboard/js/site-config.js

exec "$@"
