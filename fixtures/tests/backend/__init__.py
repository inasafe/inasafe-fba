import time
import unittest

import psycopg2

from utils import DBConnection


class TestBackendReady(unittest.TestCase):

    def setUp(self):
        # wait until db ready
        self.dbc = None
        while not self.dbc:
            try:
                self.dbc = DBConnection()
            except psycopg2.OperationalError:
                time.sleep(1)

    def test_table_exists(self):
        self.assertTrue(
            self.dbc.table_exists('osm_buildings'))
        self.assertTrue(
            self.dbc.table_exists('osm_roads'))

    def tearDown(self):
        self.dbc.conn.close()
