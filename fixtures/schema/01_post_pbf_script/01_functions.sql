
--
-- Name: clean_tables(); Type: FUNCTION; Schema: public; Owner: -
--

DROP FUNCTION IF EXISTS public.clean_tables;
CREATE OR REPLACE FUNCTION public.clean_tables() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE osm_tables CURSOR FOR
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema='public'
    AND table_type='BASE TABLE'
    AND table_name LIKE 'osm_%';
BEGIN
    FOR osm_table IN osm_tables LOOP
        EXECUTE 'DELETE FROM ' || quote_ident(osm_table.table_name) || ' WHERE osm_id IN (
            SELECT DISTINCT osm_id
            FROM ' || quote_ident(osm_table.table_name) || '
            LEFT JOIN clip ON ST_Intersects(geometry, geom)
            WHERE clip.ogc_fid IS NULL)
        ;';
    END LOOP;
END;
$$;
