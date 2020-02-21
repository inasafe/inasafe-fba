
CREATE TABLE IF NOT EXISTS public.osm_roads (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    type character varying,
    name character varying,
    oneway smallint,
    z_order integer,
    service character varying,
    class character varying,
    geometry public.geometry(LineString,4326),
    constraint osm_roads_pkey
        primary key (osm_id, id)

);


--
-- Name: osm_roads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.osm_roads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_roads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_roads_id_seq OWNED BY public.osm_roads.id;


ALTER TABLE ONLY public.osm_roads ALTER COLUMN id SET DEFAULT nextval('public.osm_roads_id_seq'::regclass);



CREATE INDEX IF NOT EXISTS osm_roads_geom ON public.osm_roads USING gist (geometry);
