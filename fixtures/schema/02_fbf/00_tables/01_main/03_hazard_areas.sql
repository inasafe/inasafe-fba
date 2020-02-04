--
-- Name: hazard_areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.hazard_areas (
    id integer NOT NULL,
    flood_map_id integer,
    flooded_area_id integer,
    CONSTRAINT flooded_areas_pkey PRIMARY KEY (id),
    CONSTRAINT flooded_areas_flood_map_id_fkey FOREIGN KEY (flood_map_id) REFERENCES public.hazard_map(id),
    CONSTRAINT flooded_areas_flooded_area_id_fkey FOREIGN KEY (flooded_area_id) REFERENCES public.hazard_area(id)
);


--
-- Name: flooded_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.flooded_areas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flooded_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.flooded_areas_id_seq OWNED BY public.hazard_areas.id;

--
-- Name: hazard_areas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_areas ALTER COLUMN id SET DEFAULT nextval('public.flooded_areas_id_seq'::regclass);
