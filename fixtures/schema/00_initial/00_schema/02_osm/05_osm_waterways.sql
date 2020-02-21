
CREATE TABLE IF NOT EXISTS public.osm_waterways (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    name character varying,
    waterway character varying,
    geometry public.geometry(LineString,4326),
    CONSTRAINT osm_waterways_pkey
        PRIMARY KEY (osm_id, id)
);


--
-- Name: osm_waterways_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.osm_waterways_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_waterways_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_waterways_id_seq OWNED BY public.osm_waterways.id;


ALTER TABLE ONLY public.osm_waterways ALTER COLUMN id SET DEFAULT nextval('public.osm_waterways_id_seq'::regclass);


CREATE INDEX IF NOT EXISTS osm_waterways_geom ON public.osm_waterways USING gist (geometry);

