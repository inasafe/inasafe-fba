
--
-- Name: kartoza_building_recode_mapper(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_building_recode_mapper CASCADE ;
CREATE FUNCTION public.kartoza_building_recode_mapper() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
     SELECT

        CASE
            WHEN new.building_type = 'Clinic/Doctor' THEN 0.7
            WHEN new.building_type = 'Commercial' THEN 0.7
            WHEN new.building_type = 'School' THEN 1
            WHEN new.building_type = 'Government' THEN 0.7
            WHEN new.building_type ILIKE 'Place of Worship%' THEN 0.5
            WHEN new.building_type = 'Residential' THEN 1
            WHEN new.building_type = 'Police Station' THEN 0.7
            WHEN new.building_type = 'Fire Station' THEN 0.7
            WHEN new.building_type = 'Hospital' THEN 0.7
            WHEN new.building_type = 'Supermarket' THEN 0.7
            WHEN new.building_type = 'Sports Facility' THEN 0.3
            WHEN new.building_type = 'University/College' THEN 1.0
            ELSE 0.3
        END
     INTO new.building_type_score
     FROM osm_buildings
    ;
  RETURN NEW;
  END
  $$;
