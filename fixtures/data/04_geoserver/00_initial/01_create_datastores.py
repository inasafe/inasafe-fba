#!/usr/bin/env python3
import os

from utils import GeoServerRESTRunner

if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:

        response = runner.assert_get(s, '/workspaces/kartoza/datastores/gis')

        if response.ok:
            print('Resource exists.')
            print()
            exit(0)

        data = {
            'dataStore': {
                'name': 'gis',
                'type': 'PostGIS',
                'connectionParameters': {
                    'database': os.environ.get('GEOSERVER_STORE_POSTGRES_DB'),
                    'schema': 'public',
                    'host': os.environ.get('GEOSERVER_STORE_POSTGRES_HOST'),
                    'user': os.environ.get('GEOSERVER_STORE_POSTGRES_USER'),
                    'passwd': os.environ.get('GEOSERVER_STORE_POSTGRES_PASS'),
                    'port': os.environ.get('GEOSERVER_STORE_POSTGRES_PORT'),
                    'dbtype': 'postgis'
                }
            }
        }

        response = runner.assert_post(
            s,
            '/workspaces/kartoza/datastores',
            json=data,
            validate=True
        )

        runner.print_response(response)

        exit(not response.ok)
