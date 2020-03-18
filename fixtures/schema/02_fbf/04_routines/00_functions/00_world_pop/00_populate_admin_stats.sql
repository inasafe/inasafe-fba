CREATE OR REPLACE FUNCTION public.kartoza_populate_world_pop_district_stats() RETURNS VARCHAR
    LANGUAGE plpgsql
AS $$
BEGIN
    insert into world_pop_district_stats
        (prov_code, dc_code, name, pop_count, pop_sum, pop_mean, pop_min, pop_max)
    select
       prov_code,
       dc_code,
       name,
       (stats).count as pop_count,
       (stats).sum as pop_sum,
       (stats).mean as pop_mean,
       (stats).min as pop_min,
       (stats).max as pop_max
    from (select
        st_summarystatsagg(st_clip(rast, geom, true), 1, true) as stats,
        prov_code,
        dc_code,
        name
    from district
    join world_pop on st_intersects(geom, rast)
    group by prov_code, dc_code, name
        ) a ON CONFLICT (dc_code) DO NOTHING;
 RETURN 'OK';
END
$$;


CREATE OR REPLACE FUNCTION public.kartoza_populate_world_pop_sub_district_stats() RETURNS VARCHAR
    LANGUAGE plpgsql
AS $$
BEGIN
    insert into world_pop_sub_district_stats
        (prov_code, dc_code, sub_dc_code, name, pop_count, pop_sum, pop_mean, pop_min, pop_max)
    select
       prov_code,
       dc_code,
       sub_dc_code,
       name,
       (stats).count as pop_count,
       (stats).sum as pop_sum,
       (stats).mean as pop_mean,
       (stats).min as pop_min,
       (stats).max as pop_max
    from (select
        st_summarystatsagg(st_clip(rast, geom, true), 1, true) as stats,
        prov_code,
        dc_code,
        sub_dc_code,
        name
    from sub_district
    join world_pop on st_intersects(geom, rast)
    group by prov_code, dc_code, sub_dc_code, name
        ) a ON CONFLICT (sub_dc_code) DO NOTHING;
 RETURN 'OK';
END
$$;


CREATE OR REPLACE FUNCTION public.kartoza_populate_world_pop_village_stats() RETURNS VARCHAR
    LANGUAGE plpgsql
AS $$
BEGIN
    insert into world_pop_village_stats
        (prov_code, dc_code, sub_dc_code, village_code, name, pop_count, pop_sum, pop_mean, pop_min, pop_max)
    select
       prov_code,
       dc_code,
       sub_dc_code,
       village_code,
       name,
       (stats).count as pop_count,
       (stats).sum as pop_sum,
       (stats).mean as pop_mean,
       (stats).min as pop_min,
       (stats).max as pop_max
    from (select
        st_summarystatsagg(st_clip(rast, geom, true), 1, true) as stats,
        prov_code,
        dc_code,
        sub_dc_code,
        village_code,
        name
    from village
    join world_pop on st_intersects(geom, rast)
    group by prov_code, dc_code, sub_dc_code, village_code,  name
        ) a ON CONFLICT (village_code) DO NOTHING;
 RETURN 'OK';
END
$$;
