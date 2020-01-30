CREATE TABLE IF NOT EXISTS public.district (
    id integer NOT NULL,
    geom public.geometry(MultiPolygon,4326),
    prov_code double precision,
    dc_code double precision primary key NOT NULL,
    name character varying(254)
);
CREATE TABLE IF NOT EXISTS public.sub_district (
    id integer NOT NULL,
    geom public.geometry(MultiPolygon,4326),
    prov_code smallint,
    dc_code smallint,
    name character varying(255),
    sub_dc_code numeric primary key NOT NULL
);

CREATE TABLE IF NOT EXISTS public.village (
    id integer NOT NULL ,
    geom public.geometry(MultiPolygon,4326),
    prov_code double precision,
    dc_code double precision,
    sub_dc_code double precision,
    village_code double precision primary key NOT NULL,
    name character varying(254)
);

CREATE INDEX IF NOT EXISTS sidx_sub_district_geom ON public.sub_district USING gist (geom);
CREATE INDEX IF NOT EXISTS sidx_district_geom ON public.district USING gist (geom);
CREATE INDEX IF NOT EXISTS sidx_village_geom ON public.village USING gist (geom);
