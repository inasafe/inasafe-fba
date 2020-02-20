import json
import os

import requests
from urllib.parse import urlparse, urljoin


class ArcGISRESTAPIWrapper:

    def __init__(
            self,
            endpoint=None,
            credentials=None,
            params=None,
            output_dir=None,
            output_basename=None,
            result_callback=None):
        self.endpoint = endpoint
        self.credentials = credentials
        self.params = params
        self.output_dir = output_dir
        self.output_basename = output_basename
        self.result_callback = result_callback
        self.capabilities = {}
        self.total_records = 0
        self.limit = 0

    def setup(self):
        # check capabilities
        params = {
            'f': 'json'
        }
        response = requests.get(self.endpoint, params=params)
        self.capabilities = response.json()
        advanced_query_capabilities = self.capabilities[
            'advancedQueryCapabilities']

        # find total records
        if advanced_query_capabilities.get('supportsPagination', False):
            params = {
                'f': 'json',
                'where': '1 = 1',
                'returnCountOnly': 'true'
            }
            params.update(self.params)

            query_endpoint = urljoin(self.endpoint, 'query')
            response = requests.post(query_endpoint, data=params)
            result = response.json()
            self.total_records = result['count']
            self.limit = self.capabilities['maxRecordCount']

    def _fetch(self, params, page, total_page=None):
        """Single request fetch"""
        query_endpoint = urljoin(self.endpoint, 'query')
        response = requests.post(query_endpoint, data=params)
        result = response.json()

        total_digits = len(str(total_page))
        if self.output_dir and self.output_basename:
            basename = os.path.join(
                self.output_dir, self.output_basename)
            filename = '{basename}.{page}.json'.format(
                basename=basename,
                page=str(page).zfill(total_digits))
            with open(filename, 'w') as f:
                json.dump(result, f, indent=4, sort_keys=True)

        if self.result_callback:
            event = {
                'obj': self,
                'params': params,
                'url': self.endpoint,
                'page': page
            }
            self.result_callback(result, event)

    def fetch(self, fetch_limit=None, count_per_page=None):
        self.setup()

        min_records = min(
            self.total_records, fetch_limit or self.total_records)
        limit = count_per_page or self.limit

        # in case result exceed max record count
        if min_records > limit:
            num_page = min_records // limit
            num_page += 1 if min_records % limit > 0 else 0

            for p in range(num_page):
                offset = p * limit
                new_params = {
                    'f': 'json',
                    'outFields': '*',
                }
                new_params.update(self.params)
                new_params.update({
                    'resultRecordCount': limit,
                    'resultOffset': offset
                })
                self._fetch(new_params, p, total_page=num_page)

        else:
            new_params = {}
            new_params.update(self.params)
            new_params.update({
                'resultRecordCount': limit
            })
            self._fetch(self.params, 0)
