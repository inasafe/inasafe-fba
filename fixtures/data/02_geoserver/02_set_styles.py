#!/usr/bin/env python3
import os

from utils import GeoServerRESTRunner


def set_style(runner, session, layer_name, style_name):
    response = runner.assert_put(
        session,
        '/workspaces/kartoza/layers/{layer_name}.json'.format(
            layer_name=layer_name),
        json={
            'layer': {
                'defaultStyle': {
                    'name': style_name
                }
            }
        }
    )
    return response


if __name__ == '__main__':

    runner = GeoServerRESTRunner()
    with runner.session() as s:

        layer_and_style = [
            {
                'layer_name': 'district_boundary',
                'style_name': 'red_outline',
            },
            {
                'layer_name': 'sub_district_boundary',
                'style_name': 'red_outline',
            },
            {
                'layer_name': 'village_boundary',
                'style_name': 'red_outline',
            },
            {
                'layer_name': 'exposed_buildings',
                'style_name': 'building_vulnerability'
            },
            {
                'layer_name': 'exposed_roads',
                'style_name': 'exposed_roads'
            },
            {
                'layer_name': 'flood_forecast_layer',
                'style_name': 'flood_depth_class'
            },
            {
                'layer_name': 'osm_buildings',
                'style_name': 'osm_buildings'
            },
            {
                'layer_name': 'osm_roads',
                'style_name': 'osm_roads'
            },
            {
                'layer_name': 'osm_waterways',
                'style_name': 'osm_waterways_scale'
            }
        ]

        for entry in layer_and_style:
            response = set_style(runner, s, **entry)

            runner.print_response(response)
            if not response.ok:
                break

        exit(not response.ok)
