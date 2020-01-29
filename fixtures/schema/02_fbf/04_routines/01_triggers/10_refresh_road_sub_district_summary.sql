
--
-- Name: kartoza_refresh_road_sub_district_summary(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.kartoza_refresh_road_sub_district_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW  mv_flood_event_road_sub_district_summary WITH DATA ;
    RETURN NULL;
  END
  $$;
