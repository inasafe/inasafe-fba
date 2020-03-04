#!/usr/bin/env python3
import os

from utils import GeoServerRESTRunner

if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:

        response = runner.assert_get(
            s,
            '/workspaces/kartoza/datastores/gis/featuretypes/osm_admin')

        if response.ok:
            print('Resource exists.')
            print()
            exit(0)

        data = {
            'featureType': {
                'name': 'osm_admin',
                'nativeName': 'osm_admin',
                'title': 'osm_admin',
                'srs': 'EPSG:4326',
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
