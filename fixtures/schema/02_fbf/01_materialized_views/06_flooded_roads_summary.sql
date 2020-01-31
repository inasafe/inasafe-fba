--
-- Name: mv_flooded_roads_summary; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--
DROP MATERIALIZED VIEW IF EXISTS public.mv_flooded_roads_summary;
CREATE MATERIALIZED VIEW public.mv_flooded_roads_summary AS
 SELECT DISTINCT a.flood_event_id,
    a.district_id,
    a.sub_district_id,
    a.village_id,
    a.road_type,
    count(*) OVER (PARTITION BY a.flood_event_id, a.district_id) AS district_count,
    count(*) OVER (PARTITION BY a.flood_event_id, a.sub_district_id) AS sub_district_count,
    count(*) OVER (PARTITION BY a.flood_event_id, a.village_id) AS village_count,
    count(*) OVER (PARTITION BY a.flood_event_id, a.district_id, a.sub_district_id, a.village_id, a.road_type) AS road_type_count,
    sum(a.total_vulnerability) OVER (PARTITION BY a.flood_event_id, a.district_id, a.sub_district_id, a.village_id, a.road_type) AS total_vulnerability_score
   FROM ( SELECT DISTINCT mv_flood_event_roads.flood_event_id,
            mv_flood_event_roads.district_id,
            mv_flood_event_roads.sub_district_id,
            mv_flood_event_roads.village_id,
            mv_flood_event_roads.road_id,
            mv_flood_event_roads.road_type,
            mv_flood_event_roads.total_vulnerability,
            max(mv_flood_event_roads.depth_class) AS depth_class
           FROM public.mv_flood_event_roads
          GROUP BY mv_flood_event_roads.flood_event_id, mv_flood_event_roads.district_id, mv_flood_event_roads.sub_district_id, mv_flood_event_roads.village_id, mv_flood_event_roads.road_id, mv_flood_event_roads.road_type, mv_flood_event_roads.total_vulnerability) a
  WITH NO DATA;
