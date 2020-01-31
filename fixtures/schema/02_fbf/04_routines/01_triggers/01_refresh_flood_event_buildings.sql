
--
-- Name: kartoza_refresh_flood_event_buildings_mv(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_refresh_flood_event_buildings_mv CASCADE ;
CREATE FUNCTION public.kartoza_refresh_flood_event_buildings_mv() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY mv_flood_event_buildings WITH DATA ;
    RETURN NULL;
  END
  $$;
