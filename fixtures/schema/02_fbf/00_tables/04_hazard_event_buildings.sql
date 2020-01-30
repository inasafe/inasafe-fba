--
-- Name: hazard_event_buildings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.hazard_event_buildings (
    id integer NOT NULL,
    flood_event_id integer,
    building_id integer,
    depth_class_id integer
);


--
-- Name: flood_event_buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.flood_event_buildings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flood_event_buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.flood_event_buildings_id_seq OWNED BY public.hazard_event_buildings.id;

--
-- Name: hazard_event_buildings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_event_buildings ALTER COLUMN id SET DEFAULT nextval('public.flood_event_buildings_id_seq'::regclass);


--
-- Name: hazard_event_buildings flood_event_buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_event_buildings
    ADD CONSTRAINT flood_event_buildings_pkey PRIMARY KEY (id);


--
-- Name: hazard_event_buildings flood_event_buildings_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_event_buildings
    ADD CONSTRAINT flood_event_buildings_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.osm_buildings(osm_id);


--
-- Name: hazard_event_buildings flood_event_buildings_depth_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_event_buildings
    ADD CONSTRAINT flood_event_buildings_depth_class_id_fkey FOREIGN KEY (depth_class_id) REFERENCES public.hazard_class(id);


--
-- Name: hazard_event_buildings flood_event_buildings_flood_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_event_buildings
    ADD CONSTRAINT flood_event_buildings_flood_event_id_fkey FOREIGN KEY (flood_event_id) REFERENCES public.hazard_event(id) ON DELETE CASCADE;
