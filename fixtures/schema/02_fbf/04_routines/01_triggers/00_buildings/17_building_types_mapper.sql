
--
-- Name: kartoza_building_types_mapper(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_building_types_mapper CASCADE ;
CREATE FUNCTION public.kartoza_building_types_mapper() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    SELECT
    CASE
           WHEN new.amenity ILIKE '%school%' OR new.amenity ILIKE '%kindergarten%' THEN 'School'
           WHEN new.amenity ILIKE '%university%' OR new.amenity ILIKE '%college%' THEN 'University/College'
           WHEN new.amenity ILIKE '%government%' THEN 'Government'
           WHEN new.amenity ILIKE '%clinic%' OR new.amenity ILIKE '%doctor%' THEN 'Clinic/Doctor'
           WHEN new.amenity ILIKE '%hospital%' THEN 'Hospital'
           WHEN new.amenity ILIKE '%fire%' THEN 'Fire Station'
           WHEN new.amenity ILIKE '%police%' THEN 'Police Station'
           WHEN new.amenity ILIKE '%public building%' THEN 'Public Building'
           WHEN new.amenity ILIKE '%worship%' and (religion ILIKE '%islam' or religion ILIKE '%muslim%')
               THEN 'Place of Worship - Islam'
           WHEN new.amenity ILIKE '%worship%' and new.religion ILIKE '%budd%' THEN 'Place of Worship - Buddhist'
           WHEN new.amenity ILIKE '%worship%' and new.religion ILIKE '%unitarian%' THEN 'Place of Worship - Unitarian'
           WHEN new.amenity ILIKE '%mall%' OR new.amenity ILIKE '%market%' THEN 'Supermarket'
           WHEN new.landuse ILIKE '%residential%' OR new.use = 'residential' THEN 'Residential'
           WHEN new.landuse ILIKE '%recreation_ground%' OR new.leisure IS NOT NULL AND new.leisure != '' THEN 'Sports Facility'
           -- run near the end
           WHEN new.amenity = 'yes' THEN 'Residential'
           WHEN new.use = 'government' AND new."type" IS NULL THEN 'Government'
           WHEN new.use = 'residential' AND new."type" IS NULL THEN 'Residential'
           WHEN new.use = 'education' AND new."type" IS NULL THEN 'School'
           WHEN new.use = 'medical' AND new."type" IS NULL THEN 'Clinic/Doctor'
           WHEN new.use = 'place_of_worship' AND new."type" IS NULL THEN 'Place of Worship'
           WHEN new.use = 'school' AND new."type" IS NULL THEN 'School'
           WHEN new.use = 'hospital' AND new."type" IS NULL THEN 'Hospital'
           WHEN new.use = 'commercial' AND new."type" IS NULL THEN 'Commercial'
           WHEN new.use = 'industrial' AND new."type" IS NULL THEN 'Industrial'
           WHEN new.use = 'utility' AND new."type" IS NULL THEN 'Utility'
           -- Add default type
           WHEN new."type" IS NULL THEN 'Residential'
        END
    INTO new.building_type
    FROM osm_buildings
    ;
  RETURN NEW;
  END
  $$;
