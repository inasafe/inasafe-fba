
--
-- Name: kartoza_road_type_mapping(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_road_type_mapping CASCADE ;
CREATE FUNCTION public.kartoza_road_type_mapping() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    SELECT
    CASE
           WHEN new."type" ILIKE 'motorway' OR new."type" ILIKE 'highway' or new."type" ILIKE 'trunk'
               then 'Motorway or highway'
           WHEN new."type" ILIKE 'motorway_link' then 'Motorway link'
           WHEN new."type" ILIKE 'primary' then 'Primary road'
           WHEN new."type" ILIKE 'primary_link' then 'Primary link'
           WHEN new."type" ILIKE 'tertiary' then 'Tertiary'
           WHEN new."type" ILIKE 'tertiary_link' then 'Tertiary link'
           WHEN new."type" ILIKE 'secondary' then 'Secondary'
           WHEN new."type" ILIKE 'secondary_link' then 'Secondary link'
           WHEN new."type" ILIKE 'living_street' OR new."type" ILIKE 'residential' OR new."type" ILIKE 'yes'
                    OR new."type" ILIKE 'road' OR new."type" ILIKE 'unclassified' OR new."type" ILIKE 'service'
           OR new."type" ILIKE '' OR new."type" IS NULL then 'Road, residential, living street, etc.'
           WHEN new."type" ILIKE 'track' then 'Track'
           WHEN new."type" ILIKE 'cycleway' OR new."type" ILIKE 'footpath' OR new."type" ILIKE 'pedestrian'
                    OR new."type" ILIKE 'footway' OR new."type" ILIKE 'path' then 'Cycleway, footpath, etc.'
        END
    INTO new.road_type
    FROM osm_roads
    ;
  RETURN NEW;
  END
  $$;
