CREATE OR REPLACE FUNCTION public.kartoza_evaluate_road_admin() RETURNS VARCHAR
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE osm_roads
    SET
        village_id = v.village_code,
        sub_district_id = s.sub_dc_code,
        district_id = d.dc_code
    FROM
         village v
             JOIN sub_district s ON st_within(v.geom, s.geom)
             JOIN district d ON st_within(s.geom, d.geom)
    WHERE st_within(geometry, v.geom) and village_id is null;
 RETURN 'OK';
END
$$;
