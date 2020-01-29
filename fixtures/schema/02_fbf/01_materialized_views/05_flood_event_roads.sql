--
-- Name: mv_flood_event_roads; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.mv_flood_event_roads AS
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
    b.osm_id AS road_id,
    a.flood_event_id,
    a.depth_class,
    b.district_id,
    b.sub_district_id,
    b.village_id,
    b.road_type,
    b.road_type_score AS total_vulnerability,
    b.geometry
   FROM (intersections a
     JOIN public.osm_roads b ON (public.st_intersects(a.geometry, b.geometry)))
  WITH NO DATA;
