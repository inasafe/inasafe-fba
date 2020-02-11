#!/usr/bin/env python3
import os

from utils import GeoServerRESTRunner

if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:

        response = runner.assert_get(
            s,
            '/workspaces/kartoza/datastores/gis/featuretypes/district_boundary')

        if response.ok:
            print('Resource exists.')
            print()
            exit(0)

        data = {
            'featureType': {
                'name': 'district_boundary',
                'nativeName': 'district_boundary',
                'title': 'district_boundary',
                'srs': 'EPSG:4326',
                'metadata': {
                    'entry': [
                        {
                            '@key': 'JDBC_VIRTUAL_TABLE',
                            'virtualTable': {
                                'name': 'district_boundary',
                                'sql': 'select id, dc_code as id_code, name, geom from district',
                                'escapeSql': False,
                                'keyColumn': 'id',
                                'geometry': {
                                    'name': 'geom',
                                    'type': 'MultiPolygon',
                                    'srid': 4326
                                }
                            }
                        }
                    ]
                }
            }
        }

        response = runner.assert_post(
            s,
            '/workspaces/kartoza/datastores/gis/featuretypes/',
            json=data,
            validate=True
        )

        runner.print_response(response)

        exit(not response.ok)
