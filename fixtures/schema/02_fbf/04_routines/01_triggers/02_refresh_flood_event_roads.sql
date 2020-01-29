
--
-- Name: kartoza_refresh_flood_event_roads_mv(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.kartoza_refresh_flood_event_roads_mv() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY mv_flood_event_roads WITH DATA ;
    RETURN NULL;
  END
  $$;
