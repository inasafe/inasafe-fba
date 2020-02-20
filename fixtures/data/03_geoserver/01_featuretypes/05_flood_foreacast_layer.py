#!/usr/bin/env python3
import os

from utils import GeoServerRESTRunner

if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:

        response = runner.assert_get(
            s,
            '/workspaces/kartoza/datastores/gis/featuretypes/flood_forecast_layer')

        if response.ok:
            print('Resource exists.')
            print()
            exit(0)

        data = {
            'featureType': {
                'name': 'flood_forecast_layer',
                'nativeName': 'flood_forecast_layer',
                'title': 'Flood Forecast Map',
                'srs': 'EPSG:4326',
                'abstract': 'This layer shows the flood extent for a given flood event. It is intended that you use a CQL filter passing the id when using this layer.',
                'metadata': {
                    'entry': [
                        {
                            '@key': 'JDBC_VIRTUAL_TABLE',
                            'virtualTable': {
                                'name': 'flood_forecast_layer',
                                'sql': """select 
                                row_number() OVER () AS gid,
                                hazard_event.id as id,
                                geometry,
                                depth_class
                                from hazard_event
                                inner join hazard_map on hazard_event.flood_map_id = hazard_map.id
                                inner join hazard_areas on hazard_map.id = hazard_areas.flood_map_id
                                inner join hazard_area on hazard_areas.flooded_area_id = hazard_area.id""",
                                'escapeSql': False,
                                'geometry': {
                                    'name': 'geometry',
                                    'type': 'MultiPolygon',
                                    'srid': 4326
                                }
                            }
                        },
                    ]
                },
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
