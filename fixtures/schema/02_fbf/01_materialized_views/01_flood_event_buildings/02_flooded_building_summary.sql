--
-- Name: mv_flooded_building_summary; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--
DROP MATERIALIZED VIEW IF EXISTS public.mv_flooded_building_summary;
CREATE MATERIALIZED VIEW public.mv_flooded_building_summary AS
 SELECT DISTINCT a.flood_event_id,
    a.district_id,
    a.sub_district_id,
    a.village_id,
    a.building_type,
    count(*) OVER (PARTITION BY a.flood_event_id, a.district_id) AS district_count,
    count(*) OVER (PARTITION BY a.flood_event_id, a.sub_district_id) AS sub_district_count,
    count(*) OVER (PARTITION BY a.flood_event_id, a.village_id) AS village_count,
    count(*) OVER (PARTITION BY a.flood_event_id, a.district_id, a.sub_district_id, a.village_id, a.building_type) AS building_type_count,
    sum(a.total_vulnerability) OVER (PARTITION BY a.flood_event_id, a.district_id, a.sub_district_id, a.village_id, a.building_type) AS total_vulnerability_score
   FROM ( SELECT DISTINCT mv_flood_event_buildings.flood_event_id,
            mv_flood_event_buildings.district_id,
            mv_flood_event_buildings.sub_district_id,
            mv_flood_event_buildings.village_id,
            mv_flood_event_buildings.building_id,
            mv_flood_event_buildings.building_type,
            mv_flood_event_buildings.total_vulnerability,
            max(mv_flood_event_buildings.depth_class) AS depth_class
           FROM public.mv_flood_event_buildings
          GROUP BY mv_flood_event_buildings.flood_event_id, mv_flood_event_buildings.district_id, mv_flood_event_buildings.sub_district_id, mv_flood_event_buildings.village_id, mv_flood_event_buildings.building_id, mv_flood_event_buildings.building_type, mv_flood_event_buildings.total_vulnerability) a
  WITH NO DATA;
