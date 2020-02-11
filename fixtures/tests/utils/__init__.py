from contextlib import contextmanager
import psycopg2
import os
import requests


class DBConnection:

    def __init__(self):
        self.conn = DBConnection.create_conn()

    def table_exists(self, table_name, table_schema='public'):
        cur = self.conn.cursor()
        query = (
            'select '
            'exists('
            'select 1 '
            'from information_schema.tables '
            'where table_name = %s and table_schema = %s)')
        cur.execute(query, (table_name, table_schema))
        try:
            row = cur.fetchone()
            return row[0]
        except:
            return False

    @staticmethod
    def create_conn():
        """
        :return: psycopg2.connection
        """
        return psycopg2.connect(
            host=os.environ.get('POSTGRES_HOST'),
            database=os.environ.get('POSTGRES_DB'),
            user=os.environ.get('POSTGRES_USER'),
            password=os.environ.get('POSTGRES_PASS'),
            port=os.environ.get('POSTGRES_PORT')
        )

    def cursor(self):
        return self.conn.cursor()


class GeoServerRESTRunner:

    def __init__(self):
        self.user = os.environ.get('GEOSERVER_ADMIN_USER')
        self.password = os.environ.get('GEOSERVER_ADMIN_PASSWORD')
        self.geoserver_base_url = os.environ.get('GEOSERVER_BASE_URL')
        self.rest_url = '{geoserver_base_url}/rest'.format(
            geoserver_base_url=self.geoserver_base_url
        )

    @property
    def auth_tuple(self):
        return self.user, self.password

    def session(self):
        session = requests.Session()
        # first log in
        response = session.get(self.rest_url, auth=self.auth_tuple)
        if not response.ok:
            raise Exception('GeoServer Authentication failed.\n' + response.text)
        return session

    def rest_path(self, path):
        return '{endpoint}{path}'.format(endpoint=self.rest_url, path=path)

    @classmethod
    def print_response(cls, response):
        print('Status Code: {}'.format(response.status_code))
        print('Content:\n{}'.format(response.text))
        print()

    def assert_get(
            self, session, path, data=None, json=None, headers=None,
            validate=False):
        _headers = {
            'Content-type': 'text/json'
        }
        _headers.update(headers or {})
        headers = _headers
        kwargs = {
            'url': self.rest_path(path),
            'data': data,
            'json': json,
            'headers': headers,
            'auth': self.auth_tuple
        }
        response = session.get(**kwargs)
        if not response.ok and validate:
            raise Exception(
                'Request failed with:\n'
                'method: get\n'
                'url: {url}\n'
                'data: {data}\n'
                'json: {json}\n'
                'headers: {headers}\n\n'.format(**kwargs)
            )
        return response

    def assert_post(
            self, session, path, data=None, json=None, headers=None,
            validate=False):
        _headers = {
            'Content-type': 'text/json'
        }
        _headers.update(headers or {})
        headers = _headers
        kwargs = {
            'url': self.rest_path(path),
            'data': data,
            'json': json,
            'headers': headers,
            'auth': self.auth_tuple
        }
        response = session.post(**kwargs)
        if not response.ok and validate:
            raise Exception(
                'Request failed with:\n'
                'method: post\n'
                'url: {url}\n'
                'data: {data}\n'
                'json: {json}\n'
                'headers: {headers}\n'
                'Content: {text}'
                'Status code: {status_code}\n'.format(
                    status_code=response.status_code,
                    text=response.text,
                    **kwargs)
            )
        return response

    def assert_put(
            self, session, path, data=None, json=None, headers=None,
            validate=False):
        _headers = {
            'Content-type': 'text/json'
        }
        _headers.update(headers or {})
        headers = _headers
        kwargs = {
            'url': self.rest_path(path),
            'data': data,
            'json': json,
            'headers': headers,
            'auth': self.auth_tuple
        }
        response = session.put(**kwargs)
        if not response.ok and validate:
            raise Exception(
                'Request failed with:\n'
                'method: post\n'
                'url: {url}\n'
                'data: {data}\n'
                'json: {json}\n'
                'headers: {headers}\n'
                'Content: {text}'
                'Status code: {status_code}\n'.format(
                    status_code=response.status_code,
                    text=response.text,
                    **kwargs)
            )
        return response
