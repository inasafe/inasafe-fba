
--
-- Name: kartoza_refresh_flooded_roads_summary_mv(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.kartoza_refresh_flooded_roads_summary_mv() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY mv_flooded_roads_summary WITH DATA ;
    RETURN NULL;
  END
  $$;
