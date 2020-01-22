#!/usr/bin/env bash

pip install -r ${TEST_PACKAGE_ROOT}/requirements.txt

exec "$@"
