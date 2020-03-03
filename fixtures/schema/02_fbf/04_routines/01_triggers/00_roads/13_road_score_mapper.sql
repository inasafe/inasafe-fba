CREATE OR REPLACE FUNCTION kartoza_road_score_mapper () RETURNS trigger LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        CASE
            WHEN new.road_type = 'Motorway link' THEN 1
            WHEN new.road_type = 'Motorway or highway' THEN 0.8
            WHEN new.road_type = 'Primary link' THEN 0.7
            WHEN new.road_type = 'Primary road' THEN 0.6
            WHEN new.road_type = 'Road,residential,living street, etc' THEN 0.2
            WHEN new.road_type = 'Secondary' THEN 0.3
            WHEN new.road_type = 'Secondary link' THEN 0.3
            WHEN new.road_type = 'Tertiary' THEN 0.4
            WHEN new.road_type = 'Tertiary link' THEN 0.4
            WHEN new.road_type = 'Track' THEN 0.1
            END
    INTO new.road_type_score
    FROM osm_buildings
    ;
    RETURN NEW;
END
$$;
