
--
-- Name: kartoza_refresh_flood_event_buildings_mv(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_refresh_flood_event_buildings_mv CASCADE ;
CREATE FUNCTION public.kartoza_refresh_flood_event_buildings_mv() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW mv_flood_event_buildings WITH DATA ;
    REFRESH MATERIALIZED VIEW mv_flooded_building_summary WITH DATA ;
    REFRESH MATERIALIZED VIEW mv_flood_event_village_summary WITH DATA ;
    REFRESH MATERIALIZED VIEW mv_flood_event_sub_district_summary WITH DATA ;
    REFRESH MATERIALIZED VIEW mv_flood_event_district_summary WITH DATA ;
    RETURN NULL;
  END
  $$;
