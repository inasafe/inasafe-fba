DROP FUNCTION IF EXISTS public.kartoza_fba_global_extent;
CREATE OR REPLACE FUNCTION public.kartoza_fba_global_extent() returns table (x_min double precision, y_min double precision, x_max double precision, y_max double precision)
    LANGUAGE plpgsql
    AS $$
begin return query
    SELECT
    st_xmin((district_extent.extent)::box3d) AS x_min,
    st_ymin((district_extent.extent)::box3d) AS y_min,
    st_xmax((district_extent.extent)::box3d) AS x_max,
    st_ymax((district_extent.extent)::box3d) AS y_max
   FROM ( SELECT
            st_extent(district.geom) AS extent
           FROM district) district_extent;
end;
$$;
