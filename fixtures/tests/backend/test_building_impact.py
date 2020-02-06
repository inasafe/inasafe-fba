from psycopg2.extras import DictCursor

from tests.backend import DatabaseTestCase


class TestBuildingImpact(DatabaseTestCase):

    def test_non_flooded_building_summary(self):
        self.assertSQLResult(
            self.sql_path('mv_non_flooded_building_summary.sql'),
            self.json_path('mv_non_flooded_building_summary.json'),
        )

    def test_flood_exposure_intersections(self):
        self.dbc.conn.autocommit = False
        with self.dbc.conn.cursor(cursor_factory=DictCursor) as c:

            # populate hazard event data
            hazard_insert = self.sql_path('hazard.sql')
            self.execute_sql_file(hazard_insert, cursor=c)

            # check building summary

            def _test_summary_stats(self, results):
                keys_to_check = [
                    'residential',
                    'clinic_dr',
                    'fire_station',
                    'school',
                    'university',
                    'government',
                    'hospital',
                    'police_station',
                    'supermarket',
                    'sports_facility',
                ]
                for row in results:
                    sum_exposed_count = 0
                    sum_total_count = 0
                    for key in keys_to_check:
                        # Do sanity count check
                        # exposed count must less than total count
                        exposed_count = row[
                            '{0}_flooded_building_count'.format(key)]
                        total_count = row[
                            '{0}_building_count'.format(key)]
                        self.assertLessEqual(exposed_count, total_count)
                        sum_exposed_count += exposed_count
                        sum_total_count += total_count

                    # Sanity check
                    # total exposed count must be less or equal from
                    # total exposed count (because there might be
                    # uncategorized building) from the field
                    self.assertLessEqual(
                        sum_exposed_count, row['flooded_building_count'])
                    # Same reason with total count
                self.assertLessEqual(
                    sum_total_count, row['building_count'])

            mv_district_summary = self.sql_path(
                'mv_flood_event_district_summary.sql')
            self.execute_sql_file(mv_district_summary, cursor=c)
            results = c.fetchall()

            _test_summary_stats(self, results)

            mv_sub_district_summary = self.sql_path(
                'mv_flood_event_sub_district_summary.sql')
            self.execute_sql_file(mv_sub_district_summary, cursor=c)
            results = c.fetchall()

            _test_summary_stats(self, results)

            mv_village_summary = self.sql_path(
                'mv_flood_event_village_summary.sql')
            self.execute_sql_file(mv_village_summary, cursor=c)
            results = c.fetchall()

            _test_summary_stats(self, results)

            self.dbc.conn.rollback()
