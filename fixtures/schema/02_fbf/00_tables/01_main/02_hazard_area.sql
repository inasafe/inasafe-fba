--
-- Name: hazard_area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.hazard_area (
    id integer NOT NULL,
    depth_class integer,
    geometry public.geometry(MultiPolygon,4326),
    CONSTRAINT flooded_area_depth_class_fkey FOREIGN KEY (depth_class) REFERENCES public.hazard_class(id),
    CONSTRAINT flooded_area_pkey PRIMARY KEY (id)
);


--
-- Name: flooded_area_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.flooded_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flooded_area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.flooded_area_id_seq OWNED BY public.hazard_area.id;

--
-- Name: hazard_area id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_area ALTER COLUMN id SET DEFAULT nextval('public.flooded_area_id_seq'::regclass);


--
-- Name: flooded_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX IF NOT EXISTS flooded_area_id ON public.hazard_area USING btree (id);

--
-- Name: flooded_area_idx_geometry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX IF NOT EXISTS flooded_area_idx_geometry ON public.hazard_area USING gist (geometry);
