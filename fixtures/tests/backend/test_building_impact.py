
from tests.backend import DatabaseTestCase


class TestBuildingImpact(DatabaseTestCase):

    def test_non_flooded_building_summary(self):
        self.assertSQLResult(
            self.sql_path('mv_non_flooded_building_summary.sql'),
            self.json_path('mv_non_flooded_building_summary.json'),
        )

    def test_flood_exposure_intersections(self):
        self.dbc.conn.autocommit = False
        with self.dbc.conn.cursor() as c:

            # populate hazard event data
            hazard_insert = self.sql_path('hazard.sql')
            self.execute_sql_file(hazard_insert, cursor=c)

            # check building summary


            c.rollback()
