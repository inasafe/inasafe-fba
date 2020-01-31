--
-- Name: mv_flood_event_buildings; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--
DROP MATERIALIZED VIEW IF EXISTS public.mv_flood_event_buildings CASCADE;
CREATE MATERIALIZED VIEW public.mv_flood_event_buildings AS
 WITH intersections AS (
         SELECT a_1.geometry,
            d.id AS flood_event_id,
            a_1.depth_class
           FROM (((public.hazard_area a_1
             JOIN public.hazard_areas b_1 ON ((a_1.id = b_1.flooded_area_id)))
             JOIN public.hazard_map c ON ((c.id = b_1.flood_map_id)))
             JOIN public.hazard_event d ON ((d.flood_map_id = c.id)))
        )
 SELECT row_number() OVER () AS id,
    b.osm_id AS building_id,
    a.flood_event_id,
    a.depth_class,
    b.district_id,
    b.sub_district_id,
    b.village_id,
    b.building_type,
    b.total_vulnerability,
    b.geometry
   FROM (intersections a
     JOIN public.osm_buildings b ON (public.st_intersects(a.geometry, b.geometry)))
  WHERE (b.building_area < (7000)::numeric)
  WITH NO DATA;
