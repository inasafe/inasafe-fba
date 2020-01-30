CREATE TABLE IF NOT EXISTS public.osm_admin (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    name character varying,
    type character varying,
    admin_level integer,
    geometry public.geometry(Geometry,4326),
	constraint osm_admin_pkey
		primary key (osm_id, id)
);


--
-- Name: osm_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.osm_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_admin_id_seq OWNED BY public.osm_admin.id;


ALTER TABLE ONLY public.osm_admin ALTER COLUMN id SET DEFAULT nextval('public.osm_admin_id_seq'::regclass);


CREATE INDEX IF NOT EXISTS osm_admin_geom ON public.osm_admin USING gist (geometry);
