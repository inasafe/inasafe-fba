import csv
import json
import os
import time
import unittest

import psycopg2

from tests.utils import DBConnection


class DatabaseTestCase(unittest.TestCase):

    def setUp(self):
        # wait until db ready
        self.dbc = None
        while not self.dbc:
            try:
                self.dbc = DBConnection()
            except psycopg2.OperationalError:
                time.sleep(1)

    def tearDown(self):
        self.dbc.conn.close()

    @classmethod
    def _test_data_path(cls, *args):
        return os.path.join(
            os.path.dirname(__file__),
            'data',
            *args)

    @classmethod
    def sql_path(cls, *args):
        return cls._test_data_path('sql', *args)

    @classmethod
    def json_path(cls, *args):
        return cls._test_data_path('json', *args)

    def execute_sql_file(self, sql_file, cursor=None):
        def _execute_sql_file(cursor):
            with open(sql_file) as f:
                cursor.execute(f.read())
                return cursor
        if not cursor:
            with self.dbc.cursor() as c:
                return _execute_sql_file(c)
        else:
            return _execute_sql_file(cursor)

    def assertSQLResult(self, sql_file, csv_file, cursor=None):
        def _compare_with_cursor(c):
            with open(sql_file) as f:
                c.execute(f.read())
                sql_results = c.fetchall()
                sql_results = iter(sql_results)
                with open(csv_file) as j:
                    json_results = json.load(j)
                    for row in iter(json_results):
                        sql_row = list(next(sql_results))
                        json_row = [
                            row[c.description[index].name]
                            for index in range(len(c.description))
                        ]
                        self.assertEqual(sql_row, json_row)

        if not cursor:
            with self.dbc.cursor() as current_cursor:
                _compare_with_cursor(current_cursor)
        else:
            _compare_with_cursor(cursor)


class TestBackendReady(DatabaseTestCase):

    def test_00_table_exists(self):
        self.assertTrue(
            self.dbc.table_exists('osm_buildings'))
        self.assertTrue(
            self.dbc.table_exists('osm_roads'))

    def test_01_osm_tables_content(self):
        with self.dbc.conn.cursor() as cursor:
            cursor.execute('select count(*) from osm_buildings')
            row = cursor.fetchone()
            self.assertTrue(row[0])

        with self.dbc.conn.cursor() as cursor:
            cursor.execute('select count(*) from osm_roads')
            row = cursor.fetchone()
            self.assertTrue(row[0])
