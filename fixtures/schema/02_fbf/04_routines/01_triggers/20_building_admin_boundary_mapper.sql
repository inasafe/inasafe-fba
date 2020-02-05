CREATE OR REPLACE FUNCTION kartoza_building_admin_boundary_mapper() RETURNS trigger
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
           v.village_code, s.sub_dc_code, d.dc_code
    INTO new.village_id, new.sub_district_id, new.district_id
    FROM osm_buildings b
        JOIN village v ON st_within(b.geometry, v.geom)
        JOIN sub_district s ON st_within(b.geometry, s.geom)
        JOIN district d ON st_within(b.geometry, d.geom);
    RETURN NEW;
END
$$;
