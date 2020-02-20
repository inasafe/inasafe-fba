#!/usr/bin/env python3
import json
import os

import sys

from urllib.parse import urljoin

import requests


def send_data(output_dir, endpoint, headers=None, file_process_callback=None):
    user_headers = headers
    headers = {
        'Content-Type': 'application/json',
        'Prefer': 'resolution=ignore-duplicates,return=representation'
    }
    headers.update(user_headers)
    for root, dirs, files in os.walk(output_dir):
        for file in sorted(files):
            if file.endswith('.json'):
                print('Processing: {}'.format(file))
                with open(os.path.join(root, file)) as f:
                    result = json.load(f)
                    features = result['features']

                    accepted_keys = [
                        'objectid',
                        'no_prop',
                        'no_kab',
                        'no_kec',
                        'no_kel',
                        'kode_desa_',
                        'nama_prop_',
                        'nama_kab_s',
                        'nama_kec_s',
                        'nama_kel_s',
                        'jumlah_pen',
                        'jumlah_kk',
                        'pria',
                        'wanita',
                        'u0',
                        'u5'
                        'u10',
                        'u15',
                        'u20',
                        'u25',
                        'u30',
                        'u35',
                        'u40',
                        'u45',
                        'u50',
                        'u55',
                        'u60',
                        'u65',
                        'u70',
                        'u75',
                        'p01_belum_',
                    ]
                    collected_features = []
                    for feature in features:
                        filtered_feature = dict([
                            (k, v)
                            for k, v in feature['attributes'].items()
                            if k in accepted_keys])
                        collected_features.append(filtered_feature)

                    # send over postgrest
                    response = requests.post(
                        endpoint,
                        json=collected_features,
                        headers=headers)

                    if not response.ok:
                        raise Exception(response.text)

                    if file_process_callback:
                        event = {
                            'features': collected_features,
                            'response': response,
                            'filename': file
                        }
                        file_process_callback(event)


if __name__ == '__main__':
    try:
        postgrest_base_url = sys.argv[1]
    except:
        postgrest_base_url = os.environ.get(
            'POSTGREST_BASE_URL', 'http://fbf.test/api')
    cur_dir = os.path.dirname(__file__)
    output_dir = os.path.join(cur_dir, '.output')
    basename = 'census_kemendagri'
    endpoint = urljoin(postgrest_base_url+'/', 'census_kemendagri')
    # Add return filter
    endpoint = '{endpoint}?select=objectid'.format(endpoint=endpoint)
    headers = {
        'Content-Type': 'application/json',
        'Prefer': 'resolution=ignore-duplicates,return=representation'
    }

    def _file_process_callback(event):
        print('Process file done: {}'.format(event['filename']))
        print()

    send_data(
        output_dir, endpoint, headers,
        file_process_callback=_file_process_callback)
