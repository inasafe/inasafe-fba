#!/usr/bin/env python3
from importer import Importer

if __name__ == '__main__':
    importer = Importer()
    importer.overwrite_environment()
    importer.check_settings()
    importer.create_timestamp()
    importer.check_postgis()
    importer._first_pbf_import(['-limitto', importer.clip_json_file])
