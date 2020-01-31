
--
-- Name: kartoza_building_materials_mapper(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_building_materials_mapper CASCADE;
CREATE FUNCTION public.kartoza_building_materials_mapper() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    SELECT

    CASE
        WHEN new."building:material" ILIKE 'brick%' THEN 0.5
        WHEN new."building:material" = 'concrete' THEN 0.1
        ELSE 0.3
    END
    INTO new.building_material_score
    FROM osm_buildings
    ;
  RETURN NEW;
  END
  $$;
