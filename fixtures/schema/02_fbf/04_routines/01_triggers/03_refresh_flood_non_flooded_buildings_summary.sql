
--
-- Name: kartoza_refresh_flood_non_flooded_building_summary(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_refresh_flood_non_flooded_building_summary CASCADE ;
CREATE FUNCTION public.kartoza_refresh_flood_non_flooded_building_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    REFRESH MATERIALIZED VIEW  mv_non_flooded_building_summary WITH DATA ;
    RETURN NULL;
  END
  $$;
