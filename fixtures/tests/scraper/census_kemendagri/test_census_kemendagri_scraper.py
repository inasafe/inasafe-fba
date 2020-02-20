import json
import os
import unittest

import requests
from tests.scraper.arcgis_rest_api import ArcGISRESTAPIWrapper
from tests.scraper.census_kemendagri.consume_rest_result import send_data
from urllib.parse import urljoin


class TestFetchDataSet(unittest.TestCase):

    @classmethod
    def fixture_path(cls, *args):
        return os.path.join(os.path.dirname(__file__), 'data', *args)

    @classmethod
    def json_path(cls, *args):
        return cls.fixture_path('json', *args)

    @classmethod
    def sql_path(cls, *args):
        return cls.fixture_path('sql', *args)

    def setUp(self):
        self.postgrest_url = os.environ.get('POSTGREST_BASE_URL')
        self.endpoint = 'https://gis.dukcapil.kemendagri.go.id/arcgis/rest/services/Data_Baru_26092017/MapServer/4/'
        cur_dir = os.path.dirname(__file__)
        self.output_dir = os.path.join(cur_dir, '.test-output')
        os.makedirs(self.output_dir, exist_ok=True)

    def test_scrape_and_populate(self):
        # Test fetching data
        # Filter by our village name only
        with open(self.json_path('village_name.json')) as f:
            villages = json.load(f)

        name_list = ','.join(
            ["'{}'".format(o['nama_kel_s']) for o in villages])

        where_query = 'nama_kel_s IN ({})'.format(name_list)

        def _assertResult(result, event):
            self.assertTrue(result)
            self.assertTrue(result['features'])

        api = ArcGISRESTAPIWrapper(
            self.endpoint,
            params={
                'f': 'json',
                'where': where_query,
                'outFields': '*'
            },
            output_dir=self.output_dir,
            output_basename='census_kemendagri',
            result_callback=_assertResult
        )
        api.fetch()

        # Populate from directory
        endpoint = urljoin(self.postgrest_url+'/', 'census_kemendagri')
        name_list = ','.join(
            [o['nama_kel_s'] for o in villages])
        name_query = 'nama_kel_s=in.({})'.format(name_list)
        endpoint = '{endpoint}?select=objectid&{name_query}'.format(
            endpoint=endpoint,
            name_query=name_query)
        headers = {
            'Content-Type': 'application/json',
            'Prefer': 'resolution=ignore-duplicates,return=representation'
        }

        send_data(
            self.output_dir,
            endpoint,
            headers)

        response = requests.get(endpoint)
        self.assertTrue(response.ok)
        result = response.json()
        self.assertTrue(result)
