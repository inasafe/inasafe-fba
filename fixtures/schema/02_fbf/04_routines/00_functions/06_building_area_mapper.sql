
--
-- Name: kartoza_building_area_mapper(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.kartoza_building_area_mapper() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.building_area:=ST_Area(new.geometry::GEOGRAPHY) ;
  RETURN NEW;
  END
  $$;
