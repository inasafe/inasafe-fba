create or replace function kartoza_calculate_impact() returns character varying
    language plpgsql
as
$$
BEGIN
refresh materialized view mv_flood_event_buildings with data;
refresh materialized view mv_flooded_building_summary with data;
refresh materialized view mv_flood_event_village_summary with data;
refresh materialized view mv_flood_event_sub_district_summary with data;
refresh materialized view mv_flood_event_district_summary with data;


refresh materialized view mv_flood_event_roads with data;
refresh materialized view mv_flooded_roads_summary with data;
refresh materialized view mv_flood_event_road_village_summary with data;
refresh materialized view mv_flood_event_road_sub_district_summary with data;
refresh materialized view mv_flood_event_road_district_summary with data;

RETURN 'OK';
END
$$;

