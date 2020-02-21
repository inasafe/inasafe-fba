
CREATE TABLE IF NOT EXISTS public.osm_buildings (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    name character varying,
    leisure character varying,
    height integer,
    "building:levels" character varying,
    "building:height" integer,
    "building:min_level" integer,
    "roof:height" integer,
    "roof:material" character varying,
    "building:material" character varying,
    use character varying,
    religion character varying,
    type character varying,
    amenity character varying,
    landuse character varying,
    geometry public.geometry(Geometry,4326),
    constraint osm_buildings_pkey
        primary key (osm_id)
);


--
-- Name: osm_buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.osm_buildings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_buildings_id_seq OWNED BY public.osm_buildings.id;


ALTER TABLE ONLY public.osm_buildings ALTER COLUMN id SET DEFAULT nextval('public.osm_buildings_id_seq'::regclass);


CREATE INDEX IF NOT EXISTS osm_buildings_geom ON public.osm_buildings USING gist (geometry);
