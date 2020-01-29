
--
-- Name: kartoza_refresh_flooded_building_summary(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.kartoza_refresh_flooded_building_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW  mv_flooded_building_summary WITH DATA ;
    RETURN NULL;
  END
  $$;
