#!/usr/bin/env python3
import os

from utils import GeoServerRESTRunner

if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:

        response = runner.assert_get(
            s,
            '/workspaces/kartoza/layergroups/web')

        if response.ok:
            print('Resource exists.')
            print()
            exit(0)

        data = {
            'layerGroup': {
                'name': 'web',
                'mode': 'SINGLE',
                'title': 'Web Map',
                'publishables': {
                    'published': [
                        {
                            '@type': 'layer',
                            'name': 'osm_admin',
                        },
                        {
                            '@type': 'layer',
                            'name': 'osm_roads',
                        },
                        {
                            '@type': 'layer',
                            'name': 'osm_waterways',
                        }
                    ]
                },
                'styles': {
                    'style': [
                        {
                            'name': 'osm_admin_web',
                        },
                        {
                            'name': 'BlueprintRoads',
                        },
                        {
                            'name': 'BlueprintRivers',
                        }
                    ]
                },
                'bounds': {
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
            '/workspaces/kartoza/layergroups/',
            json=data,
            validate=True
        )

        runner.print_response(response)

        exit(not response.ok)
