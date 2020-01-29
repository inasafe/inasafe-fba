--
-- Name: hazard_area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hazard_area (
    id integer NOT NULL,
    depth_class integer,
    geometry public.geometry(MultiPolygon,4326)
);


--
-- Name: flooded_area_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.flooded_area_id_seq
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
-- Name: hazard_area flooded_area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_area
    ADD CONSTRAINT flooded_area_pkey PRIMARY KEY (id);

--
-- Name: flooded_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flooded_area_id ON public.hazard_area USING btree (id);

--
-- Name: flooded_area_idx_geometry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flooded_area_idx_geometry ON public.hazard_area USING gist (geometry);

--
-- Name: hazard_area flooded_area_depth_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_area
    ADD CONSTRAINT flooded_area_depth_class_fkey FOREIGN KEY (depth_class) REFERENCES public.hazard_class(id);
