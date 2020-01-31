
--
-- Name: kartoza_refresh_flood_sub_event_summary(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_refresh_flood_sub_event_summary CASCADE ;
CREATE FUNCTION public.kartoza_refresh_flood_sub_event_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW  mv_flood_event_sub_district_summary WITH DATA ;
    RETURN NULL;
  END
  $$;
