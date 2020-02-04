#!/usr/bin/env bash

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

pip install -r ${TEST_PACKAGE_ROOT}/requirements.txt

exec "$@"
