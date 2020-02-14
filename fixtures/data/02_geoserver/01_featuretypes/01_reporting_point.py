#!/usr/bin/env python3
import os

from utils import GeoServerRESTRunner

if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:

        response = runner.assert_get(
            s,
            '/workspaces/kartoza/datastores/gis/featuretypes/reporting_point')

        if response.ok:
            print('Resource exists.')
            print()
            exit(0)

        data = {
            'featureType': {
                'name': 'reporting_point',
                'nativeName': 'reporting_point',
                'title': 'Reporting point list',
                'srs': 'EPSG:4326',
                'nativeBoundingBox': {
                    'minx': -180,
                    'maxx': 180,
                    'miny': -90,
                    'maxy': 90,
                    'crs': 'EPSG:4326'
                },
                'latLonBoundingBox': {
                    'minx': -180,
                    'maxx': 180,
                    'miny': -90,
                    'maxy': 90,
                    'crs': 'EPSG:4326'
                },
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
