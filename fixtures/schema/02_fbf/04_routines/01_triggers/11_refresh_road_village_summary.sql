
--
-- Name: kartoza_refresh_road_village_summary(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_refresh_road_village_summary CASCADE ;
CREATE FUNCTION public.kartoza_refresh_road_village_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW  mv_flood_event_road_village_summary WITH DATA ;
    RETURN NULL;
  END
  $$;
