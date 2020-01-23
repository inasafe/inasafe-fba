-- Will remove this section later to be part of pg docker run
CREATE TABLE public.district (
    id integer NOT NULL,
    geom public.geometry(MultiPolygon,4326),
    prov_code double precision,
    dc_code double precision primary key NOT NULL,
    name character varying(254)
);
CREATE TABLE public.sub_district (
    id integer NOT NULL,
    geom public.geometry(MultiPolygon,4326),
    prov_code smallint,
    dc_code smallint,
    name character varying(255),
    sub_dc_code numeric primary key NOT NULL
);

CREATE TABLE public.village (
    id integer NOT NULL ,
    geom public.geometry(MultiPolygon,4326),
    prov_code double precision,
    dc_code double precision,
    sub_dc_code double precision,
    village_code double precision primary key NOT NULL,
    name character varying(254)
);

CREATE INDEX sidx_sub_district_geom ON public.sub_district USING gist (geom);
CREATE INDEX sidx_district_geom ON public.district USING gist (geom);
CREATE INDEX sidx_village_geom ON public.village USING gist (geom);


-- Alter tables to add all the fba goodies
ALTER table osm_buildings add column building_type character varying (100);
ALTER table osm_buildings add column building_type_score double precision;
ALTER table osm_buildings add column building_area  double precision;
ALTER TABLE osm_buildings add column building_area_score double precision;
ALTER table osm_buildings add column building_material_score double precision;
ALTER TABLE osm_buildings add column building_road_length double precision;
ALTER TABLE osm_buildings add column building_road_density_score double precision;
ALTER table osm_buildings add column total_vulnerability double precision;
ALTER table osm_buildings add column village_id double precision references village (village_code);
ALTER table osm_buildings add column sub_district_id numeric references  sub_district(sub_dc_code);
ALTER table osm_buildings add column district_id double precision references public.district (dc_code);
ALTER TABLE osm_buildings add column building_road_density integer;
ALTER TABLE osm_buildings add column building_id integer;
ALTER TABLE osm_roads add column road_type character varying (50);
ALTER TABLE osm_roads add column road_type_score numeric;
ALTER table osm_roads add column road_id integer;
ALTER table osm_roads add column village_id double precision references village (village_code);
ALTER table osm_roads add column sub_district_id numeric references  sub_district(sub_dc_code);
ALTER table osm_roads add column district_id double precision references public.district (dc_code);
ALTER table osm_waterways add column waterway_id integer;
