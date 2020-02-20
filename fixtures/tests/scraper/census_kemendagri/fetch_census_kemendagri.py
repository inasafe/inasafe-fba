#!/usr/bin/env python3
import os

import sys
from tests.scraper.arcgis_rest_api import ArcGISRESTAPIWrapper


def result_callback(result, event):
    total = event['obj'].total_records
    page = event['page']
    count_per_page = event['params']['resultRecordCount']
    current_records = min((page + 1) * count_per_page, total)
    print('Percentage: {}%\tPage: {}'.format(current_records * 100 // total, page))


if __name__ == '__main__':
    try:
        endpoint = sys.argv[1]
    except:
        endpoint = 'https://gis.dukcapil.kemendagri.go.id/arcgis/rest/services/Data_Baru_26092017/MapServer/4/'
    cur_dir = os.path.dirname(__file__)
    output_dir = os.path.join(cur_dir, '.output')
    os.makedirs(output_dir, exist_ok=True)
    api = ArcGISRESTAPIWrapper(
        endpoint,
        params={
            'f': 'json',
            'where': '1 = 1',
            'outFields': '*'
        },
        output_dir=output_dir,
        output_basename='census_kemendagri',
        result_callback=result_callback
    )

    api.fetch()
