CREATE OR REPLACE FUNCTION public.kartoza_evaluate_road_score() RETURNS VARCHAR
    LANGUAGE plpgsql AS
$$
BEGIN
    UPDATE osm_roads
    SET road_type = CASE
                        WHEN "type" ILIKE 'motorway' OR "type" ILIKE 'highway' or "type" ILIKE 'trunk'
                            then 'Motorway or highway'
                        WHEN "type" ILIKE 'motorway_link' then 'Motorway link'
                        WHEN "type" ILIKE 'primary' then 'Primary road'
                        WHEN "type" ILIKE 'primary_link' then 'Primary link'
                        WHEN "type" ILIKE 'tertiary' then 'Tertiary'
                        WHEN "type" ILIKE 'tertiary_link' then 'Tertiary link'
                        WHEN "type" ILIKE 'secondary' then 'Secondary'
                        WHEN "type" ILIKE 'secondary_link' then 'Secondary link'
                        WHEN "type" ILIKE 'living_street' OR "type" ILIKE 'residential' OR "type" ILIKE 'yes'
                            OR "type" ILIKE 'road' OR "type" ILIKE 'unclassified' OR "type" ILIKE 'service'
                            OR "type" ILIKE '' OR "type" IS NULL then 'Road, residential, living street, etc.'
                        WHEN "type" ILIKE 'track' then 'Track'
                        WHEN "type" ILIKE 'cycleway' OR "type" ILIKE 'footpath' OR "type" ILIKE 'pedestrian'
                            OR "type" ILIKE 'footway' OR "type" ILIKE 'path' then 'Cycleway, footpath, etc.'
    END
    WHERE road_type is null;
    UPDATE osm_roads
    SET road_type_score = CASE
                              WHEN road_type = 'Motorway link' THEN 1
                              WHEN road_type = 'Motorway or highway' THEN 0.8
                              WHEN road_type = 'Primary link' THEN 0.7
                              WHEN road_type = 'Primary road' THEN 0.6
                              WHEN road_type = 'Road,residential,living street, etc' THEN 0.2
                              WHEN road_type = 'Secondary' THEN 0.3
                              WHEN road_type = 'Secondary link' THEN 0.3
                              WHEN road_type = 'Tertiary' THEN 0.4
                              WHEN road_type = 'Tertiary link' THEN 0.4
                              WHEN road_type = 'Track' THEN 0.1
        END
    WHERE road_type_score is null;
    RETURN 'OK';
END;
$$;
