#!/usr/bin/env python3
import os

from utils import GeoServerRESTRunner

if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:

        response = runner.assert_get(
            s,
            '/workspaces/kartoza/datastores/gis/featuretypes/osm_buildings')

        if response.ok:
            print('Resource exists.')
            print()
            exit(0)

        data = {
            'featureType': {
                'name': 'osm_buildings',
                'nativeName': 'osm_buildings-ft',
                'title': 'osm_buildings',
                'srs': 'EPSG:4326',
                'metadata': {
                    'entry': [
                        {
                            '@key': 'JDBC_VIRTUAL_TABLE',
                            'virtualTable': {
                                'name': 'osm_buildings-ft',
                                'sql': 'select * from osm_buildings where building_area < 7000\n',
                                'escapeSql': False,
                                'keyColumn': 'osm_id',
                                'geometry': {
                                    'name': 'geometry',
                                    'type': 'Polygon',
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
